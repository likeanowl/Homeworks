function jacobi
    format long; 
    a = [1.42 7.45 0.38;
         7.45 1.61 0.56;
         0.38 0.56 0.82];
     jacobiMethod(a);
end 

function jacobiMethod(matrix)
    tempMatrix1 = matrix;
    tempMatrix2 = matrix;
    diag = [0 0 0;
            0 0 0;
            0 0 0];
    temp = [1 0 0;
            0 1 0;
            0 0 1];
    counter = 0; 
    while 1
        disp(counter);
        disp(tempMatrix1);
        counter = counter + 1;
        diag(1, 1) = tempMatrix1(1, 1);
        diag(2, 2) = tempMatrix1(2, 2);
        diag(3, 3) = tempMatrix1(3, 3);
        temp = abs(tempMatrix1 - diag);
        [m, n] = max(temp(:));
        [i, j] = ind2sub(size(tempMatrix1), n);
        if (m <= 0.0000000000000000000000001)
            break;
        end
        d = sqrt((tempMatrix1(i, i) - tempMatrix1(j, j)) ^ 2 + 4 * (tempMatrix1(i, j) ^ 2));
        c = sqrt((1/2) * (1 + (abs(tempMatrix1(i, i) - tempMatrix1(j, j))) / d));
        c1 = sqrt((1/2) * (1 - (abs(tempMatrix1(i, i) - tempMatrix1(j, j))) / d));
        s = sign(tempMatrix1(i, j) * (tempMatrix1(i, i) - tempMatrix1(j, j))) * c1; 
        
        tempMatrix2 = tempMatrix1;
        tempMatrix2(i, i) = (c^2) * tempMatrix1(i, i) + 2 * c * s * tempMatrix1(i, j) + (s^2) * tempMatrix1(j, j);
        tempMatrix2(j, j) = (s^2) * tempMatrix1(i, i) - 2 * c * s * tempMatrix1(i, j) + (c^2) * tempMatrix1(j, j);
        tempMatrix2(i, j) = 0;
        tempMatrix2(j, i) = 0;

        for k = 1 : 3   
            if (k ~= i && k ~= j)
                tempMatrix2(k, i) = c * tempMatrix1(k, i) + s * tempMatrix1(k, j);
                tempMatrix2(i, k) = tempMatrix2(k, i);
                tempMatrix2(k, j) = c * tempMatrix1(k, j) - s * tempMatrix1(k, i);
                tempMatrix2(j, k) = tempMatrix2(k, j);
            end
        end

        tempMatrix1 = tempMatrix2;
        temp = [1 0 0;
                0 1 0;
                0 0 1];
    end
    disp(counter);
    disp(tempMatrix1);
end