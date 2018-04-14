function [r_A, r_hg] = composite_wall()
%UNTITLED2 Summary of this function goes here
% %   Detailed explanation goes here
n = 3; %number of composite layers
hi = 500;%W/m^2*K
ho = 1e3;%W/m^2*K

%compose into arrays
h = [ho, hi];
k = [1.3 25];
L = [0.5e-3 5e-3];

To = 1700; %K temp outside conv
Ti = 400; %K temp inside conv
Ts = sym('Ts', [1 n+1]);%Temp on sides of each layer
qpp = sym('qpp');% q'' heat flux W/m^2
Rct = 1e-4; %m^2*K/W contact thermal resisteance

%set up master matrices
T = [To Ts Ti]';
num_row = size(T,1);
%haven't got a name for it yet so I'll call it stiffness matrix making an 
% analogy to Springs system linear equations
A = diag(ones(num_row,1),0) + -1*diag(ones(num_row -1,1),1);
A(end,:) = [];%remove last row
R = [1/h(1) L(1)/k(1) Rct L(2)/k(2) 1/h(2)]';
%R = R.*qpp;
S = solve(A*T == R.*qpp );%will return array of structs

%get temperature of each layer in number
Tdist(1) = double(subs(S.Ts1));
Tdist(2) = double(subs(S.Ts2));
Tdist(3) = double(subs(S.Ts3));
Tdist(4) = double(subs(S.Ts4));
%plot
X = [0 L(1) L(1)+.001 L(1)+.0001+L(2)];
r_hg = double(subs(S.qpp));
r_A(2,:) = Tdist;
r_A(1,:) = X;

end
