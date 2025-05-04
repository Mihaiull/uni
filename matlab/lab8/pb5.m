% Define the function
f = @(x) 1 ./ (4 + sin(20 * x));

% Integration limits
a = 0;
b = pi;

% Test for n = 10 and n = 30
for n = [10, 30]
    if mod(n, 2) ~= 0
        error('Simpson''s rule requires even n.');
    end

    h = (b - a) / n;
    x = a:h:b;
    fx = f(x);
    
    % Apply Simpson's Rule
    I = h/3 * (fx(1) + ...
               4 * sum(fx(2:2:end-1)) + ...
               2 * sum(fx(3:2:end-2)) + ...
               fx(end));
    
    fprintf('Simpson''s Rule Approximation (n = %d): %.7f\n', n, I);
end
