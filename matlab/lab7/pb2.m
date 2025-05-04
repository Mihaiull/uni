% Given data
T = [0 10 20 30 40 60 80 100]; % Temperature in °C
P = [0.0061 0.0123 0.0234 0.0424 0.0738 0.1992 0.4736 1.0133]; % Pressure in bars

% a) Obtain least squares approximations using polyfit for two different degrees

% Degree 2 polynomial
p2 = polyfit(T, P, 2);
% Degree 3 polynomial
p3 = polyfit(T, P, 3);

% Find the value at T = 45 using polyval
P2_45 = polyval(p2, 45);
P3_45 = polyval(p3, 45);

% Exact value
P_exact = 0.095848;

% Approximation errors
error2 = abs(P2_45 - P_exact);
error3 = abs(P3_45 - P_exact);

% Display results
fprintf('Degree 2 Polynomial at T=45: %.6f\n', P2_45);
fprintf('Degree 3 Polynomial at T=45: %.6f\n', P3_45);
fprintf('Error for Degree 2 Polynomial: %.6f\n', error2);
fprintf('Error for Degree 3 Polynomial: %.6f\n', error3);

% b) Plotting

% Generate a finer range of T values for plotting
T_fine = linspace(0, 100, 1000);
P2_fine = polyval(p2, T_fine);
P3_fine = polyval(p3, T_fine);

% Plot the data points, polynomial fits, and interpolation polynomial
figure;
hold on;
plot(T, P, 'ro', 'MarkerFaceColor', 'r'); % Data points
plot(T_fine, P2_fine, 'b-', 'LineWidth', 2); % Degree 2 polynomial fit
plot(T_fine, P3_fine, 'g-', 'LineWidth', 2); % Degree 3 polynomial fit
legend('Data Points', 'Degree 2 Polynomial Fit', 'Degree 3 Polynomial Fit');
xlabel('Temperature (°Celsiususdadakdnkl)');
ylabel('Vapor Pressure (bars)');
title('Least Squares Polynomial Approximations');
grid on;
hold off;