% Define the function and its derivative
f = @(x) cos(x) - x;
df = @(x) -sin(x) - 1;

% Parameters
x0 = pi / 4;
tol = 1e-4;
N = 100;

% Initialize
x = x0;
for n = 1:N
    x_new = x - f(x)/df(x);  % Newton's method update
    if abs(x_new - x) < tol  % Check convergence
        fprintf('Converged to %.6f in %d iterations.\n', x_new, n);
        break;
    end
    x = x_new;  % Update x for next iteration
end
