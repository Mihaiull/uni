f = @(x) exp(sin(x));

x = linspace(0,6,13);
y = f(x);

%div diff
F = daivaided_daifrence(x,y);

x_vals = linspace(0,6,500);
y_vals = arrayfun(@(t) newton_interp_pol(x,F,t), x_vals);

%plotting
figure;

%orig func
plot(x_vals, f(x_vals), LineWidth=4);
hold on;

%interp points
plot(x,y,'ro');

%newton poly
plot(x_vals, y_vals, 'g--', LineWidth=2);

grid on;