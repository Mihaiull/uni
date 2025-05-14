function x = gauss_partial_pivot(A, b)
    n = length(b);
    Ab = [A b]; % Form augmented matrix

    % Forward Elimination with Partial Pivoting
    for k = 1:n-1
        % Pivot: find row with max absolute value in current column
        [~, maxRow] = max(abs(Ab(k:n, k)));
        maxRow = maxRow + k - 1;

        % Swap rows if necessary
        if maxRow ~= k
            Ab([k maxRow], :) = Ab([maxRow k], :);
        end

        % Eliminate entries below the pivot
        for i = k+1:n
            factor = Ab(i, k) / Ab(k, k);
            Ab(i, k:end) = Ab(i, k:end) - factor * Ab(k, k:end);
        end
    end

    % Back Substitution
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (Ab(i, end) - Ab(i, i+1:n) * x(i+1:n)) / Ab(i, i);
    end
end