function freefall
% FREEFALL: falling!

% set parameters
m = 75; % kg
g = 9.81; % m/s^2
c = 0.2;

% set initial conditions
% horiz
x0 = 100;
v0 = 10;


% pack i.c.
X0=[x0; v0];

% solve Newton's Second Law

% uncomment these for testing
% ode45(@rate_func, [0,20], X0);
% return

[t, Xout] = ode45(@rate_func, [0,20], X0);

% unpack
xout=Xout(:,1);
vout=Xout(:,2);

% find the time step where the ground is crossed
iground  = 1;
while xout(iground)>0
    iground=iground+1;
end

% plot up to the point of crossing the ground
figure
plot(t(1:iground),xout(1:iground))

% interpolate to find exact time for hitting the ground
tground = interp1(xout,t, 0);
disp(['Hits ground at ',num2str(tground)])


    function rate = rate_func( t, X )
        % RATE_FUNC: Newton's 2nd Law
        
        % unpack
        px = X(1); % x component of position
        vx = X(2); % x component of velocity
        
        % compute forces
        
        Fgravity = -m*g; % gravity
        Fdrag = -sign(vx) * c*vx^2; % air resistance
        
        Fx = Fgravity + Fdrag; % x component of force
        
        % Compute acceleration according to Newton's second law
        
        ax = Fx/m; % x component of acceleration
        
        % compute derivatives
        dpx = vx;
        dvx = ax;
        
        % pack rate array
        rate = [dpx; dvx];
        
    end

end