%Problem 1
format long;

% Define initial guess and tolerance
x0 = 0.5;
epsilon = 1e-10;
max_iter = 1000;

% Method 1: x_{k+1} = e^{x_k}
fprintf('Method 1: x_{k+1} = e^{x_k}\n');
x = x0;
for k = 1:max_iter
    x_new = exp(-x);
    if abs(x_new - x) < epsilon
        break;
    end
    x = x_new;
end
fprintf('Approximation: %.12f\n', x);
fprintf('Iterations: %d\n\n', k);

% Method 2: x_{k+1} = 1 + x_k / (e^{x_k} + 1)
fprintf('Method 2: x_{k+1} = 1 + x_k / (e^{x_k} + 1)\n');
x = x0;
for k = 1:max_iter
    x_new = (1 + x) / (exp(x) + 1);
    if abs(x_new - x) < epsilon
        break;
    end
    x = x_new;
end
fprintf('Approximation: %.12f\n', x);
fprintf('Iterations: %d\n\n', k);

fprintf('Method 3: x_{k+1} = x_k + 1 - x_k * e^{x_k}\n');
x = x0;
for k = 1:max_iter
    x_new = x + 1 - x * exp(x);
    if abs(x_new - x) < epsilon
        break;
    end
    x = x_new;
end
fprintf('Approximation: %.12f\n', x);
fprintf('Iterations: %d\n', k);