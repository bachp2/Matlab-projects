function trafficDynamics1
global v0 T s0 a b L delta N C;
v0 = 28; %Desired Speed [m/s]
T = 1.8; %Time [s]
s0 = 2.0; %Minimum gap [m]
a = 0.1; %Acceleration [m/s^2]
b = 3; %Deceleration [m/s^2]
L = 5; %Length of car [m]
delta = 4; %Acceleration exponent
endtime = 15*60; %[min] to [s]
d_Xinit = s0+L; %Length of cars + distance between
N = 50; %Number of cars
C = 1000; %[m] circumference of the ring
R = C/(2*pi);
if C/N <= L
    error('can not devide cars evenly on the ring with the gap between front bumper and rear bumper more than L')
end

i = 1:N;
%xinit_lin = -(i(1:N)-1)*(L + d_Xinit);
%vinit_lin = zeros(N,1);

xinit_ring = -(i(1:N) - 1).*(C/N);
vinit_ring = zeros(N,1);

[time, M] = ode45(@idm_ring, [0, endtime], [xinit_ring';vinit_ring]);

%[time, M] = ode45(@idm_linear, [0,endtime], [xinit_lin';vinit_lin]);
pos = M(:,1:N);
vel = M(:,N+1:2*N);
figure(1)
hold on;

subplot(2,1,1);
plot(time,pos);
%title("Ring Driving Model, Position");
title("Linear Driving Model, Position");
xlabel("Time [s]");
ylabel("Position [m]");

subplot(2,1,2);
plot(time, vel);
%title("Ring Driving Model, Velocity");
title("Linear Driving Model, Velocity");
xlabel("Time [s]");
ylabel("Velocity [m/s]");
hold off;


figure(2)

%animation linear driving model
%can be corced into ring model if we take out the first car
%relpos = -pos(:, 2:N) + pos(:,1);
%axis(gca, 'equal');
%axis([min(relpos(:)) max(relpos(:)) -2 2]);
%h = gobjects(N,1);
%for t = 1:length(time)
%    hold on
%    h(1) = plot(0, 0, 'b.', 'MarkerSize', 10);
%    for k = 1:N-1
%    h(k+1) = plot(relpos(t,k), 0, 'b.', 'MarkerSize', 10);
%    end
%    pause(0.001);
%    delete(h(:));
%end

%animation ring driving model
%h = gobjects(N,1);
axis(gca, 'equal');
axis([-R-4 R+4 -R-4 R+4]);
traj = viscircles([0 0],R,'LineStyle',':', 'LineWidth', 1);
for t = 1:length(time)
    hold on
    theta = pos(t,1:N)./R;
    h = plot(R.*cos(theta(:)), R.*sin(theta(:)), 'b.', 'MarkerSize', 15);
    pause(0.001);
    delete(h);
end
delete(traj);
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

global N a v0 L delta T s0 b C;
% unpack your variables array X
% note that you can either use the length function to find mcars
% or nest this inside your main function to share that variable between main and sub function.
x = X(1:N); % positions
v = X(N+1:2*N); % velocities

dx(1:N)=v(1:N);
% loop over cars
% I dont know why this works!
deltav(1) = (v(1) - v(N));
deltav(2:N) = (v(2:N) - v(1:N-1));

% here you enter your Matlab code to apply the rate formulas for the IDM model
% This will be a little different for line of cars vs ring road and will need special
% consideration for the first car.

dv = zeros(1,N);
S(1) = (x(N)-x(1) + C) - L;
S(2:N) = x(1:N-1)-x(2:N) - L;

for i = 1:N
s=s_star(v(i),deltav(i));

dv(i) = a*(1-(v(i)./v0).^delta - (s/S(i)).^2);

end

% Pack the rate array
rate(1:N) = dx;
rate(N+1:2*N) = dv;
rate = rate'; % convert from row to column

function s_asterix = s_star(vel, delv)
s_asterix = s0 + vel*T + ((vel*delv)./(2*sqrt(a*b)));
end

end%ring