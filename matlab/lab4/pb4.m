x = [100; 121; 144]; %perfect squares around the point

f = sqrt(x);

%to approx
alpha = 115;
epsilon = 1e-3;

%aitken table
n = length(x);
table = zeros(n, n);
table(:, 1) = f;

%use it now
for j = 2:n
    for i = j:n
        % the determinant of the matrix
        nominator = (alpha - x(i - j + 1)) * table(i, j-1) - (alpha - x(i)) * table(i-1, j-1);
        % 1 / x_i - x_j
        denominator = x(i) - x(i - j + 1);
        table(i, j) = nominator / denominator;
    end

    % check the stopping for the precision
    if abs(table(j, j) - table(j-1, j-1)) < epsilon
        break;
    end
end

sqrt_apporx = table(j,j)
E = abs(sqrt_apporx - sqrt(115))