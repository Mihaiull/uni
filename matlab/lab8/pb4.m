% Define function
f = @(x) x .* log(x);

% Exact value using MATLAB's high-precision integration
I_exact = integral(f, 1, 2);

% Set tolerance for 3-digit accuracy
tolerance = 0.00005;

% Initialize variables
n = 1;
error = Inf;

% Loop to find minimum n
while error > tolerance
    h = (2 - 1) / n;
    x = linspace(1, 2, n+1);
    fx = f(x);
    
    I_trap = h/2 * (fx(1) + 2*sum(fx(2:end-1)) + fx(end));
    error = abs(I_trap - I_exact);
    
    if error <= tolerance
        fprintf('Smallest n for 3-digit accuracy: %d\n', n);
        fprintf('Trapezium Rule Approximation: %.15f\n', I_trap);
        fprintf('Exact Value: %.15f\n', I_exact);
        break;
    end
    n = n + 1;
end
