time = [0 3 5 8 13];
distance = [0 225 383 623 993];
speed = [75 77 80 74 72];

%pchip = piecewise cubic hermite interpolation

%hermite interpolation for position at t=10
distance_at_t10 = interp1(time, distance, 10, 'pchip')

%hermite interpolation for speed at t=10
speed_at_t10 = interp1(time,speed, 10, 'pchip')