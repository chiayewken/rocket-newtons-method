clc;
clear;
pkg load io;
data = xlsread("2d.xlsx", "Free fall data");
data = data(1:2, :)';
global time = data(:, 1);
global si = data(:, 2);
global m = 0.31983;
global g = 9.81;

function e = error (x)
  global time;
  global m;
  global g;
  global si;
  sti = m / (x ** 2) * log(cosh(time * sqrt(m * g) / m * x));
  e = sum((sti - si) .** 2);
endfunction

function ep = errorprime (x)
  global time;
  global m;
  global g;
  global si;
  sti = m / (x ** 2) * log(cosh(time * sqrt(m * g) / m * x));
  vti = sqrt(m * g) / x * tanh(time * sqrt(m * g) / m * x);
  ep = 2 * sum((sti - si) .* vti);
endfunction

function epp = errorprimeprime (x)
  global time;
  global m;
  global g;
  global si;
  sti = m / (x ** 2) * log(cosh(time * sqrt(m * g) / m * x));
  vti = sqrt(m * g) / x * tanh(time * sqrt(m * g) / m * x);
  ati = sqrt(m * g) / (x .** 2) * tanh(time * sqrt(g / m) * x)...
  + time * g / m / x ./ (cosh(time * x * sqrt(g / m)) .** 2);
  epp = 2 * sum((vti .** 2) + (sti - si) .* ati);
endfunction

function newton (iterations, x)
  starting_x = x
  for n = 1:iterations
    temp = x - (errorprime(x) / errorprimeprime(x));
    x = temp;
    error(x);
  endfor
  iterations = iterations
  error = error(x)
  x
  beta = x ** 2
endfunction

newton(100, 1)  
  
  
