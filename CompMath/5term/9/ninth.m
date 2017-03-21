function ninth
    tt;
    %disp(newton_sys(0.5, 1, 5));
end

function f = f(x,y)
    f = x ^ 2 + y ^ 2 - 1;
end

function g = g(x, y)
    g = exp(-x) - y;
end

function dfdx = dfdx(x)
    dfdx = 2 * x;
end

function dfdy = dfdy(y)
    dfdy = 2 * y;
end

function dgdx = dgdx(x)
    dgdx = -exp(-x);
end

function dgdy = dgdy()
    dgdy = -1;
end

function seq = newton_sys(x, y, n)
    for i = 1: n    
        val = [f(x, y); g(x, y)];
        jf = [dfdx(x) dfdy(y); dgdx(x) dgdy()];
        iter = [x; y] - jf ^ (-1) * val;
        if (i == 1)
            res = iter;
        end
        res = cat(2, res, iter);
        x = iter(1, 1);
        %fprintf('\nx = %f', x);
        y = iter(2, 1);
        %fprintf('\ny = %f', y);
        seq = res;
    end
end

function ft
    x0 = 0.5;
    y0 = 1;
    root = [0; 1];
    i = 1;
    for k = 1: 5
        iter = newton_sys(x0, y0, k);
        r(k) = sqrt((iter(1, i + 1) - root(1, 1)) ^ 2 + (iter(2, i + 1)...
            - root(2, 1)) ^ 2);
        i = i + 1;
    end;
    semilogy([1: 1: 5], r);
    grid on;
end

function st
    t = 0: pi / 100: 2 * pi;
    x0 = -2;
    y0 = 0;
    x = cos(t);
    y = sin(t);
    grid on;
    hold on;
    plot(x, y);
    x1 = -2: 0.01: 2;
    y1 = exp(-x1);
    plot(x1, y1);
    n = 5;
    root = newton_sys(x0, y0, n);
    disp(root(1, :));
    disp(root(2, :));
    plot(root(1, 6), root(2, 6), 'b*');
end

function q = sq(x, x1, y, y1)
    q = sqrt((x - x1) ^ 2 + (y - y1) ^ 2);
end

function tt
    format long;
    x = linspace(-2, 2, 200);
    y = linspace(-1, 8, 200);
    n = 5;
    n1 = 10;
    k = 1;
    l = 1;
    m = 1;
    d = 1;
    u = 1;
    points1 = zeros(2, 1);
    points2 = zeros(2, 1);
    points4 = zeros(2, 1);
    points5 = zeros(2, 1);
    for i = 1: 200
        for j = 1: 200
            root = newton_sys(x(i), y(j), n);
            root1 = newton_sys(x(i), y(j), n1);
            r_k = sq(0, root(1, 6), 1, root(2, 6)); 
            r_k1 = sq(0.916563, root(1, 6), 0.39998, root(2, 6));
            r1_k = sq(0, root1(1, 11), 1, root1(2, 11));
            r1_k1 = sq(0.916563, root1(1, 11), 0.39998, root1(2, 11));
            if (r_k < 10e-5)
                points1(1, k) = x(i);
                points1(2, k) = y(j);
                k = k + 1;
            end;
            if (r1_k < 10e-5)
                points4(1, d) = x(i);
                points4(2, d) = y(j);
                d = d + 1;
            end;
            if (r_k1 < 10e-5)
                points2(1, l) = x(i);
                points2(2, l) = y(j);
                l = l + 1;
            end;
            if (r1_k1 < 10e-5)
                points5(1, u) = x(i);
                points5(2, u) = y(j);
                u = u + 1;
            end;
            %{
            else
                points3(1, m) = x(i);
                points3(2, m) = y(j);
                m = m + 1;
            end;
            %}
        end;
    end;
    
    plot(points4(1, :), points4(2, :), 'y.');
    hold on;
    plot(points5(1, :), points5(2, :), 'b.');
    plot(points1(1, :), points1(2, :), 'r.');
    plot(points2(1, :), points2(2, :), 'c.');
    %plot(points3(1, :), points3(2, :), 'g.');
    %hold on;
    legend('n = 10', 'n = 10', 'n = 5', 'n = 5');
    hold off;
end