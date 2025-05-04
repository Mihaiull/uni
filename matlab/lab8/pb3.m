r = 110;
p = 75;
a = 0;
b = 2*pi;

f = @(x) sqrt(1-(p/r)^2*sin(x));

n1=50;
n2=100;

H1=compute_H(f, a, b, p, r, n1)
H2=compute_H(f, a, b, p, r, n2)