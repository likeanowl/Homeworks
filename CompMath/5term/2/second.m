function second
    st;
end

function ft
    %1
    chord = [sqrt(2) - 1, 1];
    k = sqrt(2) - 1;
    point = 0;
    eps = 1;
    for i = 0: 0.0001: 1
        f = 1 / (2 * sqrt(i + 1));
        if (abs(k - f) < eps)
            point = i;
            eps = abs(k - f);
        end
    end
    fprintf('point = %0.3f\n', point);
    tangent = [sqrt(2) - 1, 1.017];
    poly = (chord + tangent) / 2;
    max = 0;
    l = 1;
    alts = [];
    for i = 0: 0.00001: 1
        if (abs(polyval(poly, i) - sqrt(i + 1)) > max)
            max = round(abs(polyval(poly, i) - sqrt(i + 1)), 8);
            alts = [];
            l = 1;
            alts(l) = i;
        elseif (round(abs(polyval(poly, i) - sqrt(i + 1)), 8) == max)
            l = l + 1;
            alts(l) = i;
        end
    end
    disp(polyval(poly, 0) - sqrt(1));
    disp(alts);
    fplot(@(x) sqrt(x + 1), [0, 1]);
    hold on
    plot(0:0.01:1, polyval(chord, 0:0.01:1), '--');
    hold on
    plot(0:0.01:1, polyval(tangent, 0:0.01:1), '-.');
    hold on
    plot(0:0.01:1, polyval(poly, 0:0.01:1));
    for i = 1: 3
        hold on
        circle(alts(i), polyval(poly, alts(i)), 0.005);
    end
    hold off
    legend('fun', 'chord', 'tangent', 'poly', 'Location', 'SouthEast');
    grid on
end

function circle(x,y,r)
    ang = 0: 0.01: 2 * pi; 
    xp = r * cos(ang);
    yp = r * sin(ang);
    plot(x + xp, y + yp);
end

function st
    poly = [1, 0, 0, 0, 0, 0];
    chebPoly = cheb(5);
    dPoly = poly - chebPoly / 2 .^ 4;
    %disp(dPoly);
    for i = 1: 5
        roots(i) = cos(((2 * i + 1) / 10) * pi);
    end
    for i = 1: 4
        extrs(i) = cos(i / 5 * pi);
    end
    max = -1;
    l = 1;
    alts = [];
    for i = -1: 0.0001: 1
        if (round(abs(i .^ 5 - (i .^ 5 - ch(i, 5))), 8) == max)
            l = l + 1;
            alts(l) = i;
        elseif (abs(i .^ 5 - (i .^ 5 - ch(i, 5))) > max)
            max = round(abs(i .^ 5 - (i .^ 5 - ch(i, 5))), 8);
            alts = [];
            l = 1;
            alts(l) = i;
        end
    end
    disp(roots);
    disp(extrs);
    disp(alts);
    plot(-1:0.01:1, polyval(poly, -1:0.01:1));
    hold on
    plot(-1:0.01:1, polyval(dPoly, -1:0.01:1));
    hold on
    plot(-1:0.01:1, polyval(chebPoly, -1:0.01:1));
    for i = 1: 6
        hold on
        circle(alts(i), polyval(dPoly, alts(i)), 0.02);
    end
    hold off
    legend('f(x)', 'P_n_-_1(x)', 'T_n(x)', 'Location', 'SouthEast');
    grid on
end

function b = cheb(n)
    pn = [];
    pnp1 = [1];
    for i = 1: n
        pnm1 = pn;
        pn = pnp1;
        pnp1 = (2 * [pn, 0] - [0, 0, pnm1]);
        pnp1 = pnp1 / polyval(pnp1, 1);
    end
    b = pnp1;
end

function a = ch(x, n)
    t1 = x;
    t2 = 1;
    for i = 2: 1: n
        t = t1;
        t1 = 2 * t1 * x - t2;
        t2 = t;
    end
    a = t1 / 2 .^ (n - 1);
end