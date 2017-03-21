function third
    format long
    [q, h] = tt;
    hold on;
    grid on;
    plot(h, q);
    hold off;
end

function a = ft
    a = finDiff(0, 0.1, 11, 10);
end

function b = st
    x = [0.5, 0.6, 0.4, 0.7, 0.3];
    y = [sqrt(1.5), sqrt(1.6), sqrt(1.4), sqrt(1.7), sqrt(1.3)];
    b = splitDiff(x, y, 4);
end

function [a, h] = tt
    syms x;
    f = sqrt(x + 1);
    f1 = matlabFunction(diff(f, 4));
    f2 = matlabFunction(f);
    r = f1(0.5);
    l = 1;
    for i = 0.001: 0.001: 0.5
        x = linspace(0.5 - i, 0.5 + i, 5);
        disp(x);
        h(l) = x(2) - x(1);
        y = arrayfun(f2, x);
        k = splitDiff(x, y, 4);
        res(l) = abs(k(1, 5) * 24 - r);
        l = l + 1;
    end;
    a = res;
end

%function a = xSpace(h)
%    a(1) = 0.3;
%    for i = 2: 4
%        a(i) = a(i - 1) + h;
%    end;
%    a(5) = 0.7;
%end

function f = finDiff(a, b, n, m)
    j = 1;
    arr = zeros(n, m + 1);
    for i = a: (b - a) / (n - 1): b
        arr(j, 1) = sqrt(i + 1);
        j = j + 1;
    end
    for l = 1: 1: m
        for i = 1: 1: n - l
            arr(i, l + 1) = arr(i + 1, l) - arr(i, l);
        end
    end
    f = arr;
end

function g = splitDiff(x, y, m)
    n = numel(y);
    a = zeros(numel(y), m + 1);
    for i = 1: n
        a(i, 1) = y(i);
    end
    for j = 1: n
        for i = 1: m - j + 1
            a(i, j + 1) = (a(i + 1, j) - a(i, j)) / (x(i + j) - x(i));
        end
    end
    g = a;
end