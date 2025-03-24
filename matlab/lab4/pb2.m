x = [1, 2, 3, 4, 5];
y = [22, 23, 25, 30, 28];

%a)
F = daivaided_daifrence(x,y);

x_approx = 2.5;
y_approx = newton_interp_pol(x, F, x_approx)

%b)
x_vals = linspace(1,5,50);
y_vals = arrayfun(@(t)newton_interp_pol(x,F,t), x_vals);

%plotting
figure
plot(x,y,"ro");
hold on;

%interp curve
plot(x_vals, y_vals, "b-", LineWidth=2)

%approx point computed at point t
plot(x_approx, y_approx, 'rs', LineWidth=2)
