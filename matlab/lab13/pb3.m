%Problem 3
format long;

% Kepler's equation setup
f = @(E) E - 0.8*sin(E) - (2*pi/10);
df = @(E) 1 - 0.8*cos(E);

% Initial guess
E = 1;

fprintf('Iter\t E\t\t\t\t\t Error\n');
for k = 1:6
    E_new = E - f(E)/df(E);
    err = abs(E_new - E);
    fprintf('%d\t %.15f\t %.3e\n', k, E_new, err);
    E = E_new;
end