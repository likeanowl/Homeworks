function sixth
    ft;
end

function val = f(x)
    val = sqrt(2 + x);
end

function val = intgauss(a, b, n)
     val = 0;
     d1 = (b - a) / 2;
     d2 = (b + a) / 2;
     [c, x] = getgauss(n);
     for i = 1: n
         val = val + c(i) * f(d1 * x(i) + d2);
     end;
     val = val * d1;
end

function r = R_gauss(a, b, n)
    x0 = 0: 0.0001: 0.4;
    syms u
    diff2n = matlabFunction(diff(sqrt(u + 2), 2 * n));
    est = max(abs(diff2n(x0)));
    r = ((b - a) ^ (2 * n + 1)) * (factorial(n) ^ 4) * est / (2 * n + 1)...
        / (factorial(2 * n) ^ 3);
end

function [c, x] = getgauss(n)
    if (n == 1) 
        x(1) = 0;
        c(1) = 2;
    elseif (n == 2)
        x(1) = -1 / sqrt(3); 
        c(1) = 1;
        x(2) = 1 / sqrt(3); 
        c(2) = 1;            
    elseif (n == 3)
        x(1) = -sqrt(3 /  5); 
        c(1) = 5 / 9;
        x(2) = 0; 
        c(2) = 8 / 9;
        x(3) = sqrt(3 / 5); 
        c(3) = 5 / 9;            
    elseif (n == 4)        
        x(1) = -sqrt(3 / 7 + 2 / 7 * sqrt(6 / 5)); 
        c(1) = (18 - sqrt(30)) / 36;
        x(2) = -sqrt(3 / 7 - 2 / 7 * sqrt(6 / 5)); 
        c(2) = (18 + sqrt(30)) / 36;
        x(3) = sqrt(3 / 7 - 2 / 7 * sqrt(6 / 5)); 
        c(3) = (18 + sqrt(30)) / 36;            
        x(4) = sqrt(3 / 7 + 2 / 7 * sqrt(6 / 5)); 
        c(4) = (18 - sqrt(30)) / 36;            
    elseif (n == 5)
        x(1) = -1 / 3 * sqrt(5 + 2 * sqrt(10 / 7)); 
        c(1) = (322 - 13 * sqrt(70)) / 900;
        x(2) = -1 / 3 * sqrt(5 - 2 * sqrt(10 / 7)); 
        c(2) = (322 + 13 * sqrt(70)) / 900;
        x(3) = 0; 
        c(3) = 128 / 225;
        x(4) = 1 / 3 * sqrt(5 - 2 * sqrt(10 / 7)); 
        c(4) = (322 + 13 * sqrt(70)) / 900;            
        x(5) = 1 / 3 * sqrt(5 + 2 * sqrt(10 / 7)); 
        c(5) = (322 - 13 * sqrt(70)) / 900;            
    end;
end

function val = intmeler(n)
    for i = 1: n 
        xk(i) = cos(((2 * i - 1) / (2 * n)) * pi);
    end;
    val = 0;
    c = pi / n; 
    g = @(x) sqrt(x + 2);
    for i = 1: n
        val = val + c * g(xk(i));
    end;
end

function val = polymeler(n, g)
    for i = 1: n 
        xk(i) = cos(((2 * i - 1) / (2 * n)) * pi);
    end;
    val = 0;
    c = pi / n;
    evaled = polyval(g, xk);
    for i = 1: n
        val = val + c * evaled(i);
    end;
end

function r = R_meler(n)
    format long e;
    syms a
    r = matlabFunction(diff(sqrt(a + 2), 2 * n));
    max_s = -Inf;
    for i = -1: 0.01: 1
        if (abs(r(i)) > max_s && abs(r(i)) < Inf)
            max_s = abs(r(i));
        end;
    end;
    r = pi * max_s / ((2 .^ (2 * n - 1)) * factorial(2 * n));
end

function ft
    format long e;
    a = 0;
    b = 0.4;
    f = @(x) sqrt(x + 2);
    int = integral(f, 0, 0.4);
    result = zeros(4, 3);
    disp(int);
    for i = 1: 4 
        result(i, 1) = intgauss(a, b, i);
        result(i, 2) = abs(int - result(i, 1));
        result(i, 3) = abs(R_gauss(a, b, i));
    end;
    disp('          Rounded                 Fact. mistake              Theor. mistake');
    disp(result);
end

function st
    format long e;
    n1 = 40;
    syms a
    g = matlabFunction(sqrt(a + 2) / sqrt(1 - a .^ 2));
    int = integral(g, -1, 1);
    disp(int);
    int1 = intmeler(n1);
    disp(int1);
    i = 0;
    for n = 1: 7
        i = i + 1;
        x(i) = n;
        y1(i) = abs(int - intmeler(n));
        y2(i) = R_meler(n);
    end;
    semilogy(x, y1, '-*');
    grid on;
    hold on;
    semilogy(x, y2, '-^');
    legend('Fact', 'Theor');
end

function tt
    format long;
    n = 4;
    table = zeros(5, 3);
    syms x;
    weight = sqrt(1 - x ^ 2);
    for i = n: 8
        poly_n = ones(1, 2 * i);
        poly_n1 = ones(1, 2 * i + 1);
        table(i - n + 1, 1) = i;
        sympoly = poly2sym(poly_n);
        sympoly1 = poly2sym(poly_n1);
        func = matlabFunction(sympoly / weight);
        func1 = matlabFunction(sympoly1 ./ weight);
        int = integral(func, -1, 1);
        int1 = integral(func1, -1, 1);
        table(i - n + 1, 2) = abs(int - polymeler(i, poly_n));
        table(i - n + 1, 3) = abs(int1 - polymeler(i, poly_n1));
    end;
    table1 = array2table(table, 'VariableNames',{'n', 'a', 'b'});
    disp(table1);
end