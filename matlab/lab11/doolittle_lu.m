function [L, U] = doolittle_lu(A)
    n = size(A, 1);
    L = eye(n);
    U = zeros(n);

    for i = 1:n
        for k = i:n
            % Upper triangular
            U(i,k) = A(i,k) - L(i,1:i-1) * U(1:i-1,k);
        end
        for k = i+1:n
            % Lower triangular
            L(k,i) = (A(k,i) - L(k,1:i-1) * U(1:i-1,i)) / U(i,i);
        end
    end
end