% Loop
for n = 10:15
    % Hilbert
    H = zeros(n); % n x n matrix
    for i = 1:n
        for j = 1:n
            H(i,j) = 1 / (i + j - 1); % Fill matrix
        end
    end
    
    cond_H = cond(H);
    
    fprintf('The conditioning number of the Hilbert matrix H_%d is: %.4e\n', n, cond_H);
end
