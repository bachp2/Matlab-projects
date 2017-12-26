% Bach Phan
% bachp2@uw.edu
% Dec 25 2017
% Game of Life simulation

function grid = gameoflife()
h = 100;
w = 100;
grid = randi([0 1], h,w);

for i = 1:200
   grid = updateworld(grid);
   imshow(grid, 'InitialMagnification', 'fit');
   pause(0.1);
end

function succ = updateworld(pred)
    succ = zeros(h,w);
    for r = 1:h
        for c = 1:w
            lc = checkcells(pred, r, c);
            if pred(r,c)
                liveneighbors = lc - 1;
                if liveneighbors < 2 || liveneighbors > 3
                   succ(r,c) = 0;
                else
                   succ(r,c) = 1;
                end
            else
                deadneighbors = 8 - lc;
                if deadneighbors == 3 
                    succ(r,c) = 1; 
                end
            end
        end
    end
end

function livecells = checkcells(world, y, x)
    if y == 1 && x == 1
        livecells = sumint(world(y:y+1, x:x+1));
    elseif y == h && x == w
        livecells = sumint(world(y-1:y, x-1:x));
    elseif y == h && x == 1
        livecells = sumint(world(y-1:y, x:x+1));
    elseif y == 1 && x == w
        livecells = sumint(world(y:y+1, x-1:x));
    elseif y == 1
        livecells = sumint(world(y:y+1, x-1:x+1));
    elseif x == 1
        livecells = sumint(world(y-1:y+1, x:x+1));
    elseif y == h
        livecells = sumint(world(y-1:y, x-1:x+1));
    elseif x == w
        livecells = sumint(world(y-1:y+1, x-1:x));
    else
        livecells = sumint(world(y-1:y+1, x-1:x+1));
    end
end

function s = sumint(A)
    s = sum(A(:));
end
end

