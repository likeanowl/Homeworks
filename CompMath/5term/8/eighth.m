function eighth
    format long;
    ft;
end

function ft
    format long;
    root = round(0.588532743981862, 15);
    x0 = 1;
    n = 10;
    %Tangent method
    y1 = abs(root - tangent(x0, n));
    %Secant method
    y2 = abs(root - secant(x0, n));
    %Quadratic interpolation method
    y3 = abs(root - interpolation(x0, n));
    %Reversed interpolation method
    y4 = abs(root - reversedInt(x0, n));
    %Reversed function approximation by Tailor's row
    y5 = abs(root - tailor_rev(x0, n));
    %Forward apporximation by Tailor
    y6 = abs(root - tailor(x0, n));
    semilogy([1: 1: n], y1, '--');
    grid on;
    hold on;
    semilogy([1: 1: n], y2, '--+');
    semilogy([1: 1: n], y3, '-.');
    semilogy([1: 1: n], y4, '-.o');
    semilogy([1: 1: n], y5, '-.*');
    semilogy([1: 1: n], y6);
    legend('Tangents', 'Secants', 'Quadratic',...
        'Reversed interp', 'Reversed Tailor', 'Tailor');
end

function val = f(x)
    val = sin(x) - exp(-x);
end

function val = f1(x)
    val = cos(x) + exp(-x);
end

function val = f2(x)
    val = -sin(x) - exp(-x);
end

%Tangent method
function x = tangent(x0, n)
    x(1) = round(x0, 15);
    for i = 2: n
        x(i) = x(i - 1) - f(x(i - 1)) / f1(x(i - 1));
        x(i) = round(x(i), 15);
    end;
end

%Secant method
function x = secant(x0, n)
    x(1) = x0;
    x(2) = x0 - 2;
    for i = 2: n - 1
        x(i + 1) = x(i - 1) - f(x(i - 1)) * (x(i) - x(i - 1)) /...
            (f(x(i)) - f(x(i - 1)));
        x(i + 1) = round(x(i + 1), 15);
    end;
end

%Quadratic interpolation method
function x = interpolation(x0, n)
    x(1) = x0 - 1;
    x(2) = x0 - 0.5;
    x(3) = x0;
    for i = 3: n - 1
        x1 = [x(i - 2) x(i - 1) x(i)];
        div = divdif(x1);
        w = div(2, 2) + div(1, 3) * (x1(3) - x1(2));
        if w >= 0 
            t = 1; 
        else 
            t = - 1; 
        end; 
        x(i + 1) = (-w + t * sqrt(w * w - 4 * div(3, 1) * div(1, 3)))...
            / (2 * div(1, 3)) + x1(3);
        x(i + 1) = round(x(i + 1), 15);
    end;
end

%reversed interpolation method
function x = reversedInt(x0, n)
    format long;
    x(1) = x0 - 1.5;
    x(2) = x0 - 1;
    x(3) = x0 - 0.5;
    x(4) = x0;
    for i = 4: n - 1
        x1 = [x(i - 3) x(i - 2) x(i - 1) x(i)];
        y1 = f(x1);
        if (x(i) ~= x(i - 1))
            div = divdif1(y1, x1);
            x(i + 1) = newton(y1, div, 0);
        else
            x(i + 1) = x(i);
        end;
    end;
end

%Reversed Tailor
function x = tailor_rev(x0, n)
    x(1) = x0;
    for i = 1: n - 1
        x(i + 1) = x(i) - f(x(i)) / f1(x(i)) - (f2(x(i)) * (f(x(i))) ^ 2)...
            / (2 * (f1(x(i))) ^ 3);
        x(i + 1) = round(x(i + 1), 15);
    end;
end

%Tailor
function x = tailor(x0, n)
    x(1) = x0;
    for i = 1: n - 1 
        if (f1(x(i)) > 0)
            x(i + 1) = x(i) + (- f1(x(i)) + sqrt(((f1(x(i))) ^ 2)...
                -2 * f(x(i)) * f2(x(i)))) / f2(x(i));
        else
            x(i + 1) = x(i) + (- f1(x(i)) - sqrt(((f1(x(i))) ^ 2)...
                -2 * f(x(i)) * f2(x(i)))) / f2(x(i));
        end;
        x(i + 1) = round(x(i + 1), 15);
    end;
end

%Newton's poly
function value = newton(x, y, x0)
    n = size(x, 2);
    value = y(1, 1);
    w = 1;
    for i = 1: n - 1 
        w = w .* (x0 - x(i));
        value = value + y(1, i + 1) * w;
    end;
end

%Divided diffs
function arr = divdif(x)
    n = length(x);
    m = n - 1;
    arr = zeros(n, m + 1);
    for i = 1: n
        arr(i, 1) = f((x(i)));
    end;
    for j = 1: m
        for i = 1: n - j
            arr(i, j + 1) = (arr(i + 1, j) - arr(i, j)) / (x(j + i) - x(i));
        end;
    end;
end

%Divided divs for reversed interpolation
function arr = divdif1(x, y)
    n = length(x);
    m = n - 1;
    arr = zeros(n, m + 1);
    for i = 1: n
        arr(i, 1) = y(i);
    end;
    for j = 1: m
        for i = 1: n - j
            arr(i, j + 1) = (arr(i + 1, j) - arr(i, j)) / (x(j + i) - x(i));
        end;
    end;
end