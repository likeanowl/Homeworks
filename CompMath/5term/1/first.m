function first
    n = input('\ndegree: ');
    fprintf('\ncoefficients from lowest to highest: ');
    for i = n: -1: 0
        fprintf('\na%d = ', i);
        temp = input('');
        poly(i + 1) = temp;
    end
    x = input('\nvalue of x: ');
    plot(-4:.1:-1, polyval(poly, -4:.1:-1));
    hold on
    plot(-4:.1:-1, polyval(polyder(poly), -4:.1:-1));
    hold off
    legend('f(x)', 'f''(x)')
    grid on
    hornerMethod(n, poly, x);
end
function hornerMethod(n, poly, x)
    p = poly(n + 1);
    q = 0;
    for i = n: -1: 1
        q = p + q * x;
        p = p * x + poly(i);
    end
    fprintf('\nf(%0.2f) = is %0.4f', x, p);
    fprintf('\nf''(%0.2f) = is %0.4f', x, q);
end