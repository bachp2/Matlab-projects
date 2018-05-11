clear
clc
Ts = 350+273.15; Ti = 25+273.15; %K
D = 12e-3; ST = 24e-3; SL = 30e-3; L = .25;%m
V = 15;%m/s
NL = 3; NT = 4; N = NL*NT;
Vmax = ST/(ST-D)*V;%eqn for aligned tubes

TableA4 = getfield(load('A4.mat'),'T');
%guess To = Ti;
To = Ti;
for k = 1:5
    Tm = (To+Ti)/2;
    tmp  = b_interpolate(TableA4,'T',Tm);
    tmp1 = b_interpolate(TableA4,'T',Ts);
    n   = tmp.nu(1);
    pr  = tmp.Pr(1);
    prs = tmp1.Pr(1);
    ReDMAX = Vmax * D / n;
    %ST/D %2
    %SL/D %2
    C1 = .229; m = .632; C2 =.86;
    C = .27;
    %NubarD = C2*1.13*C1*ReDMAX^m * pr^(1/3);
    NubarD = C2*C*ReDMAX^m * pr^(.36) * (pr/prs)^(1/4);
    hbar = NubarD* tmp.k(1) / D;
    i_rho = tmp.rho(1);
    i_cp = tmp.cp(1);
    To = Ts - exp(-pi*D*N*hbar/(i_rho*V*NT*ST*i_cp*1000))*(Ts-Ti);
end
To
ReDMAX;
DeltaTlm = ((Ts-Ti)-(Ts-To))/log((Ts-Ti)/(Ts-To));
qprime = N*hbar*pi*D*DeltaTlm;
q = qprime * L
Chi = 2.3; f = 0.18;
pressdrop = NL*Chi*i_rho*Vmax^2/2*f
Vdot = V*NT*ST*L;
P = Vdot*pressdrop
%%
% clear
% clc
% Ts = 350+273.15; Ti = 25+273.15; %K
% D = 12e-3; L = .25;%m
% V = 15;%m/s
% TableA4 = getfield(load('A4.mat'),'T');
% for k = 1:1
%     Tf = (Ts+Ti)/2
%     tmp  = b_interpolate(TableA4,'T',Tf)
%     ReD = V * D / tmp.nu(1)
%     pr = tmp.Pr(1)
%     NubarD = 0.3 + (.62*ReD^.5 * pr^(1/3))/(1+(0.4/pr)^(2/3))^0.25*(1+(ReD/282000)^(5/8))^(4/5)
%     hbarD = NubarD*tmp.k(1) / D;
% end
% hbarD
