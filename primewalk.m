% Create rotation matrix
theta = 90; % to rotate 90 counterclockwise
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];

% direction
dir = [1 0];
% create pixel grid
h = 1000;
w = 1000;
steps = h*w;
frame = zeros(max(h,w));
listprimes = primes(steps);
lastcount = length(listprimes);

counter = 1;
p = [w/2 h/2];

for x = 1:steps
    if counter == lastcount
    break;
    end
    
    frame(p(1), p(2)) = 1;
    p = p + dir;
    if x == listprimes(counter)
    counter = counter+1;
    dir = dir*R;
    end

    if p(1) < 1 
    dir = dir*R;
    p(1) = 1;
    p = p + dir;
    elseif p(1) > w 
    dir = dir*R;
    p(1) = w;
    p = p + dir;
    end

    if p(2) < 1
    p(2) = 1;
    dir = dir*R;
    p = p + dir;
    elseif p(2) > h
    p(2) = h;
    dir = dir*R;
    p = p + dir;
    end
end

imshow(frame, 'InitialMagnification', 'fit')