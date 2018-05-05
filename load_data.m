T = csvread('heat_transfer_a4_air.csv',1,0);
varNames = {'T', 'rho', 'cp', 'mu', 'nu', 'k', 'alpha', 'Pr'};
T = array2table(T,'VariableNames', varNames);
T.Properties.VariableUnits = {'K', 'kg/m3', 'kJ/kg*K','N*s/m2','m2/s','W/m*K','m2/s', ''};
%scale to correct units
T.mu    = T.mu*1e-7;
T.nu    = T.nu*1e-6;
T.k     = T.k*1e-3;
T.alpha = T.alpha*1e-6;
intpl_data = b_interpolate(T,'T',433)
writetable(T,'heat_transfer_A4_Air');
save('A4','T');