function fourth
    format short
    tt;
end

function z = f(x)
    z = sin(20 * x) .* exp(-5 .* x);
end

function interp
    n = 3;
    h = 1 / (n - 1);
    for i = 0: n - 1
        x(i + 1) = i * h;
    end;
    y = f(x);
    x1 = 0: 0.001: 1;
    y1 = f(x1);
    y2 = lagrange(x, y, x1);
    %hold on;
    %grid on;
    %plot(x1, y1);
    %plot(x1, y2, '--');
    %plot(x, y, 'r.');
    %legend('f(x)', 'P_{2}');
    r = 0;
    for i = 0: 1000 
        t = i * 0.001;
        r = max(r, abs(f(t) - lagrange(x, y, t)));
    end;
    disp(r);
end

%first
function ft
    n = 21;
    h = 1 / (n - 1);
    for i = 0: n - 1
        x(i + 1) = i * h;
    end;
    y = f(x);
    x1 = 0: 0.001: 1;
    y1 = f(x1);
    y2 = lagrange(x, y, x1);
    hold on;
    grid on;
    plot(x1, y1);
    plot(x1, y2, '--');
    plot(x, y, 'r.');
    legend('f(x)', 'L_{n-1}', 'nodes');
    r = 0;
    for i = 0: 1000
        t = i * 0.001;
        r = max(r, abs(f(t) - lagrange(x, y, t)));
    end;
    disp(x);
    disp(y);
end

%second
function st
    n = 5;
    h = 1 / (n - 1);
    for i = 0: n - 1
        x(i + 1) = i * h;
    end;
    y = divdif(x);
    z = findif(0, 1, n, n - 1);
    x1 = 0: 0.001: 1;
    y3 = f(x);
    y1 = f(x1);
    y2 = newtonDiv(x, y, x1);
    hold on;
    grid on;
    plot(x1, y1);
    plot(x1, y2, '--');
    hold off;
    %
    %
    %plot(x, y3, 'r.');
    %legend('f(x)', 'P_{n-1}', 'notes', 'new Newton');
end

%third task
function tt
    n = 3;
    h = 1 / (n - 1);
    for i = 0: n - 1
        notes(i + 1) = i * h;
    end;
    disp(notes);
    x1 = 0: 0.001: 1;
    div = divdif(notes);
    disp(div);
    oldPoly = newtonDiv(notes, div, x1);
    grid on;
    hold on;
    plot(x1, f(x1), '-.');
    hold off;
    %{
    notes(6) = 0.1;
    newDiv = divdif(notes);
    yad = newDivDifs(notes, div);
    disp(newDiv);
    disp(yad);
    hold on;
    grid on;
    plot(x1, f(x1));
    plot(x1, newtonDiv(notes, newDiv, x1), '--');
    plot(x1, newNewton(notes, yad, x1, oldPoly), '*');
    plot(notes, f(notes), 'r.');
    hold off;
    hold on;
    plot(x1, newtonDiv(x, y, x1), '-.');
    plot(x1, newNewton(x, y, x1, oldPoly), '*');
    plot(x1, newtonDiv(x, div, x1), '--');
    legend('1', 'corr', 'uncorr')
    %}
    j = 1;
    ordNotes = notes;
    for i = 4: 4
        d = numel(notes) + 1;
        notes(d) = ordNotes(j) + h / 2;
        if (d - j == 2)
            j = 1;
            h = h / 2;
        else
            j = j + 2;
        end;
        ordNotes = sort(notes);
        %disp(ordNotes);
        div = newDivDifs(notes, div);
        disp(div);
        q = newNewton(notes, div, x1, oldPoly);
        oldPoly = q;
        hold on;
        plot(x1, newtonDiv(notes, div, x1));
        hold off;
    end;
    hold on
    plot(notes, f(notes), 'r.');
end

%finite differencies
function arr = findif(a, b, n, m)
    arr = zeros(n, m + 1);
    h = (b - a) / (n - 1);
    for i = 0: n - 1
        x = a + h * i;
        arr(i + 1, 1) = f(x);
    end;
    for j = 2: m + 1
        for i = 0: n - j
            arr(i + 1, j) = arr(i + 2, j - 1) - arr(i + 1, j - 1);
        end;
    end;
end

%Newton by divided differences
function q = newtonDiv(x, y, x0)
    n = size(x, 2);
    q = y(1, 1);
    w = 1;
    for i = 1: n-1 
        w = w .* (x0 - x(i));
        q = q + y(1, i + 1) * w;
    end;
end

function difs = newDivDifs(x, y)
    n = numel(x);
    y(n, 1) = f(x(n));
    y(1, n) = 0;
    for i = 1: n - 1
        y(n - i, i + 1) = (y(n - i + 1, i) - y(n - i, i)) / (x(n) - x(n - i));
    end;
    difs = y;
end

function g = newNewton(notes, y, x0, old)
    n = numel(notes);
    q = @(x) (x - notes(1));
    for i = 2: n - 1
        f = @(x) (x - notes(i));
        q = @(x) q(x) .* f(x); 
    end;
    r = q(x0);
    g = old + y(1, n) .* r;
end

%Newton straight-forward
function q = newtonFin(x, y, x0)
    n = size(x, 2);
    q = y(1, 1);
    t = (x0 - x(1)) / (x(2) - x(1));
    c = t;
    for i = 1: n-2
        q = q + c * y(1, i + 1);
        c = c .* (t - i) / (i + 1);
    end;
end

%Lagrange
function q = lagrange(x, y, x0)
    n = size(x, 2);
    q = 0;
    for k = 1: n
        l_k = 1;
        for j = 1: n 
            if (j ~= k)
                l_k = l_k .* (x0 - x(j)) / (x(k) - x(j));
            end;
        end;
        q = q + l_k * y(k);
    end;
end

%Divided difs
function q = divdif(x)
    n = length(x);
    m = n - 1;
    q = zeros(n, m + 1);
    for i = 1: n
        q(i, 1) = f((x(i)));
    end;
    for j = 1: m
        for i = 1: n - j
            q(i, j + 1) = (q(i + 1, j) - q(i, j)) / (x(j + i) - x(i));
        end;
    end;
end
