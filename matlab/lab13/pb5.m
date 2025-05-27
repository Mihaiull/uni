%% Define the function
f = @(x) (x - 2).^2 - log(x);

%% Interval and parameters
a = 1;
b = 2;
tol = 1e-4;
N = 100;

fprintf('--- Bisection Method ---\n');
%% Bisection Method
for n = 1:N
    c = (a + b)/2;
    fc = f(c);
    
    if abs(fc) < tol
        fprintf('Bisection converged to %.6f in %d iterations.\n', c, n);
        break;
    end
    
    if f(a) * fc < 0
        b = c;
    else
        a = c;
    end
end

%% Reset interval for false position
a = 1;
b = 2;

fprintf('\n--- False Position Method ---\n');
%% False Position Method
for n = 1:N
    fa = f(a);
    fb = f(b);
    c = b - fb * (b - a) / (fb - fa);
    fc = f(c);
    
    if abs(fc) < tol
        fprintf('False Position converged to %.6f in %d iterations.\n', c, n);
        break;
    end
    
    if fa * fc < 0
        b = c;
    else
        a = c;
    end
end
