function PowerSpectrumPeaks1

% Take FFT of a cosine wave with frequency omega and amplitude amp

nterms = 4;
omega = rand(1,nterms)*10;
amp = 5+rand(1,nterms);

% set the time array
T = 1000;
nt = 2^11;
dt = T/nt;

t=((1:nt)-1)*dt;

% Create f as sum of cosines over the time domain
f=zeros(1,nt);
for i = 1:nterms
% ****** complete this to add up the nterms cosine functions with omega and amp above
 f = f + amp(i)*cos(omega(1)*t);
end

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
xlim([0 11]);
xlabel('Frequency')
ylabel('Power')

% Find Peaks 
% ******** Add Code Here *******

end