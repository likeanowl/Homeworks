function squares
    accurateSo1 = [];
    disp(accurateSo1);
    A = [2.01 1.74 -1.5 0.79;
         1.74 1.78 -1.5 0.42;
         -1.5 -1.5 -2.01 1.29;
         0.79 0.42 1.29 1.12];
    B = [1.839982; -0.0098874; 0.2280756; 1.5350454];
    n = size(A);
    n = n(1);
    L = zeros(n, n);
    L(1, 1) = sqrt(A(1, 1));
    for i = 1: n
        L(i, 1) = A(i, 1) / L(1, 1);
    end;
    for i = 2: n
        s = 0;
        for p = 1: i - 1
            s = s + L(i, p) * L(i, p); 
        end;
        L(i, i) = sqrt(A(i, i) - s);
        s = 0;
        for j = i + 1: n
            if (i ~= n)
                for p = 1: i - 1
                    s = s + L(i, p) * L(j, p);
                end;
                L(j, i) = (A(j, i) - s) / L(i, i);
            end;
        end;
    end;
    LT = L.';
    disp(L);
    disp(LT);
    disp(L \ LT);
    Y = linsolve(LT, B);
    disp('S(T) * y = b; y = ');
    disp(Y);
    X = linsolve(L, Y);
    accurateSol = linsolve(L, Y);
    disp('S * x = y; x = ');
    disp(X);
    disp('accurate solution');
    accurateSo1 = linsolve(A, B);
    disp(accurateSol);















    accurateSo1 = accurateSo1 - 1;
end