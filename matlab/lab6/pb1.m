x_nodes = [0, pi/2, pi, 3*pi/2, 2*pi];
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