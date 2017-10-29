%main function
function draining_tank()
%draining_tank hw4 problem 
% Suppose the tank is  2 meters tall (H = 2), full to begin with (h=H), 
% 1m in diameter at the top and bottom (D0 = 1), 1.1m in diameter at the
% bulge (D(1) = 1.1), and the diameter (d) of the tap is d=0.02m. 
% If I assume the analytic solution eqn (2) for a cylindrical tank is correct
% (i.e. ignoring the bulge) and use that to calculate the time to drain, 
% will it be completely empty? If not, how much water is left?

%global variables
%------------------
global H g D0 d;
%height of the tank
H = 2;%m
g = 9.81;%m/s^2
%diameter of tank's top and bottom 
D0 = 1;%m
%diameter of the tap
d = 0.02;%m 
%------------------

%find tanalytic
%no sign change thus we use error estimation method
tolerance = 0.001;
tanalytic = fzero(@(t) hanalytic(t) - tolerance, 1500);
%disp(tanalytic);
%data of cylindrical tank
t1 = linspace(0, tanalytic, 100);
h1 = hanalytic(t1);
%data of bulge tank
[t2,h2] = ode45(@f, [0, tanalytic], H);
%plot
plot(t1,h1,'r');
hold on;
plot(t2, h2);
hold off;
%the new tank runs out of water first
h2remain = last(h2);
disp('the bulge tank still has water');
disp('Amount of water remains in m^3');
disp(Vtank(h2remain));
end

function v = Vtank(h1)
global D0;
diskfunc = @(h) pi/4.*(D(h).^2);
%result calculated by disk integration
v = quadgk(diskfunc, 0, h1);
%estimate result
%v = pi/4*D0^2*h1;
%both differs by only .0003
end

function h = hanalytic(t)
global D0 H d g;
h = (-sqrt(g/2)*(d^2/D0^2).*t + sqrt(H)).^2;
end

function hprime = f(t,h)
global g d;
hprime = -sqrt(2*g)*(d^2/D(h)^2)*sqrt(h);
end

function diameter = D(h)
global D0;
    function bulge = B(h)
    %B = A*(cosh(1)-cosh((x/C-0.5)*2))/(cosh(1)-1)
    %investigate when x = 0, 2, 1 ; B = 0, .1, 0
    A = .1;
    C = 2;
    bulge = A*(cosh(1)-cosh((h/C-0.5)*2))/(cosh(1)-1);
    end
diameter = D0 + B(h); 
end

%helper function to get the last element in an array
function e = last(A)
e = A(length(A));
end