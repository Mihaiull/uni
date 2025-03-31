x = linspace(-5,5, 100);
f = sin(2*x);

nodes = linspace(-5,5,15);
f_nodes = sin(2*nodes);

f_interp = pchip(nodes, f_nodes, x);
figure;
%the main func
plot(x, f, 'r');
hold on;
%the interp
plot(x, f_interp, 'b--');
hold off;