function gauss
    a = [4.05 -3.50 -1 2.74 0;
         0 2.74 -2.25 2.25 1;
         0 0 4.33 3.45 -3.45;
         2.12 1 2.57 -4.33 0.29;
         2.64 -1.73 0 2.38 -3.04];
     b = [6.27; 12.48; 12.92; -12.02; 12.4];
     gaussMethod(a, b);
     x = gaussPivoting(a, b);
     disp(x);
end

function gaussMethod(A, B)
    r = size(A, 1);
    c = size(A, 2);
    disp('Matrix method');
    disp(A \ B);
    AB = [A, B];
    control = sum(AB, 2);
    disp('Control column:');
    disp(control);
    AB = [AB, control];
        if (rank(A) == rank(AB))
            if (rank(A) == c)
                %Forward
                k = 1;
                while k <= r
                    if(AB(k, k) ~= 0)
                        AB(k, :) = AB(k, :) / AB(k, k);
                        for i = k + 1: r
                            AB(i, :) = AB(i, :) - AB(k, :) * AB(i, k);
                        end
                        k = k + 1;
                    else
                        temp = AB(k, :);
                        AB(k, :) = [];
                        AB = [AB; temp];
                    end
                end
                disp('Control column after forward:');
                disp(AB(:, end));
                %Backward
                for i = r - 1: -1: 1
                    for k = i + 1: c
                        AB(i, :) = AB(i, :) - AB(k, :) * AB(i, k);
                    end
                end
                disp('Answer: ');
                disp(AB(:, r + 1));
                disp('Control column:');
                disp(AB(:, end));
            else
                disp('Multiple solutions');
            end
        else
            disp('No solutions');
        end
end
    
function [x_soln, nrow, A_aug] = gaussPivoting(A,B)
    %create the augmented matrix A|B
    Aug=[A B];
    n=rank(A);

    %initialize the nrow vector
    for i = 1: n
        nrow(i) = i;
    end
    nrow = nrow';

    for k = 1: n - 1
        max = 0;
        index = 0;

        %find the maximum value in the column under the current checked element and
        %return its row position
        for j = k: n
            if abs(Aug(nrow(j), k)) > max
                max = abs(Aug(nrow(j), k));
                index = j;
            end
        end
        %perform row exchange in the nrow vector
        if nrow(k) ~= nrow(index)
            ncopy = nrow(k);
            nrow(k) = nrow(index);
            nrow(index) = ncopy;
        end
        %Gaussian elimination
        for i = (k + 1): n
            m(nrow(i), k) = Aug(nrow(i), k) / Aug(nrow(k), k);
            for j = k: n + 1
                Aug(nrow(i), j) = Aug(nrow(i), j) ...
                    - m(nrow(i), k) * Aug(nrow(k), j);
            end
        end
    end
    %backward subsitution
    x(n) = 0;
    x = x';
    x(n) = Aug(nrow(n), n + 1) / Aug(nrow(n), n);
    i = n - 1;
    while i > 0
        x(i) = (Aug(nrow(i), n + 1) - Aug(nrow(i), i + 1: n) ...
            * x(i + 1: n)) / (Aug(nrow(i), i));
       i = i - 1;
    end
    x_soln = x;
    A_aug = Aug;
end
