function manyfins_conduction()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%physical onstrains goes here
%h = 100;
h = [100:.01:1000]';
W = 20;%mm
N = 1:11;
t = (W-(N-1)*1.8)./N;%mm
etaf = tanh(sqrt((h/90./(t.*10^-3))).*.015)./(sqrt((h/90./(t.*10^-3))).*.015);
%auxilary constrains
Af = 6e-4;%m^2
Ab = 0.02^2 - N.*mm2m(W).*(mm2m(t));%m^2
At = N.*Af + Ab;
eta0 =1 - N.*Af./At.*(1-etaf);
%%%%%%%%%%%%%%%%%%%%%
Rt0 = (eta0.*h.*At).^-1;%K/W
qc = (90-25)./(0.005+.043+ Rt0);

%display table
% varNames = {'N','t','etaf', 'Rt0', 'qc', 'At'};
% T = table(N(5:11)', t(5:11)', etaf(5:11)', Rt0(5:11)', qc(5:11)', At(5:11)', 'VariableNames',varNames);
% disp(T)

%plot
figure

subplot(2,1,1)       
title('Subplot 1')
plot(h, qc(:,11));
xlabel('convection coeff. h(W/m^2K)');
ylabel('heat rates in W with 11 fins');
grid on
grid minor

subplot(2,1,2)            
title('Subplot 2')
plot(h, qc(:,11));
xlabel('convection coeff. h(W/m^2K)');
ylabel('heat rates in W of different fins number');
hold on
for i = 10:-1:1
    plot(h, qc(:,i));
end
hold off
grid on
grid minor
end


function m = mm2m(mm)
m = mm./1000;
end
