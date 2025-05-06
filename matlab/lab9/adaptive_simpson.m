% Adaptive Simpson's rule
function I = adaptive_simpson(f, a, b, epsilon, maxRecursionDepth)
    function S = simpson(f, a, b)
        c = (a + b)/2;
        S = (b - a)/6 * (f(a) + 4*f(c) + f(b));
    end

    function I = recurse(f, a, b, epsilon, S, depth)
        c = (a + b)/2;
        S_left = simpson(f, a, c);
        S_right = simpson(f, c, b);
        if depth <= 0 || abs(S_left + S_right - S) < 15 * epsilon
            I = S_left + S_right + (S_left + S_right - S) / 15;
        else
            I = recurse(f, a, c, epsilon/2, S_left, depth-1) + ...
                recurse(f, c, b, epsilon/2, S_right, depth-1);
        end
    end

    S = simpson(f, a, b);
    I = recurse(f, a, b, epsilon, S, maxRecursionDepth);
end