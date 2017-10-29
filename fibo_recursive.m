function [ f ] = fibo_recursive(n)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if n==1
    f = 1;
    return;
elseif n==2
    f = 1;
    return;
else
    f = fibo_recursive(n-1) + fibo_recursive(n-2);
    return;
end

end

