clc;
clear all;
pkg load io;
data = xlsread("2d.xlsx");
data = data(255:289, :);
global time = data(:, 1);
global thrust = data(:, 2);
global beta = 0.0046697;
global u = 0.2
global m = 0.04;
global g = 9.81;


v = zeros(length(time) + 1, 1);

v(2) = (thrust(1) - beta * (v(1) ** 2)) * (time(2) - time(1))...
/ m  + v(1);

for n = 2:length(time) - 1
  v(n + 1) = (thrust(n) - u * m * g - beta * (v(n) ** 2)) * (time(n + 1) - time(n))...
  / m  + v(n);
endfor

v = v(2:end);

s = zeros(length(v), 1);

for n = 1:length(v) - 1
	s(n) = abs(v(n + 1) + v(n)) / 2 * abs(time(n + 1) - time(n));
endfor
	
plot(time, v)
total_displacement = sum(s)
