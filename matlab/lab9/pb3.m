%Problem 3
%Plot the function
f = @(x) (100 ./ x.^2) .* sin(10 ./ x);
x = linspace(1, 3, 1000);
plot(x, f(x), 'b', 'LineWidth', 2);
xlabel('x'); ylabel('f(x)');
title('Plot of f(x) = 100/x^2 * sin(10/x)');
grid on;

%Adaptive Simpson
a = 1; b = 3;
epsilon = 1e-4;

% Call the adaptive Simpson function
adaptive_result = adaptive_simpson(f, a, b, epsilon, 20);
fprintf('Adaptive Simpson Result: %.10f\n', adaptive_result);


% Repeated Simpson results
simpson_50 = repeated_simpson(f, 1, 3, 50);
simpson_100 = repeated_simpson(f, 1, 3, 100);

fprintf('Repeated Simpson n=50: %.10f\n', simpson_50);
fprintf('Repeated Simpson n=100: %.10f\n', simpson_100);