function trafficDynamics
global v0 T s0 a b L delta N;
v0 = 28; %Desired Speed [m/s]
T = 18; %Time [s]
s0 = 7.0; %Minimum gap [m]
a = 0.3; %Acceleration [m/s^2]
b = 3; %Deceleration [m/s^2]
L = 5; %Length of car [m]
delta = 4; %Acceleration exponent
endtime = 50*60; %[min] to [s]
d_Xinit = s0+L; %Length of cars + distance between
N = 10; %Number of cars
%C = 1000; %Circumference of circle [m]
%distrib = C/N; %Even distrubution of cars around circle [m/cars]

i = 1:N;
xinit = (-(i(1:N)-1)*(L + d_Xinit));
vinit = zeros(N,1);

[time, M] = ode45(@idm_linear, [0,endtime], [xinit';vinit]);

figure(1)
hold on

subplot(2,1,1)
plot(time,M(:,1:N)./1000)
title("Linear Driving Model, Position");
xlabel("Time [s]");
ylabel("Position [km]");

subplot(2,1,2)
plot(time, M(:,N+1:2*N));
title("Linear Driving Model, Velocity");
xlabel("Time [s]");
ylabel("Velocity [m/s]");

end%main

function rate = idm_linear(t, X)
% IDM: Intellegent Driver model

global N a v0 L delta T s0 b;
% unpack your variables array X
% note that you can either use the length function to find mcars
% or nest this inside your main function to share that variable between main and sub function.
x = X(1:N); % positions
v = X(N+1:2*N); % velocities

dx(1:N)=v(1:N);
% loop over cars
deltav(1) = 0;
deltav(2:N) = -v(2:N) + v(1:N-1);

% here you enter your Matlab code to apply the rate formulas for the IDM model
% This will be a little different for line of cars vs ring road and will need special
% consideration for the first car.

dv = zeros(1,N);

for i = 1:N
if i == 1
dv(i) = a*(1-(v(i)/v0).^delta);
else
S = ((x(i-1)-x(i))-L);
s=s_star(v(i),deltav(i));
dv(i) = a*(1-(v(i)./v0).^delta - (s/S).^2);
end

end
% Pack the rate array
rate(1:N) = dx;
rate(N+1:2*N) = dv;
rate = rate'; % convert from row to column

function s_asterix = s_star(vel, delv)
s_asterix = s0 + vel*T + ((vel*delv)./(2*sqrt(a*b)));
end

end%linear

function rate = idm_ring(t, X)
% IDM: Intellegent Driver model

global N a v0 L delta T s0 b;
% unpack your variables array X
% note that you can either use the length function to find mcars
% or nest this inside your main function to share that variable between main and sub function.
x = X(1:N); % positions
v = X(N+1:2*N); % velocities

dx(1:N)=v(1:N);
% loop over cars
deltav(1) = -v(1) + v(N);
deltav(2:N) = -v(2:N) + v(1:N-1);

% here you enter your Matlab code to apply the rate formulas for the IDM model
% This will be a little different for line of cars vs ring road and will need special
% consideration for the first car.

dv = zeros(1,N);

for i = 1:N
if i == 1
    S = ((x(end)-x(i))-L);
else
    S = ((x(i-1)-x(i))-L);

s=s_star(v(i),deltav(i));
dv(i) = a*(1-(v(i)./v0).^delta - (s/S).^2);
end

% Pack the rate array
rate(1:N) = dx;
rate(N+1:2*N) = dv;
rate = rate'; % convert from row to column

function s_asterix = s_star(vel, delv)
s_asterix = s0 + vel*T + ((vel*delv)./(2*sqrt(a*b)));
end

end%ring