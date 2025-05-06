%Problem 2
%% Point a
f = @(x) 2 ./ (1 + x.^2);
a = 0; b = 1;
epsilon = 1e-4;
maxIter = 20;

% Initialize Romberg table
R = zeros(maxIter, maxIter);

% Step size
h = b - a;

% R(1,1): First trapezoidal approximation
R(1,1) = (h / 2) * (f(a) + f(b));

for n = 2:maxIter
    h = h / 2;
    
    % Trapezoidal approximation at level n
    sum = 0;
    for k = 1:2^(n-2)
        x = a + (2 * k - 1) * h;
        sum = sum + f(x);
    end
    R(n,1) = 0.5 * R(n-1,1) + h * sum;
    
    for m = 2:n
        R(n,m) = R(n,m-1) + (R(n,m-1) - R(n-1,m-1)) / (4^(m-1) - 1);
    end
    
    % Check convergence
    if abs(R(n,n) - R(n-1,n-1)) < epsilon
        fprintf('Romberg Result (Trapezium): %.6f\n', R(n,n));
        fprintf('Iterations: %d\n', n);
        break;
    end
end


%% Point b
% Store just the diagonal R(n,n) values
romberg_seq = [];

% Compute Romberg diagonal sequence
h = b - a;
R(1,1) = (h / 2) * (f(a) + f(b));
romberg_seq(1) = R(1,1);

for n = 2:maxIter
    h = h / 2;
    sum = 0;
    for k = 1:2^(n-2)
        x = a + (2 * k - 1) * h;
        sum = sum + f(x);
    end
    R(n,1) = 0.5 * R(n-1,1) + h * sum;
    
    for m = 2:n
        R(n,m) = R(n,m-1) + (R(n,m-1) - R(n-1,m-1)) / (4^(m-1) - 1);
    end
    
    romberg_seq(n) = R(n,n);
    
    if n >= 3
        % Apply Aitken's Δ² process
        delta1 = romberg_seq(n) - romberg_seq(n-1);
        delta2 = romberg_seq(n-1) - romberg_seq(n-2);
        denominator = romberg_seq(n) - 2*romberg_seq(n-1) + romberg_seq(n-2);
        
        if abs(denominator) > 1e-12
            R_aitken = romberg_seq(n-2) - (delta2^2) / denominator;
            if abs(R_aitken - romberg_seq(n)) < epsilon
                fprintf('Romberg Result (Aitken): %.6f\n', R_aitken);
                fprintf('Iterations: %d\n', n);
                break;
            end
        end
    end
end