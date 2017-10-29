[num, txt, raw] = xlsread('labENGR320-1.xlsx','Strain');
strain = num(1:length(raw), 4);
[num, txt, raw] = xlsread('labENGR320-1.xlsx','Stress');
stress = num(1:length(raw), 4);
stress(end) = 0;
plot(strain, stress);
xlabel('Engineering Strain [mm/mm]')
ylabel('Engineering Stress [MPa]')
grid on;
