%Problem 1
f = @(x) sin(x);
nodes = [0, pi/2, pi, 3*pi/2, 2*pi];
values = f(nodes);

% point to eval
x_eval = pi/4;

natural_spline = spline(nodes, values);x_nodes = [0, pi/2, pi, 3*pi/2, 2*pi];
y_values = sin(x_nodes);

%a)
%the query point
x_query = pi/4;

y_natural_spline = spline(x_nodes, y_values, x_query)

dy_lb = 0; %derivative of lower bound (x=0)
dy_ub = 0; %derivative og upper bound (x=2*pi)

y_clamped_spline = spline(x_nodes, [dy_lb, y_values, dy_ub], x_query)


%b)
x_range=linspace(0,2*pi,1000);
y_natural_sfine=spline(x_nodes, y_values, x_range);
y_clamped_sfine=spline(x_nodes, [dy_lb, y_values, dy_ub], x_range);
y_fine_function=sin(x_range);

figure;
plot(x_range, y_fine_function, 'b', 'LineWidth', 2); hold on;  % Plot the original function (sin(x))
plot(x_range, y_natural_sfine, 'r--', 'LineWidth', 2);  % Plot cubic natural spline
plot(x_range, y_clamped_sfine, 'g-.', 'LineWidth', 2);  % Plot cubic clamped spline

% Plot the original nodes as markers
plot(x_nodes, y_values, 'ko', 'MarkerFaceColor', 'k');

% Add labels and legend
title('Function, Cubic Natural Spline, and Cubic Clamped Spline');
xlabel('x');
ylabel('y');
legend('sin(x)', 'Cubic Natural Spline', 'Cubic Clamped Spline', 'Nodes');
grid on;

%inca prefer legendele din folclorul maghiar
natural_val = ppval(natural_spline, x_eval);

% clamped spline
derivs = [cos(nodes(1)), cos(nodes(end))];
clamped_spline = spline(nodes, [derivs(1), values, derivs(2)]);
clamped_val = ppval(clamped_spline, x_eval);

fprintf('at x = pi/4 (%.4f):\n', x_eval);
fprintf('function value: %.6f\n', f(x_eval));
fprintf('natural spline value: %.6f\n', natural_val);
fprintf('clamped spline value: %.6f\n', clamped_val);

%plot
x_plot = linspace(0, 2*pi, 1000);
figure;
hold on;
% original function
plot(x_plot, f(x_plot), 'b-', 'LineWidth', 2, 'DisplayName', 'sin(x)');
% natural spline
plot(x_plot, ppval(natural_spline, x_plot), 'r--', 'LineWidth', 2, 'DisplayName', 'natural spline');
% plot clamped spline
plot(x_plot, ppval(clamped_spline, x_plot), 'g-.', 'LineWidth', 1.5, 'DisplayName', 'clamped spline');
% plot nodes
plot(nodes, values, 'ko', 'MarkerFaceColor', 'k', 'DisplayName', 'nodes');

% information
xlabel('x');
ylabel('f(x)');
title('Comparison of sin(x) with Natural and Clamped Splines');
legend('Location', 'best');

grid on;
hold off;