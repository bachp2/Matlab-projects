clc
clear
%Ve = .2;
Ve = linspace(0.01,0.3,10);
epsilon = .55;
%epsilon = linspace(0.1,0.9,10);
A1 = 4450*Ve;
A2 = 92.446;
A3 = epsilon*5.67e-8;
Tinf = 298; Tsur = 298; Ti = 600+273;%K
xspan = 0:1e-2:5;
for k = 1:10
    hold on
    A1 = 4450*Ve(k);
    %A3 = epsilon(k)*5.67e-8;
    [x, T] = ode45(@(x, T) -(A2*(T-Tinf) + A3*(T^4 - Tsur^4))/A1, xspan, Ti);
    plot(x,T)
end