function fourier_cosine

% Take FFT of a cosine wave with frequency omega and amplitude amp

omega1 = 1;
omega2 = sqrt(3);
amp = 10;

% set the time array
T = 100000;
nt = 2^20;
dt = T/nt;

t=((1:nt)-1)*dt;

% Create f as sum of two cosines over the time domain
f = amp*cos(omega1*t) + amp*cos(omega2*t);

% Take FFT
F = fft(f);

% get coefficients
a = 2*real(F(1:nt/2))/nt; % form the coefficients
a(1) = a(1)/2;
b = -2*imag(F(1:nt/2))/nt; % form the coefficients

% get power spectrum
power=sqrt(a.^2 + b.^2);

% get the corresponding frequencies: note the 2*pi
w = ((1:nt/2)-1)/T * 2*pi; 

% plot
plot(w, power);
xlim([0 3]);
xlabel('Frequency')
ylabel('Power')

end

