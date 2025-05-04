%Function definition
f = @(x) 2/(1+x.^2);

%Integration bounds
a = 0;
b = 1;

%% Part a): Aproximate the integral using the Romberg algorithm for trapezium formula, for precision epsilon = 104.

