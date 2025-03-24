x = [1, 1.5, 2, 3, 4];
lg_x = [0, 0.17609, 0.30103, 0.47712, 0.60206];

approx = [2.5, 3.25];

i = linspace(10,35,25);
y_i = i/10;

%initialise div diff table
f_x = daivaided_daifrence(x, lg_x);

%lg approximation
lg_aprox = newton_interp_pol(x, f_x, approx)

%interp values
N_y_i = newton_interp_pol(x,f_x, y_i);

%maximum interpolation error
err = max(abs(log10(y_i)-N_y_i))