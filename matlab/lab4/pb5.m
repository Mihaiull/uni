%a)

x1 = [-2, -1, 0, 1, 2];
y1 = 3 .^ x1;

%to eval
x_eval1 = 1/2;
approx1 = neville(x1,y1,x_eval1)

%b)
x2 = [0, 1, 2, 4, 5];
y2 = sqrt(x2);

%to eval
x_eval2 = 3;
approx2 = neville(x2,y2,x_eval2)