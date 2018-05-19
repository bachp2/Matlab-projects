D = 0.25; L = 8; %m
Tmi=300;Tinf=700;Tfur=700; %K
mdot = 6;%kg/s
hi = 300; ho = 50;%W/m^2K
As = pi*D*L;%m^2
sigma = 5.67e-8; epsilon = 1;
Ri = 1/(hi*As);
Ro = 1/(ho*As);
%assume Tmo = Tmi to start the iteration process
Tmo = Tmi;
for k = 1:5
    syms hr(Ts);
    Tm = (Tmo+Tmi)/2;
    hr = sigma*epsilon*(Ts + Tfur)*(Ts^2 + Tfur^2);
    energy_balance = (Tm-Ts)/Ri == (Ts-Tfur)*(1/Ro + hr*As);
    %solve for Ts
    Ts = vpasolve(energy_balance, Ts, [300 700]);
    %calculate R radiation
    Rr = double(1/(subs(hr)*As));
    Rtot = Ri + 1/(1/Ro + 1/Rr);
    %interpolate cp saturated liquid at Tm
    cp = XSteam('CpL_T',Tm-273.15)*1000;%J/kg*K
    Tmo = -exp(-1/(mdot*cp*Rtot))*(Tinf-Tmi) + Tinf;
    Tmo
    double(Ts)
end
