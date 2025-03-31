x = [1, 2];
f_x = log(x);
f_prime_x = [1, 0.5];

x_val = 1.5;

%hrmite interpolation
f_interp = pchip(x,f_x,x_val)

%true value
f_true = log(x_val);

%absolute error
abs_err = abs(f_true - f_interp)