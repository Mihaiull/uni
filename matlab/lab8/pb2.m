% Define the function
f = @(x, y) log(x + 2*y);

% Integration limits
a = 1.4; b = 2;      % x limits
c = 1;   d = 1.5;    % y limits

% Number of subintervals in x and y
nx = 2; ny = 2;

% Step sizes
hx = (b - a) / nx;
hy = (d - c) / ny;

% Generate grid points
x = linspace(a, b, nx+1);
y = linspace(c, d, ny+1);

% Initialize sum
I = 0;

for i = 1:(nx+1)
    for j = 1:(ny+1)
        weight = 1;
        if (i == 1 || i == nx+1)
            weight = weight / 2;
        end
        if (j == 1 || j == ny+1)
            weight = weight / 2;
        end
        I = I + weight * f(x(i), y(j));
    end
end

% Multiply by area of each rectangle
I = I * hx * hy;

% Display result
fprintf('Approximation using trapezium rule: %.7f\n', I);
