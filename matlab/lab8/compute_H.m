%blatantly and unshamefully copied
function H = compute_H(f, a, b, p, r, n)
    h = (b-a)/n;
    x = linspace(a,b,n+1);
    y = f(x);
    integral_approx = h * (0.5*y(1) + sum(y(2:end-1)) + 0.5*y(end));
    H = (60 * r / (r^2 - p^2)) * integral_approx;
end