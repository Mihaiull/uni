% Define the integrand
f = @(t) exp(-t.^2);

% Define exact value of erf(0.5)
erf_true = 0.520499876;

% Integration limits
a = 0;
b = 0.5;

% Try for n = 4 and n = 10
for n = [4, 10]
    if mod(n, 2) ~= 0
        error('Simpson''s rule requires even n.');
    end

    h = (b - a) / n;
    t = linspace(a, b, n+1);
    ft = f(t);

    % Simpson's Rule formula
    I = h/3 * (ft(1) + ...
               4 * sum(ft(2:2:end-1)) + ...
               2 * sum(ft(3:2:end-2)) + ...
               ft(end));
           
    erf_approx = (2 / sqrt(pi)) * I;
    error = abs(erf_approx - erf_true);

    % Display results
    fprintf('n = %d:\n', n);
    fprintf('  erf(0.5) ≈ %.9f\n', erf_approx);
    fprintf('  Absolute error: %.9f\n\n', error);
end
