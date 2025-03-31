% Create a new figure for the plot
figure;
title('Cubic Natural Spline Passing Through Given Points');
xlabel('x');
ylabel('y');
grid on;

% Prompt the user to select 5 points on the plot using ginput
disp('Please select 5 points on the plot using ginput:');
[x_points, y_points] = ginput(5);

% Plot the points on the graph
hold on;
plot(x_points, y_points, 'ro', 'MarkerFaceColor', 'r');

% Sort the points in ascending order of x (spline requires points to be in increasing order apparently)
[x_points_sorted, sort_idx] = sort(x_points);
y_points_sorted = y_points(sort_idx);

% Cubic natural spline for the given sorted points
x_fine = linspace(min(x_points_sorted), max(x_points_sorted), 100);
y_fine_spline = spline(x_points_sorted, y_points_sorted, x_fine); 

% Plot the cubic natural spline curve
plot(x_fine, y_fine_spline, 'b-', 'LineWidth', 2);

% Display a legend and grid (i ain't doing fancy shit no more i'm not a web dev)
legend('Given Points', 'Cubic Natural Spline');
