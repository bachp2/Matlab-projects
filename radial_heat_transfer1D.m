function S = radial_heat_transfer1D()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Part a
%set up heat equation
syms T(r) qdot
DT = diff(T);
qdot = 1e8;%W/m^3
%qdot = 4.17e8;%W/m^3 Guess value for part C
k1 = 57;%W/m*K
k2 = 3;%W/m*K
h = 2.5e3;%W/m*2*K
Tinf = 700;%K
ode = diff(r*DT) == -r*qdot/k1;
%detour calculate heat rate and T2
r1 = 8e-3;
r2 = 11e-3;
r3 = 14e-3;

qpp = qdot*(r2^2 - r1^2)/(2*r2);%q''
qp = qpp*2*pi*r2;

Rpp23 = r2*log(r3/r2)/k2;%R''_2,3
Rp23 = Rpp23/(2*pi*r2);

Rpp3inf = 1/(h);%R''_3,inf
Rp3inf = Rpp3inf/(2*pi*r3);

Rp2inf = Rp23 + Rp3inf;
Rpp2inf = Rpp23 + Rpp3inf;

%T2 = Tinf + qpp*Rpp2inf;
T2 = Tinf + qp*Rp2inf;
T3 = T2 - qp*Rp23;
%this should be the same as previous line but it is not
%T3 = Tinf - qp*Rp3inf; 

%set up boundary conds
cond1 = T(r2) == T2;
cond2 = DT(r1) == 0;%adiabatic cond
conds = [cond1 cond2];

Tdist(r) = dsolve(ode, conds);
Tdist = simplify(Tdist);
T1 = double(Tdist(r1));
disp(T1)
disp(T2)
disp(T3)

%Part b
nR = r1:1e-4:r2;
nT = double(Tdist(nR));
plot(nR, nT);
hold on
plot([r2 r3], [T2 T3]);
hold off

%Part c
%melting point of thorium is 2023K
% from experimenting with qdot value
% when qdot is around 4.17e8 W, Thorium reached melting temperature. Therefore, 
% an allowable qdot is less than 4.18e8 W

%set up the same heat equation
% syms T(r) qdot
% DT = diff(T);
% k1 = 57;%W/m*K
% ode = diff(r*DT) == -r*qdot/k1;
%boundary conds
% T1 = 2023;%K
% cond0 = T(r1) == T1;
% cond2 = DT(r1) == 0;%adiabatic cond
% conds = [cond0 cond2];
% 
% Tdist(r) = dsolve(ode);
% eqn = Tdist(r1) == T1
% format shortEng
% format compact
%S = double(vpasolve(eqn, qdot));%W
end

