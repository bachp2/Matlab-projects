x = linspace(-3,3);
y = sin(x);
plot(x,y)

y0 = x;
hold on
plot(x,y0)

y1 = x - x.^3/6;
plot(x,y1)
hold off
str = '$$\sin(x) = \sum_{n=0}^{\infty}{\frac{(-1)^n x^{2n+1}}{(2n+1)!}}$$';
text(-2,1,str,'Interpreter','latex')