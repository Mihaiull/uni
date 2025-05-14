%Problem 2
A = [6 2 1 -1;
     2 4 1 0;
     1 1 4 -1;
    -1 0 -1 3];

b = [8; 7; 5; 1];

[L, U] = doolittle_lu(A);

disp('Matrix L:');
disp(L);

disp('Matrix U:');
disp(U);

% Solve Ax = b using LU
x = solve_lu(L, U, b);

disp('Solution vector x:');
disp(x)