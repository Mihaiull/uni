function f_x = daivaided_daifrence(x, y)
    %   x - Array of x-values (independent variable).
    %   y - Array of y-values (dependent variable).
    %   F_x - Divided difference table.

    n = length(x);
    f_x = zeros(n, n);
    f_x(:, 1) = y'; % First column is the y-values

    % compute the table of divided differences
    for j = 2 : n % we start from the second element
        for i = 1 : n - j + 1 % we stop at n - j + 1 because we need to have at least j elements to the right of i
            % plug in the formula
            nominator = f_x(i + 1, j - 1) - f_x(i, j - 1);
            denominator = x(i + j - 1) - x(i);
            f_x(i, j) = nominator / denominator;
        end
    end
end