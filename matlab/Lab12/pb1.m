%Prolem 1
A = [3 -1 0 0 0 0;
    -1 3 -1 0 0 0;
     0 -1 3 -1 0 0;
     0 0 -1 3 -1 0;
     0 0 0 -1 3 -1;
     0 0 0 0 -1 3];

b = [2; 1; 1; 1; 1; 2];
tol = 1e-3;
max_iter = 1000;

x = zeros(6,1);
n = length(b);
iter = 0;

while iter < max_iter
    x_new = x;
    for i = 1:n
        s = A(i, [1:i-1, i+1:n]) * x([1:i-1, i+1:n]);
        x_new(i) = (b(i) - s) / A(i,i);
    end
    if norm(x_new - x, inf) < tol
        break;
    end
    x = x_new;
    iter = iter + 1;
end

disp('Jacobi Solution:');
disp(x);
disp(['Iterations: ', num2str(iter)]);

x = zeros(6,1);
iter = 0;

while iter < max_iter
    x_old = x;
    for i = 1:n
        s1 = A(i,1:i-1) * x(1:i-1);
        s2 = A(i,i+1:n) * x_old(i+1:n);
        x(i) = (b(i) - s1 - s2) / A(i,i);
    end
    if norm(x - x_old, inf) < tol
        break;
    end
    iter = iter + 1;
end

disp('Gauss-Seidel Solution:');
disp(x);
disp(['Iterations: ', num2str(iter)]);

omega = 0.75;             
x = zeros(6,1);
x_old = x;
iter = 0;
residual = inf;

while iter < max_iter && residual > tol
    for i = 1:n
        sum1 = A(i,1:i-1) * x(1:i-1);
        sum2 = A(i,i+1:n) * x_old(i+1:n);
        x(i) = (1 - omega) * x_old(i) + (omega / A(i,i)) * (b(i) - sum1 - sum2);
    end
    residual = norm(x - x_old, inf);
    x_old = x;
    iter = iter + 1;
end

disp('SOR Solution:');
disp(x);
disp(['Iterations: ', num2str(iter)]);