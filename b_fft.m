function X = b_fft(x)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
N = length(x);
k = 0:N-1;
if mod(N,2)>0
    fprintf('size of x must be a power of 2');
    X = [];
    return;
elseif N <= 32 
    X = dft_slow(x);
    return;
else
    X_even  = b_fft(x(1:2:N-1));
    X_odd = b_fft(x(2:2:N));
    factor = exp(-2i*pi*k/N);
    X = [X_even + factor(1:N/2)*X_odd , X_even + factor(N/2+1:N)];
    return;
end

end

