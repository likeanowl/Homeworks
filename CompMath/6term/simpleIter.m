function simpleIter
    format long;
    A = [10.409187 1.2484191 -3.2136953;
         1.2494191 7.9045365 0.74772162;
         -3.2136953 0.74772162 6.2719819];
    b = [15.37747;
         1.015936;
         -8.595665];
    b1 = [2.6696963;
          -6.9807383;
          0.1542235];
    n = size(A);
    n = n(1);
    disp('Accurate:');
    disp(A \ b);
    [res, jacIter] = jacobi(A, b, 0.00001, 500);
    [res1, seigelIter] = seigel(A, b, n);
    disp('Nekrasov:');
    disp(seigelIter);
    disp(res1);
    disp('Simple iterations:');
    disp(jacIter);
    disp(res);
end

function [x, n] = jacobi(A, b, tol, maxit)
    %jacobi iterations
    x = ones(size(b));
    n = size(A);
    n = n(1);
    iter = 0;
    for i = 1: maxit
        for j = 1: n
            y(j) = (b(j) - A(j, 1: j - 1) * x(1: j - 1) - A(j, j + 1: n) ...
                * x(j + 1: n)) / A(j, j);
        end
        if max(abs(A * y' - b)) < tol
            break;
        end
        x = y';
        iter = i;
    end;
    n = iter;
end

function [x, n] = seigel(A, b, n)
    iter = 0;
    x = zeros(n, 1);
    error = ones(n, 1);
    while max(error) > 0.00001
        iter = iter + 1;
        curr = x;  % save current values to calculate error later
        for i = 1: n
            j = 1: n; % define an array of the coefficients' elements
            j(i) = [];  % eliminate the unknow's coefficient from the remaining coefficients
            Xtemp = x;  % copy the unknows to a new variable
            Xtemp(i) = [];  % eliminate the unknown under question from the set of values
            x(i) = (b(i) - sum(A(i, j) * Xtemp)) / A(i, i);
        end
        solution(:, iter) = x;
        error = sqrt((x - curr) .^ 2);
    end
    x = solution(:, end);
    n = iter;
end