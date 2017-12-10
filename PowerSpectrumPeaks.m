function PowerSpectrumPeaks

% Take FFT of a cosine wave with frequency omega and amplitude amp

% nterms = 4;
% omega = rand(1,nterms)*10;
% amp = 5+rand(1,nterms);

% set the time array
% T = 1000;
% nt = 2^11;
% dt = T/nt;

% t=((1:nt)-1)*dt;

% Create f as sum of cosines over the time domain
% f=zeros(1,nt);
% for i = 1:nterms
% ****** complete this to add up the nterms cosine functions with omega and amp above
% f = f + ;
% end

% final project
load Case3.mat y t;
x1 = y(1,:);
x2 = y(2,:);
% = y(3,:);
f = x1+x2;
% Take FFT
F = fft(f);
X1 = fft(x1);
X2 = fft(x2);
%X3 = fft(x3);
nt = length(t);
T = t(end);

% get coefficients F
a = 2*real(F(1:nt/2))/nt; % form the coefficients
a(1) = a(1)/2;
b = -2*imag(F(1:nt/2))/nt; % form the coefficients
% get coefficients X1
a_X1 = 2*real(X1(1:nt/2))/nt; % form the coefficients
a_X1(1) = a_X1(1)/2;
b_X1 = -2*imag(X1(1:nt/2))/nt; % form the coefficients
% get coefficients X2
a_X2 = 2*real(X2(1:nt/2))/nt; % form the coefficients
a_X2(1) = a_X2(1)/2;
b_X2 = -2*imag(X2(1:nt/2))/nt; % form the coefficients
% get coefficients X3
% a_X3 = 2*real(X3(1:nt/2))/nt; % form the coefficients
% a_X3(1) = a_X3(1)/2;
% b_X3 = -2*imag(X3(1:nt/2))/nt; % form the coefficients

% get power spectrum
power_f=sqrt(a.^2 + b.^2);
power_x1 = sqrt(a_X1.^2 + b_X1.^2);
power_x2 = sqrt(a_X2.^2 + b_X2.^2);
%power_x3 = sqrt(a_X3.^2 + b_X3.^2);
% get the corresponding frequencies: note the 2*pi
w = ((1:nt/2)-1)/T * 2*pi; 

% plot
plot(t,x1)
subplot(4,1,1); plot(w, power_f)
xlim([0 3]);
xlabel('Frequency');
ylabel('Power');
title('f');
subplot(4,1,2); plot(w, power_x1)
xlim([0 3]);
xlabel('Frequency');
ylabel('Power');
title('x1');
subplot(4,1,3); plot(w, power_x2)
xlim([0 3]);
xlabel('Frequency');
ylabel('Power');
title('x2');
subplot(4,1,4); plot(w, power_x3)
xlim([0 3]);
xlabel('Frequency');
ylabel('Power');
title('x3');

% Find Peaks 
% ******** Add Code Here *******
[pks, locs] = findpeaks(power_f);
disp(pks)
disp(locs)
end
