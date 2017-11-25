%Bach Phan
%HW 6 Sawtooth FFT
function res = fourier_sawtooth(nterms)

% *** This is a Template ***
% *** fill in the sections marked with stars ***
    
% Compute the fourier transform of a triangle analytically and compare to
% FFT result.
% Input: n -- number of terms to use in Fourier Series

% set parameters for problem
L = 10;
nt = 2^10; % fft likes powers of 2

% independent variable is x
x = linspace(-L/2,L/2,nt); % fill in x array

% *******************
% fill array with our function 
f(1) = sign(1);
f(2:nt-1) = x(2:nt-1)./(L/2);%scale to -1to1 scale 
f(nt) = sign(-1);
% *******************

% Analytic Solution

% Fill in analytic fourier coefficients found by integration
% note that index is off by one from how we do the math since
% Matlab does not have index=0

% *********************
a(1) = 0; % a0
b(1) = 0; % b0 is always set to 0

for m = 1:nterms
    a(m+1) = 0;
    b(m+1) = -2/(m*pi) * (-1)^m;
end

% ********************

% compute f_approx using finite series
f_approx(1:nt) = a(1); % fill whole array with a0
% add the appropriate number of fourier series elements
for m = 1:nterms
    f_approx = f_approx + a(m+1)*cos(m*2*pi*x/L) + b(m+1)*sin(m*2*pi*x/L); 
end


% Numerical Solution -- You can just use as is

% Take the numerical FFT
% we need to tell FFT that the function is shifted to be
% centered at x=0
F = fft(ifftshift(f), nt);

% get the a and b values from the complex numbers output from FFT
afft(1:nterms+1) = 2*real(F(1:nterms+1))/nt; % form the coefficients
bfft(1:nterms+1) = -2*imag(F(1:nterms+1))/nt; % form the coefficients


% Plot Results

subplot(2,2,1)
plot(x,f, x,f_approx); 
title('Functuion and Fourier approximation');

subplot(2,2,2)
plot(x, f_approx-f);
title('Error');

subplot(2,1,2)
hold on
stem([0:nterms], b, 'b*')
stem([0:nterms], bfft, 'ro')

stem([0:nterms], a, 'g*')
stem([0:nterms], afft, 'go')

title('Analytic and FFT Fourier Coefficients');


end
