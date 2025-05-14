%% a)

for n = [10, 15]
    t = 1:n;
    V = vander(t);

    cond_V = cond(V);

    fprintf('The conditioning number of the Vandermonde matrix V(t_k) for n=%d is: %.4e\n', n, cond_V);
end

%% b)

for n = [10, 15]
    k = 1:n;
    t = -1 + (2 * k) / n;
    V=vander(t);
    cond_V = cond(V);
    fprintf('The conditioning number of the Vandermonde matrix V(t_k) for n=%d is: %.4e\n', n, cond_V);
end
