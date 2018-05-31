clc
clear
x=linspace(0,6,10000);
v=-30*(x>0)+56*(x>1)-50*(x>4)+24*(x>7);
m=-30*(x>0).*(x-0)+56*(x>1).*(x-1)-50*(x>4).*(x-4)+24*(x>7).*(x-7);
mm = cumtrapz(x,v);
subplot(311);
area(x,v);
subplot(312);
area(x,mm);
subplot(313);
area(x,m);