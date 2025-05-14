%% a)
A=[10 7 8 7;7 5 6 5;8 6 10 9;7 5 9 10];
B=[32;23;33;31];

x = A\B;

disp("Solution: " + x);
disp("Condition: " + cond(A))

%% b)

woggly_b=[32.1;22.9;33.1;30.9];

x2 = A \ woggly_b;
disp("Solution2: " + x2);

%input relative error (norm is a nice function)

inp= norm(B-woggly_b) / norm(b);
output= norm(x-x2) / norm(x);

chestie=inp / output;

disp("Input: " + inp);
disp("Output: " + output);
disp("Salam de sibiu: " + chestie);

%% c)
A_barat=[10, 7, 8.1, 7.2; 7.08, 5.04, 6, 5; 8, 5.98, 9.89, 9; 6.99, 4.99, 9, 9.98];
x3=A_barat\B;
disp("Solution3: " + x3);

input2 = norm(A - A_barat) / norm(A);
output2 = norm(x - x3) / norm(x);
chestie2 = input2 / output2;

disp("Input2: " + input2);
disp("Output2: " + output2);
disp("Salam De Sibiu2:" + chestie2);