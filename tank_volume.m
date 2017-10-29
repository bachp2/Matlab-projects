%Bach Phan
%tank volume problem
function sol = tank_volume()
  h = 0:1:20;
  V = arrayfun(@function_tank_volume, h);
  plot(h,V);
  hline = refline([0 45]);
  hline.Color = 'r';
  h1 = fzero(@(h) function_tank_volume(h) - 45, 4);%first root
  h2 = fzero(@(h) function_tank_volume(h) - 45, 14);%second root
  sol = [h1,h2];
  disp(sol);
end

function V = function_tank_volume(h)
  D = 10; %m
  C = 1/2;
  V = D^3*C*pi/12*(3*(h/D)^2 - 2*(h/D)^3);
end