function fifth
    eigtht;
end

%rect
function val = rectangle(a, b, n)
    format long;
    h = (b - a) / n;
    val = 0;
    for i = 1: n
        val = val + f(a + h * (i - 1) + (h / 2)) * h;
    end;
end

%trapezies
function val = tr(a, b, n)
    format long;
    val = 0;
    h = (b - a) / (n - 1);
    for i = 1: (n - 1)
        val = val + ((f(a + (i - 1) * h) + f(a + i * h)) * h) / 2;
    end;
end

%Simpson
function sum = simpson(a, b, n)
    format long;
    h = (b - a) / (n - 1);
    x0 = a;
    x1 = a + h;
    sum = 0;
    for i = 1: 1: n - 1
        sum = sum + (f(x0) + 4 * f(x0 + h / 2) + f(x1)) * h / 6;
        x0 = x0 + h;
        x1 = x1 + h;
    end;
end

%Runge's for Rec
function runge1 = rungeRectangle(a, b, n)
    format long;
    n1 = (n - 1) / 2;
    int1 = rectangle(a, b, n);
    int2 = rectangle(a, b, n1);
    runge1 = 4 * abs(int1 - int2) / 3;
end

%Runge's for Tr
function runge2 = rungeTr(a, b, n)
    format long e;
    n1 = (n - 1) / 2;
    int1 = tr(a, b, n);
    int2 = tr(a, b, n1);
    runge2 = abs(int1 - int2) / 3;
end

%Runge's for Simpson
function runge3 = rungeSimpson(a, b, n)
    format long e;
    n1 = (n - 1) / 2;
    int1 = simpson(a, b, n);
    int2 = simpson(a, b, n1);
    runge3 = abs(int1 - int2) / (15);
end

%Theor err rect
function r1 = R_rec(a, b, n)
    r1 = 0;
    h = (b - a) / n;
    for x = (a + h / 2): h: (b - h / 2)
        r1 = r1 + (h .^ 3) * g(x) / 24;
    end;
    r1 = abs(r1);
end

%Theor err trap
function r2 = R_trap(a, b, n)
    format long e;
    h = (b - a)./ (n - 1);
    r2 = 0;
    for x = (a + h / 2): h: (b - h / 2)
        r2 = r2 + (-(h .^ 3)) * g(x) / 12;
    end;
    r2 = abs(r2);
end

%Theor err Simpson
function r3 = R_simpson(a, b, n)
    h = (b - a) / (n - 1);
    r3 = 0;
    for x = (a + h / 2): h: (b - h / 2)
        r3 = r3 + (h .^ 5) * q(x) / 90;
    end;
    r3 = abs(r3);
end

function ft
    format long;
    a = 0;
    b = 0.4;
    int = integral(@(x) sqrt(x + 1), a, b);
    int1 = rectangle(a, b, 5);
    int2 = tr(a, b, 5);
    %disp(int2);
    int3 = simpson(a, b, 5);
    %disp(int3);
    %fprintf('\n-----------\n');
    fact_err1 = abs(int1 - int);
    %disp(fact_err1);
    fact_err2 = abs(int2 - int);
    %disp(fact_err2);
    fact_err3 = abs(int3 - int);
    %disp(fact_err3);
    %fprintf('\n-----------\n');
    th_err1 = R_rec(a, b, 5);
    disp(th_err1);
    th_err2 = R_trap(a, b, 5);
    disp(th_err2);
    th_err3 = R_simpson(a, b, 5);
    disp(th_err3);
    %fprintf('\n-----------\n');
    runge_err1 = rungeRectangle(a, b, 5);
    %disp(runge_err1);
    runge_err2 = rungeTr(a, b, 5);
    %disp(runge_err2);
    runge_err3 = rungeSimpson(a, b, 5);
    %disp(runge_err3);
    %fprintf('\n-----------\n');
end

function fiftht
    n = 5;
    int = integral(@(x) sqrt(x + 1), 0, 0.4);
    for i = 1: 9
        x(i) = n;
        y1(i) = abs(rectangle(0, 0.4, x(i)) - int);
        y2(i) = R_rec(0, 0.4, x(i));
        y3(i) = rungeRectangle(0, 0.4, x(i));
        n = n + 2;
    end;
    semilogy(x, y2, '--');
    hold on;
    grid on;
    semilogy(x, y3, '-.');
    semilogy(x, y1, '*');
    legend('Theorethical','Runge','Fact');
end

function sixtht
    n = 5;
    int = integral(@(x) sqrt(x + 1), 0, 0.4);
    for i = 1: 9
        x(i) = n;
        y1(i) = abs(int - tr(0, 0.4, x(i)));
        y2(i) = R_trap(0, 0.4, x(i));
        y3(i) = rungeTr(0, 0.4, x(i));
        n = n + 2;
    end;
    semilogy(x, y1, '--');
    hold on;
    semilogy(x, y2, '-.');
    semilogy(x, y3, 'r*');
    grid on;
    legend('Fact','Theoretical','Runge');
end

function seventht
    n = 5;
    int = integral(@(x) sqrt(x + 1), 0, 0.4);
    disp(int);
    for i = 1: 5
        x(i) = n;
        y1(i) = abs(simpson(0, 0.4, x(i)) - int);
        disp(simpson(0, 0.4, x(i)));
        y2(i) = R_simpson(0, 0.4, x(i));
        y3(i) = rungeSimpson(0, 0.4, x(i));
        n = n + 4;
    end;
    semilogy(x, y1, '--');
    hold on;
    semilogy(x, y2, '-.');
    semilogy(x, y3, 'r*');
    grid on;
    legend('Fact', 'Theor', 'Runge');
 end

function eigtht
    int = integral(@(x) f(x), 0, 0.4);
    n = 5;
    for i = 1: 9
        x(i) = n;
        y1(i) = abs(rectangle(0, 0.4, x(i)) - int);
        %y2(i) = abs(tr(0, 0.4,x(i)) - int);
        y3(i) = abs(simpson(0, 0.4, x(i)) - int);
        n = n + 2;
    end;
    semilogy(x, y1, '--');
    hold on;
    %semilogy(x,y2,'-.');
    semilogy(x, y3, 'r*');
    grid on;
    legend('Rectangles', 'Simpson');
end

function q = doptask
    int = integral(@(x) f(x), 0, 0.4);
    disp(int);
    y1 = R_rec(0, 0.4, 9);
    y2 = R_simpson(0, 0.4, 9);
    x = linspace(0, 0.4, 1000);
    semilogy(x, f(x));
    hold on;
    disp(y1);
    disp(y2);
end

function y = f(x)
    y = exp(200 * x);
end

function y = g(x)
    y = exp(x);
end

function y = q(x)
    y = exp(x);
end