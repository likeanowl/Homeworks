function par
    format long
    n = 10;
    m = 10000;
    h1 = 1 / n;
    h2 = (h1 ^ 2) / 2;

    syms x
    syms t
    u_real = @(x, t) (exp(-4 * t) * sin(2 * x) + exp(-t) * (1 - x ^ 2));
    f = @(x, t) (exp(-t) * (x ^ 2 + 1));
    psi1 = @(t) (exp(-t));
    psi2 = @(t) (exp(-4 * t) * sin(2));
    phi = @(x) (sin(2 * x) + 1  - x ^ 2);
    [u1, h1] = explicit(n, m, f, psi1, psi2, phi);
    [u2, h2] = implicit(n, m, f, psi1, psi2, phi);
    
    fprintf('expl solution: \n');
    for i = 1 : n + 1
        fprintf('number %d: \n', (i - 1) * m / 10);
        fprintf('expl: ');
        for j = 1 : m / 10 : m
            fprintf('%f ', u1(i, j));
        end
        fprintf('\n');
        
        fprintf('impl: ');
        for j = 1 : m / 10 : m
            fprintf('%f ', u2(i, j));
        end
        fprintf('\n');
        
        fprintf('real: ');
        for j = 1 : m / 10 : m
            fprintf('%f ', u_real((i - 1) * h1, (j - 1) * h2));
        end
        fprintf('\n');
        
    end
end

function [u, h2] = explicit(n, m, f, psi1, psi2, phi)
    h1 = 1 / n;
    h2 = (h1 ^ 2) / 2;
    
    for i = 1 : n
        u(i, 1) = phi((i - 1) * h1);
    end
    
    for k = 1 : m + 1
        u(1, k) = psi1((k - 1) * h2);
        u(n + 1, k) = psi2((k - 1) * h2);
    end
    
    for k = 1 : m
        for i = 2 : n
            u(i, k + 1) = u(i, k) + h2 * ((u(i + 1, k) - 2 * u(i, k) + u(i - 1, k)) / h1 ^ 2 + f((i - 1) * h1, (k - 1) * h2)); 
        end
    end
end

function [y, h2] = implicit(n, m, f, psi1, psi2, phi)
    h1 = 1 / n;
    h2 = (h1 ^ 2) / 2;
    
    for i = 1 : n
        y(i, 1) = phi((i - 1) * h1);
    end
    
    for k = 1 : m + 1
        y(1, k) = psi1((k - 1) * h2);
        y(n + 1, k) = psi2((k - 1) * h2);
    end
    
    for k = 2 : m + 1
        v(1) = y(1, k);
        u(1) = 0;
        for i = 2 : n
            a(i) = 1 / (h1 ^ 2);
            b(i) = (1 / h2) + 2 / (h1 ^ 2);
            c(i) = 1 / (h1 ^ 2);
            g(i) = 0 - f(i * h1, k * h2) - y(i, k - 1) / h2;
            u(i) = a(i) / (b(i) - c(i) * u(i - 1));
            v(i) = (c(i) * v(i - 1) - g(i)) / (b(i) - c(i) * u(i - 1));
        end
        
        for i = n : -1 : 2
            y(i, k) = u(i) * y(i + 1, k) + v(i);
        end
    end

end