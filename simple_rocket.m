function simple_rocket()
%Bach Phan
%B ENGR 310 A
%28/10/2017
%SIMPLE ROCKET Motion of a Simple Rocket w/ linear fuel burning rate
%The goal is to model the flight of a simple 1-stage rocket taking off from
%the ground during the time it's engine is burning. Assume that the thrust 
%is constant while the stage fires and that fuel mass decreases 
%linearly and the rocket fires continuously until the fuel is expended

rmass = 15*10^4; %kg
fmass = 25*10^5; %kg
burntime = 300; %s
thrust = 45*10^6; %N
    [t, X] = ode45(@rate_func,[0 burntime], [0; 0]);
    %plot(t,X(:,1),'r'); %position wrt t
    %hold on;
    %plot(t,X(:,2),'g'); %velocity wrt t
    %hold off;
    %grid on;
    y = X(:,1);
    m = mass(t);
    f = force(t,y);
    %plot(t,m);
    %hold on;
    plot(t,f);
    grid on;
    function f = force(t, y)
        emass = 5.972*10^24; %kg
        G = 6.674*10^-11; %N*(m/kg)^2
        eradii = 6371*10^3;
        f = thrust - G.*(emass.*mass(t))/((y+eradii).^2);
    end

    function m = mass(t)
        burningrate = fmass/burntime;
        if t <= 300
            m = rmass + fmass - burningrate*t;
        else m = rmass;
        end
    end
    
    function rate = rate_func(t, X)
        % ydot = v
        % vdot = Fy/m(t)
        py = X(1); % y component of position
        vy = X(2); % y component of velocity
        ay = force(t,py)/mass(t); % y component of acceleration
        % compute derivatives
        vdot = ay;
        ydot = vy;
        % pack rate array
        rate = [ydot; vdot];
    end
end

