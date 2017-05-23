function main
    format long;
    %du/dt = d^2(u)/d(x^2) + f(x,t);
    %[0,1]
    sol = @(x,t) exp(-t/4)*cos(x/2) + x*(1 - x)/(10 + t);
    f = @(x,t) (-x*(1 - x)/(10 + t).^2 + 2/(10 + t));
    psi1 = @(t) exp(-t/4); %u(0,t)
    psi2 = @(t) exp(-t/4)*cos(1/2); %u(1,t)
    phi = @(x) cos(x/2) + x*(1 - x)/10;
    n = 10;
    h = 1/n;    
    T = 10000;
    [uimpl,limpl] = getsolImPlicitly(f,psi1,psi2,phi,n,T); 
    [upl,lpl] = getsolPlicitly(f,psi1,psi2,phi,n,T); 
    fprintf('n = %i, T = %i\n',n,T);
    for k = 1:T/10:T+1
        if k ~= 1
            k = k - 1;
        end
        fprintf('\nСлой номер: %i\n',k);
        for i = 1:1:n
            fprintf('%f\t',upl(i,k));
        end
        fprintf('\n');
        for i = 1:1:n
            fprintf('%f\t',uimpl(i,k));
        end       
%         fprintf('\n');
%         for i = 1:1:n
%             fprintf('%f\t',sol((i-1)*h,(k - 1)*limpl));    
%         end 
    end
    fprintf('\n');
    for i = 1:1:n
        fprintf('%Точное решение на последнем слое: f\t', sol((i - 1) * h, T * limpl));    
    end     
end

function [u,l] = getsolPlicitly(f, psi1,psi2,phi,n,T) %l - step by time
    h = 1/n;
    l = h.^2/2;
    for i =  1:n
        u(i,1) = phi((i - 1)*h);              
    end
    k = 1;
    while(k <= T);     
        u(1,k) = psi1((k - 1)*l);
        u(n+1,k) = psi2((k - 1)*l);   
        for i = 2:n
            u(i,k + 1) = u(i,k) + l*((u(i + 1,k) - 2*u(i,k) + u(i - 1,k))/h.^2 + f((i - 1)*h,(k - 1)*l));
        end
        k = k + 1;
    end
end

function [y,l] = getsolImPlicitly(f, psi1,psi2,phi,n,T) %l - step by time
    h = 1/n;
    l = h*h/2;
    for i = 1:n
        y(i,1) = phi((i - 1)*h);              
    end
    k = 2;
    while(k <= T)
        y(1,k) = psi1((k - 1)*l);
        y(n+1,k) = psi2((k - 1)*l);        
        v(1) = y(1,k); 
        u(1) = 0;        
        for i = 2:n
            a(i) = 1;
            b(i) = 2 + h*h/l;
            c(i) = 1;
            g(i) = -h*h*f((i)*h,(k)*l) - h*h*y(i,k-1)/l;
            u(i) = a(i)./(b(i) - c(i)*u(i - 1));
            v(i) = (c(i)*v(i - 1) - g(i))./(b(i) - c(i)*u(i - 1));
        end
        for i = n:-1:2
            y(i,k) = u(i)*y(i+1,k) + v(i);
        end
        k = k + 1;
    end
end