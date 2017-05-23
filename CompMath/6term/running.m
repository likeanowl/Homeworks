function running
    n = 100;
    h = 1 / n;
    t = 0: h: 1;
    p = @(x) sin(x) ./ sqrt(1 + x);
    q = @(x) 1 + x + x .* cos(x .^ 2);
    syms x
    f = symfun(1, x);%1./(1+x);
    al = -0.1;%0.3;  % -1 
    beta = 0.2;%1.2;%-12/5;;
    p = p(t);
    q = q(t);
    f = f(t);
    y = runningMethod(p, q, f, al, beta, n);
    plot(0: h: 1, y(1: n + 1), 'r');
    hold on;
    legend('running method');
    grid on;
    hold off;
    fprintf('n = %i\n',n);
    for i = 1: n / 10: n + 1 
        %solve(i) = (y(i + 1) - 2*y(i) + y(i - 1))/(h.^2) + p(i)*(y(i + 1) - y(i - 1))/(2*h) + q(i)*y(i);     
        %err(i) = abs(solve(i) - f(i));
        %fprintf('%d\n',err(i));
        fprintf('%d\t%d\n', y(i));
    end    
end

function y = runningMethod(p, q, f, al, beta, n)
    h = 1/n;
    u(1) = ((4 - 2 * (2 - h * h * q(2))/(2 + h * p(2))))...
        / (2 * h * al + 3 + (h * p(2) - 2) / (h * p(2) + 2));
    v(1) = -2 * h * h * f(2) / ((2 + h * p(2)) * (2 * h * al + 3 ...
        + (h * p(2) - 2) / (h * p(2) + 2))); 
    for i = 2: n
        a(i) = 1 + p(i) * h / 2; 
        b(i) = 2 - (h .^ 2) * q(i);
        c(i) = 1 - (h / 2) * p(i);
        g(i) = (h .^ 2) * f(i);
        u(i) = a(i) ./ (b(i) - c(i) * u(i - 1));
        v(i) = (c(i) * v(i - 1) - g(i)) ./ (b(i) - c(i) * u(i - 1));
    end
         kappa2 = (- 4 - (2 * q(n) * h * h - 4) / (2 - p(n) * h))...
             / (- 2 * beta * h - 3 + (h * p(n) + 2) / (2 - p(n) * h));
         nu2 = 2 * f(n) * h * h / ((2 - p(n) * h) * (- 2 * beta ...
             * h - 3 + (h * p(n) + 2) / (2 - p(n) * h)));
         y(n + 1) = (v(n) * kappa2 + nu2) / (1 - kappa2 * u(n));         
    for i = n: -1: 1
        y(i) = y(i + 1) * u(i) + v(i);       
    end
end
