%% a)
% Define the matrix A and the vector b
A = [400, -201; -800, 401];
b = [200; -200];

% Solve system
x = A \ b;

% Display
disp('Original is:');
disp(x);

%% b)

% Define the matrix A and the vector b
A2 = [401, -201; -800, 401];
b2 = [200; -200];

% Solve system
x2 = A2 \ b2;

% Display
disp('Modified is:');
disp(x2);

%% c)
cond(A)
cond(A2)
