function Run_lotka
% Example of a coupled system of ODEs to model the population dynamics of a
% preditor-prey system (foxes and rabbits)

% set initial conditions

rabbit0 = 100;
fox0 = 10;
Y0 = [rabbit0; fox0]; % pack the i.c. into a column vector

% testing -- uncomment for simple call to make a plot
% ode45(@lotka, [0 365], Y0)
%
% return

% set the time interval for solving
Tstart=0;
Tend = 365*2; % 2 years

% solve the ODE
[T, X] = ode45(@lotka, [Tstart, Tend], Y0);

% unpack the results. 
% In the output array X, variables are in each column, with time running down the rows 
rabbits = X(:,1); % all rows, first column
foxes = X(:,2); $ all rows, second column

% make some nice plots
figure

% time series
subplot(2,1,1)
plot (T,rabbits, T,foxes)
xlabel('Day')
ylabel('Population')
legend('Rabbits', 'Foxes')

% rabbits vs foxes
subplot(2,1,2)
plot (rabbits,foxes)
xlabel('Rabbits')
ylabel('Foxes')

end

function rate = lotka(t, V)
% Poulation growth of Rabbits and Foxes
% Note that rabbits is first column, foxes second

% unpack the dependent varables
rabbits = V(1);
foxes = V(2);

% set some parameters
a= 0.1;
b= 0.01;
c= 0.1;
e= 0.2;

% a= 0.1*(1 + .5*sin(2*pi*t/365)); % allow annual cycle in rabbit growth

% compute rates for each dependent variable
dr = a*rabbits - b*rabbits*foxes;
df = e*b*rabbits*foxes - c*foxes;

% pack rates into a column vector as the output variable
rate = [dr; df];

end
