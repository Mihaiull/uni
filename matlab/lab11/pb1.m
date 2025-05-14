%Problem 1
A = [1 1 1 1;
     2 3 1 5;
    -1 1 -5 3;
     3 1 7 -2];

b = [10; 31; -2; 18];

x = gauss_partial_pivot(A, b);

disp('Solution vector [x1; x2; x3; x4]:');
disp(x);