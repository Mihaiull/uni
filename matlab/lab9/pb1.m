%Problem 1
%% Point a
a = 1;
b = 1.5;
n = 5;

% Compute step size
dx = (b - a) / n;

% Generate left endpoints
x = a : dx : b - dx;

% Evaluate function at left endpoints
f = exp(-x.^2);

% Compute the rectangle rule approximation
approx_integral = sum(f) * dx;

% Display the result
fprintf('Approximate integral using rectangle rule: %.5f\n', approx_integral);

%% Point b
f = @(x) exp(-x.^2);
a = 1;
b = 1.5;
midpoint = (a + b)/2;
height = f(midpoint);

% Width of slim rectangle (e.g. 0.1 instead of 0.5)
rect_width = 0.1;
left = midpoint - rect_width/2;
right = midpoint + rect_width/2;

% Plot setup
figure;

% Plot the rectangle first (background)
x_rect = [left right right left];
y_rect = [0 0 height height];
fill(x_rect, y_rect, [1 0.7 0.7], 'EdgeColor', 'k', 'FaceAlpha', 0.6);
hold on;

% Plot the function curve on top
x = linspace(a, b, 500);
y = f(x);
plot(x, y, 'b-', 'LineWidth', 2);

% Mark the midpoint
plot(midpoint, height, 'ko', 'MarkerFaceColor', 'k');

% Labels and legend
title('Midpoint Rectangle Approximation');
xlabel('x');
ylabel('f(x) = e^{-x^2}');
legend('Midpoint Rectangle', 'f(x)', 'Midpoint', 'Location', 'northeast');
grid on;
hold off;

%% Point c
f = @(x) exp(-x.^2);
a = 1;
b = 1.5;

% For n = 150
n1 = 150;
dx1 = (b - a) / n1;
x_mid1 = linspace(a + dx1/2, b - dx1/2, n1);
approx1 = dx1 * sum(f(x_mid1));

% For n = 500
n2 = 500;
dx2 = (b - a) / n2;
x_mid2 = linspace(a + dx2/2, b - dx2/2, n2);
approx2 = dx2 * sum(f(x_mid2));

fprintf('Approximation for n = 150: %.4f\n', approx1);
fprintf('Approximation for n = 500: %.4f\n', approx2);