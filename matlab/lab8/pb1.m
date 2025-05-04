% Define function
f = @(x) 2 ./ (1 + x.^2);

% Part a: Trapezium rule with 1 interval
a = 0; b = 1;
I_trap = (b - a)/2 * (f(a) + f(b));
fprintf('Trapezium rule approximation: %.6f\n', I_trap);

% Part b: Plot function and trapezium
x_vals = linspace(0, 1, 100);
y_vals = f(x_vals);

figure;
plot(x_vals, y_vals, 'b-', 'LineWidth', 2); hold on;
title('Function f(x) and Trapezium');
xlabel('x'); ylabel('f(x)');

% Trapezium vertices
x_trap = [0, 0, 1, 1];
y_trap = [0, f(0), f(1), 0];
fill(x_trap, y_trap, 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'k');

legend('f(x)', 'Trapezium Area');
grid on;

% Part c: Simpson's Rule
mid = (a + b)/2;
I_simp = (b - a)/6 * (f(a) + 4*f(mid) + f(b));
fprintf('Simpson''s rule approximation: %.6f\n', I_simp);
