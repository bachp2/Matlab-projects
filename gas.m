%Bach Phan
%Problem 2
function Volume = gas()
V_ideal = ideal_gas();
%calculate ideal gas
disp('ideal gas');
disp(V_ideal);

V = 0:0.01:1;
eqn = arrayfun(@non_ideal_gas, V);
plot(V, eqn);
%find the root near V ideal
V_non_ideal = fzero(@non_ideal_gas, V_ideal);
disp('non ideal gas');
disp(V_non_ideal);
Volume = [V_ideal, V_non_ideal];
end

function V = ideal_gas()
P = 5*10^4;
T =300;
n = 1;
R = 8.3145;
%formula of the ideal gas law
V = n*R*T/P;
end

function eqn = non_ideal_gas(V)
a = .3643;
b = 4.27*10^-5;
P = 5*10^4;
T =300;
n = 1;
R = 8.3145;
%equation of non-ideal gas law when I move the rhs to the lhs
eqn = (P + a.*(n./V).^2)*(V-b*n) - n*R*T;
end
