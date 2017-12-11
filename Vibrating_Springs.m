clear all

% Fill in these two matices and the rest is automatic
% Stiffness matrix nxn for n masses
A = diag(-2*ones(4,1),0) + diag(ones(4 -1,1),1) + diag(ones(4 -1,1),-1);
A(1,1) = -1;
%A = [-5 1.99; 1.99 -5];
x0=[1 1 1 1]';   % Initial condition


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[v,d]=eig(A);          %Find Eigenvalues and vectors.
omega=sqrt(diag(-d));  %Get frequencies from eigenvalues -- omega is a vector containing the n frequencies
gam=inv(v)*x0;         %Find unknown coefficients


%nxn array with coefficients of gamma along the diagonal
g=diag(gam);

t=0:0.2:20;         %1xM Time vector (for plotting)
% cos(omega*t) is an nxM array with
%        cos(w1*t),...,cos(wn*t) in rows
x=v*g*cos(omega*t); %Calculate output

% Display pertinent information about the system
disp('A matrix'); disp(A)
disp('Eigenvalues'); disp(diag(d)')
disp('Eigenvectors (each column is an eigenvector)'); disp(v)
disp(['Frequencies, omega=' sprintf('%4.2f, ',omega)]);
disp(['Initial Conditions, x(0)=' sprintf('%4.2f, ',x0)]);
disp(['Unknown coefficients, gamma=' sprintf('%4.2f, ',gam)]);

%This next code does some string manipulation to make 
%legends for the plots, no calculations.  It is not necessary
%to understand this code to understand the graphs;
N=size(A,1);
outLeg='';
modLeg='';
for i=1:N,
    outLeg=strvcat(outLeg, strcat('Out_',int2str(i)));
    mstr=sprintf('Mode_%d',i);
    modLeg=strvcat(modLeg, mstr);
end

%Plot the output trajectories
subplot(2,1,1);
plot(t,x)
xlabel('Time'); ylabel('Output'); 
title(['Output vs. time, x_i(0)=' sprintf('%4.2f, ',x0) ...
    ' \gamma_i=' sprintf('%4.2f, ',gam)]);
legend(outLeg);

%Plot the mode shapes
subplot(2,1,2)
plot(v,':');
xlabel('Elements'); ylabel('Mode amplitude'); 
title(['Mode shapes, \omega=' sprintf('%4.2f, ',omega)]);
axis([0.5 N*1.5 -1 1]);
set(gca,'XTick',[1:N]);
legend(modLeg);
hold on
stem(v);
hold off
