function [ f ] = fibo( n )
% compute Fibonacci numbers using formula
%   Detailed explanation goes here
f = 1/sqrt(5)*( ((1+sqrt(5))/2)^n - ((1-sqrt(5))/2)^n );

end