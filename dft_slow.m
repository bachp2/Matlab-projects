function X = dft_slow(x)
%compute DFT using simple matrix multiplication
%   Detailed explanation goes here
N = length(x);
n = 0:N-1;
k = n';
M = exp(-2i*pi*k*n/N);
X = M*x;
end
