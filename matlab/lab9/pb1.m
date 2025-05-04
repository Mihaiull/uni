% Function definition
f = @(x) exp(-x.^2);

% Integration bounds
a = 1;
b = 1.5;

%% Part (a): Single rectangle (n = 1) using midpoint
n_a = 1;
dx_a = (b - a);
x_mid = (a + b) / 2;
I_a = f(x_mid) * dx_a;
fprintf('Part (a): Midpoint rectangle approximation (n=1): %.4f\n', I_a);

%% Part (b): Plot f(x) and midpoint rectangle
x_vals = linspace(a, b, 400);
y_vals = f(x_vals);

% Midpoint rectangle
hold on;
figure;
plot(x_vals, y_vals, 'b-', 'LineWidth', 2, 'Color', 'm'); % Function plot
rectangle_x = [a, b];
rectangle_y = [f(x_mid), f(x_mid)];
fill([a b b a], [0 0 f(x_mid) f(x_mid)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'r');
title('Function f(x) = e^{-x^2} and Midpoint Rectangle');
xlabel('x');
ylabel('f(x)');
grid on;
hold off;

%% Part (c): Repeated midpoint rule with n = 150 and n = 500
midpoint_rule = @(f, a, b, n) ...
    sum(f(a + ((1:n) - 0.5) * (b - a) / n)) * (b - a) / n;

% n = 150
n1 = 150;
I1 = midpoint_rule(f, a, b, n1);
fprintf('Part (c): Midpoint approximation with n = 150: %.4f\n', I1);

% n = 500
n2 = 500;
I2 = midpoint_rule(f, a, b, n2);
fprintf('Part (c): Midpoint approximation with n = 500: %.4f\n', I2);
