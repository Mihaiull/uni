figure;
axis([0 3 0 5]);  % Set axis limits as specified
title('Click 10 points in the region [0,3] x [0,5]');
xlabel('x'); ylabel('y');
grid on;

% Use ginput to collect 10 points
[x, y] = ginput(10);

% find a 2nd deg poly
p = polyfit(x, y, 2);  % p(1)*x^2 + p(2)*x + p(3)

% plot the points on the polynomial curve
hold on;
plot(x, y, 'ro', 'MarkerFaceColor', 'r');  % Plot selected points

% Generate smooth x values
x_fit = linspace(0, 3, 200);
y_fit = polyval(p, x_fit);  % Evaluate the polynomial at x_fit
plot(x_fit, y_fit, 'b-', 'LineWidth', 2);  % Plot the polynomial

legend('Selected Points', '2nd-Degree Polynomial Fit');
title('Least Squares 2nd-Degree Polynomial Fit');
