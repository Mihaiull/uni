
% Given data
time = [0 3 5 8 13]; % Time (in seconds)
distance = [0 225 383 623 993]; % Distance (in feet)
speed = [75 77 80 74 72]; % Speed (in feet/s)

% Define first derivatives (speed) at endpoints for clamped spline
dy_0 = 75;   % Speed at t=0
dy_end = 72; % Speed at t=13

% Create cubic clamped spline
pp = spline(time, [dy_0, distance, dy_end]); 

% Interpolate position at t = 10 seconds
t_query = 10;
distance_clamped_spline = ppval(pp, t_query)

% Extract coefficients for the spline segment containing t = 10
coeffs = pp.coefs;
segment_idx = find(time <= t_query, 1, 'last');
a = coeffs(segment_idx, 1); % x^3 coefficient
b = coeffs(segment_idx, 2); % x^2 coefficient
c = coeffs(segment_idx, 3); % x coefficient

% Compute speed (first derivative of position)
speed_clamped_spline = 3 * a * t_query^2 + 2 * b * t_query + c
