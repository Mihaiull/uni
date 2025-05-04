time = [1, 2, 3, 4, 5, 6, 7];
temperature = [13, 15, 20, 14, 15, 13, 10];

no_of_nodes = length(time);

sum_time = sum(time);
sum_temp = sum(temperature);
sum_time2 = sum(time.^2);
sum_timetemp = sum(time .* temperature);

%normal eq for a and b

A = [sum_time2, sum_time; sum_time, no_of_nodes];
B = [sum_timetemp; sum_temp];

coefs = A \ B;
a = coefs(1);
b = coefs(2);

fprintf("Best line : %.f3x + .%f3\n", a,b);

time_predict = 8;
temp_predict = a * time_predict + b

x = linspace(1,10,100);
y = a.*x+b;
plot(time,temperature,LineStyle="--", Color='r');
hold on;
plot(x,y);
