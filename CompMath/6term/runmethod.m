function runmethod
    format long;
    a = 0;
    b = 1;
    n = 100;
    h = (b - a) / n;
    A = 0.4;
    B = 0.5;
    a1 = 1;
    a2 = -0.1;
    b1 = 1;
    b2 = 0.2;

    p = @(x) sin(x) ./ sqrt(1 + x);
    q = @(x) 1 + x + x .* cos(x .^ 2);

    syms x
    f = symfun(1, x);
    [y2, u2, v2] = run01(A, B, a1, a2, b1, b2, p, q, f, h * 10, 10);
    y2 = y2(1:10);
    t = table(y2', u2', v2', 'VariableNames', {'y', 'u', 'v'});
    disp(t);
    [y1, u1, v1] = run01(A, B, a1, a2, b1, b2, p, q, f, h, 100);
    y1 = y1(1: 10: 100);
    u1 = u1(1: 10: 100);
    v1 = v1(1: 10: 100);
    t1 = table(y1', u1', v1', 'VariableNames', {'y', 'u', 'v'});
    disp(t1);
    %test;
end

function [yi, u, v] = run01(A, B, a1, a2, b1, b2, p, q, f, h, n)
    a = 0;
    xi = zeros(1, n + 1);
    yi = zeros(1, n + 1);
    fi = zeros(1, n + 1);
    gi = zeros(1, n + 1);
    pj = zeros(1, n + 1);
    qi = zeros(1, n + 1);
    C = zeros(n + 1, n + 1);
    
    %forward
    for i = 1 : (n + 1)
        xi(i) = a + (i - 1) * h;
        fi(i) = f(a + (i - 1) * h);
        pj(i) = p(a + (i - 1) * h);
        qi(i) = q(a + (i - 1) * h);
        gi(i) = (h ^ 2) * fi(i);
    end

    for j = 2 : n
        C(j, j - 1) = 1 - (h * pj(j) / 2);
        C(j, j) = (h ^ 2) * qi(j) - 2; 
        C(j, j + 1) = 1 + (h * pj(j) / 2);
    end

    C(1, 1) = 1;
    C(1, 2) = (a2 / (a1 * h - a2));
    C(n + 1, n) = 0 - (b2 / (b1 * h + b2));
    C(n + 1, n + 1) = 1;
    gi(1) = A * h / (a1 * h - a2);
    gi(n + 1) = B * h / (b1 * h + b2); 

    u = zeros(1, n);
    v = zeros(1, n);
    u(1) = 0 - C(1, 2);
    v(1) = gi(1);

    for i = 2 : n
        u(i) = C(i, i + 1) / (0 - C(i, i) - (C(i, i - 1) * u(i - 1)));
        v(i) = (C(i, i - 1) * v(i - 1) - gi(i)) / (0 - C(i, i) - (C(i, i - 1) * u(i - 1)));
    end

    D = [C(n + 1, n), C(n + 1, n + 1); 1, 0 - u(n)];
    E = [gi(n + 1), v(n)]';
    z = linsolve(D, E);
    yi(n + 1) = z(2);
    
    %backward
    for i = n : -1 : 1
        yi(i) = u(i) * yi(i + 1) + v(i);
    end

    grid on;
    hold on;
    semilogy(xi, yi);
end

function test
    sol = @(x) x.^3 + 4*x.^2 + x - 1;
    n = 10;
    h = 1/n;
    t = 0:h:1;
    fp = @(x) exp(x); %exp(x);
    fq = @(x) x.^2; %- x - 1; %x.^2
    ff = @(x) 6.*x + 8 + exp(x)*3.*x.^2 + exp(x)*8.*x + x.^5 + 4.*x.^4 - x.^2 + exp(x) + x.^3;%1./(1+x);
    al = -1;%0.3;  % -1 
    beta = -12/5;%1.2;%-12/5;;
    p = fp(t);
    q = fq(t);
    f = ff(t);
    y = run0l(p, q, f, al, beta, n);
    plot(0:h:1,y(1:n+1),'r');
    hold on;
    plot(t,sol(t));
    legend('Run solution','Precision solution');
    grid on;
    fprintf('n = %i\n',n);
    for i = 1:n/10:n+1 
        %solve(i) = (y(i + 1) - 2*y(i) + y(i - 1))/(h.^2) + p(i)*(y(i + 1) - y(i - 1))/(2*h) + q(i)*y(i);     
        %err(i) = abs(solve(i) - f(i));
        %fprintf('%d\n',err(i));
        fprintf('%d\t%d\n',y(i), sol((i - 1)*h));
    end
end






































































function y = run0l(p, q, f, al, beta,n)
    h = 1/n;
    u(1) = ((4 - 2*(2 - h*h*q(2))/(2 + h*p(2))))/(2*h*al + 3 + (h*p(2) - 2)/(h*p(2) + 2));
    v(1) = -2*h*h*f(2)/((2 + h*p(2))*(2*h*al + 3 + (h*p(2) - 2)/(h*p(2) + 2))); 
    for i = 2:n
        a(i) = 1 + p(i)* h/2; 
        b(i) = 2 - (h.^2)*q(i);
        c(i) = 1 - (h/2)*p(i);
        g(i) = (h.^2)*f(i);
        u(i) = a(i)./(b(i) - c(i)*u(i - 1));
        v(i) = (c(i)*v(i - 1) - g(i))./(b(i) - c(i)*u(i - 1));
    end
         kappa2 = (- 4 - (2*q(n)*h*h - 4)/(2 - p(n)*h))/(-2*beta*h - 3 +(h*p(n) + 2)/(2 - p(n)*h));
         nu2 = 2*f(n)*h*h/((2 - p(n)*h)*(-2*beta*h - 3 + (h*p(n) + 2)/(2 - p(n)*h)));
         y(n + 1) = (v(n)*kappa2 + nu2)/(1 - kappa2*u(n));         
    for i = n:-1:1
        y(i) = y(i + 1)*u(i) + v(i);       
    end
end

