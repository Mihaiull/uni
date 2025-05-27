%Problem 2
A = [3 1 1;
    -2 4 0;
    -1 2 -6];

b = [12; 2; -5];
tol = 1e-5;
max_iter = 1000;
n = length(b);

D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
x = zeros(n, 1);
iter = 0;

while iter < max_iter
    x_new = D \ (b - (L + U) * x);
    if norm(x_new - x, inf) < tol
        break;
    end
    x = x_new;
    iter = iter + 1;
end

disp('Jacobi Solution:');
disp(x);
disp(['Jacobi Iterations: ', num2str(iter)]);


L = tril(A);
U = triu(A, 1);
x = zeros(n, 1);
iter = 0;

while iter < max_iter
    x_new = L \ (b - U * x);
    if norm(x_new - x, inf) < tol
        break;
    end
    x = x_new;
    iter = iter + 1;
end

disp('Gauss-Seidel Solution:');
disp(x);
disp(['Gauss-Seidel Iterations: ', num2str(iter)]);



omega = 1.1; 
x = zeros(n, 1);
iter = 0;
residual = inf;

D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);

while iter < max_iter && residual > tol
    x_old = x;
    for i = 1:n
        sigma = A(i,1:i-1) * x(1:i-1) + A(i,i+1:n) * x_old(i+1:n);
        x(i) = (1 - omega) * x_old(i) + (omega / A(i,i)) * (b(i) - sigma);
    end
    residual = norm(x - x_old, inf);
    iter = iter + 1;
end

disp('SOR Solution:');
disp(x);
disp(['SOR Iterations: ', num2str(iter)]);
