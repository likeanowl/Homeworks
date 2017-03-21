function seventh
    format long;
    syms x;
    f = matlabFunction(sqrt(1 + (sin(x)) .^ 2));
    disp(f(2));
    disp(real(furieComp(2)));
    disp(real(idk(2)));
    %ft
end

function qt
    A = bigAh(0, pi, -4);
    A1 = bigAh(0, pi, 4);
    disp(A);
    disp(A1);
end

function ft
    format long;
    result = zeros(15, 6);
    int = integral(@(x) sqrt(sin(x) .^ 2 + 1), 0, pi);
    disp(int);
    int1 = rectangle(0, pi, 20);
    disp(int1);
    A_0 = cn(0);
    disp(A_0 * pi);
    for n = 2: 16
        result(n-1, 1) = n;
        result(n-1, 2) = abs(int - rectangle(0, pi, n));
        result(n-1, 3) = rTheorRectangle(0, pi, n);
        result(n-1, 4) = rungeRectangle(0, pi, n);
        result(n-1, 5) = rPeriodic(0, pi, n);
        result(n-1, 6) = rCorrect(n, 35);
    end;
    table = array2table(result, 'VariableNames', {'N', 'Fact', 'Theor',...
        'Runge', 'Periodic', 'CorrectPer'});
    disp(table);
end

function r = correctR(n, l)
    format long
    r = 0;
    for i = 1: n
        r = r + bigAh(i * l) + bigAh(-i * l);
    end;
    r = 2 * pi * r;
end

function qwerty
    syms x;
    func = matlabFunction(sqrt(1 + sin(x) ^ 2));
    int = integral(func, 0, 2 * pi);
    disp(int);
    int1 = 2 * pi * bigAh(0);
    disp(int1);
end

%Runge
function runge = rungeRectangle(a, b, n)
    format long;
    int1 = rectangle(a, b, n);
    int2 = rectangle(a, b, n / 2);
    runge = 4 * abs(int1 - int2) / 3;
end

function comparison
    sum1 = 0;
    syms x;
    for m = -100: 100
        func = matlabFunction(exp(1i * x * m));
        int = integral(func, 0, pi);
        sum1 = sum1 + bigAh(0, pi, m) * int;
    end;
    disp(sum1);
end

function fur = furieTrig(y)
    syms x;
    f = matlabFunction(sqrt(1 + (sin(x)) .^ 2));
    fur = 1 / pi * integral(f, -pi, pi) / 2;
    for i = 1: 100
        fur = fur + an(i) * cos(i * y) + bn(i) * sin(i * y);
    end
end

function a = an(n)
    syms x;
    f = matlabFunction(sqrt(1 + (sin(x)) .^ 2) * cos(n * x));
    a = 1 / pi * integral(f, -pi, pi);
end

function b = bn(n)
    syms x;
    f = matlabFunction(sqrt(1 + (sin(x)) .^ 2) * sin(n * x));
    b = 1 / pi * integral(f, -pi, pi);
end

function q = idk(x)
    q = 0;
    for k = -50: 50
        q = q + bigAh(k) * exp(1i * k * x);
    end
end

function c = furieComp(x)
    c = 0;
    for k = -100: 100
        c = c + cn(k) * exp(1i * k * x);
    end
end

function c = cn(k)
    format long;
    syms x;
    f = sqrt(1 + sin(x) .^ 2) * exp(-1i * k * x);
    c = 1 / (2 * pi) * integral(matlabFunction(f), -pi, pi);
end

function r = rCorrect(n, l)
    format long;
    r = 0;
    for i = 1: n
        r = r + cn(i * l) + cn(-i * l);
    end;
    r = 2 * pi * r;
end

function ah = bigAh(n)
    format long
    %{
    a = 0;
    b = pi;
    h = (b - a) / 1000;
    an = 0;
    bn = 0;
    %}
    syms x;
    f = sqrt(1 + (sin(x)) .^ 2);
    if (n ~= 0)
        funcA = matlabFunction(f * cos(2 * n * x));
        funcB = matlabFunction(f * sin(2 * n * x));
        a_n = (2 / pi) * integral(funcA, 0, pi);
        b_n = (2 / pi) * integral(funcB, 0, pi);
    else
        a_n = (2 / pi) * integral(matlabFunction(f), 0, pi);
        b_n = 0;
    end;
    %{
    for i = 1: 1000
        an = an + f(a + h * (i - 1) + (h / 2)) * cos((a + h * (i - 1)...
            + (h / 2)) * 2 * n) * h;
        bn = bn + f(a + h * (i - 1) + (h / 2)) * sin((a + h * (i - 1)...
            + (h / 2)) * 2 * n) * h;
    end
    %}
    ah = sqrt(a_n ^ 2 + b_n ^ 2);
end

%Periodical
function val = rPeriodic(a, b, n)
    %{
    h = (b - a) / 1000;
    an = 0;
    bn = 0;
    for i = 1: 1000
        an = an + f(a + h * (i - 1) + (h / 2)) * cos((a + h * (i - 1)...
            + (h / 2)) * n * 2) * h;
        bn = bn + f(a + h * (i - 1) + (h / 2)) * sin((a + h * (i - 1)...
            + (h / 2)) * n * 2) * h;
    end
    an = 2 * an / pi;
    bn = 2 * bn / pi;
    val = pi * sqrt(an ^ 2 + bn ^ 2);
    %}
    val = pi * bigAh(n);
end

function q = maxKsi(x0, x1)
    max_ksi = -Inf;
    for ksi = x0: 0.001: x1
        if (abs(f(ksi)) > max_ksi)
            max_ksi = abs(f(ksi));
            q = ksi;
        end;
    end;
end

%Theoretical
function r = rTheorRectangle(a, b, n)
    format long;
    r = 0;
    h = (b - a) ./ n;
    syms o;
    f = sqrt(1 + sin(o) ^ 2);
    f2 = matlabFunction(diff(f, 2));
    for x = (a + h / 2): h: (b - h / 2)
        ksi = maxKsi(x - h / 2, x + h / 2);
        r = r + (h .^ 3) * f2(ksi) / 24;
    end;
    r = abs(r);
end

%Rectangles
function val = rectangle(a, b, n)
    format long;
    h = (b - a) / n;
    val = 0;
    for i = 1: n
        val = val + f(a + h * (i - 1) + (h / 2)) * h;
    end
end

function y = f(x)
    y = sqrt(1 + (sin(x)) .^ 2);
end

