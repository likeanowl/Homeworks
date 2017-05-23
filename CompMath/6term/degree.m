function degree
    format long; 
    a = [1.42 7.45 0.38;
         7.45 1.61 0.56;
         0.38 0.56 0.82];
    degreeMethod(a);
end

function degreeMethod(matrix)
    y0 = [1 1 1]';
    display(y0');
    y1 = y0;
    lambda0 = [0 0 0]';
    lambda1 = lambda0;
    counter = 0;
    lambda = 0;

    while 1
        counter = counter + 1;
        disp(counter);
        y1 = matrix * y0;
        for i = 1 : 3
            lambda1(i) = y1(i) / y0(i);
        end
        disp(lambda1');
        f = 0;
        if (counter > 1)
            for i = 1 : 3
                if (abs(lambda1(i) - lambda0(i)) <= 0.0000001)
                    lambda = lambda1(i);
                    f = 1;
                    break;
                end
            end
        end

        if (f == 1)
            break;
        end

        y0 = y1;
        lambda0 = lambda1;
    end

    disp(counter);
    disp(lambda);
end