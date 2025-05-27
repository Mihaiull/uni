% Define the function
f = @(x) x^3 - x^2 - 1;

% Initial guesses
x0 = 1;
x1 = 2;
tol = 1e-4;
N = 100;

% Secant method iterations
for n = 1:N
    f0 = f(x0);
    f1 = f(x1);
    
    % Prevent division by zero
    if abs(f1 - f0) < eps
        fprintf('No no daca incerci sa imparti la zero faci buba.\n');
        break;
    end
    
    % Secant formula
    x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
    
    % Check for convergence
    if abs(x2 - x1) < tol
        fprintf('Converged to %.6f in %d iterations.\n', x2, n);
        break;
    end
    
    % Update values for next iteration
    x0 = x1;
    x1 = x2;
end
