function A = b_interpolate(T, var_name, TBDx)
i = find(strcmpi(T.Properties.VariableNames,var_name));
len = height( T(:,i) );

if ~check_range(T{1,i}, T{len,i}, TBDx)
    fprintf('can not interpolate outside range [%d %d]', T{1,i}, T{len,i});
    A = [];
    return
end
%get index of the closest value to the TBD variable
[m, j] = min(abs(T{:,i} - TBDx));
if T{j,i} < TBDx 
    j = j+1;
end

tmp = table2array(T(j-1:j,:));
x1 = tmp(1,i);
x2 = tmp(2,i);
intpl = tmp(1,:) + (tmp(2,:)-tmp(1,:))./(x2-x1).*(TBDx - x1);
A = array2table(intpl, 'VariableNames', T.Properties.VariableNames);
end 

function inrange = check_range(s, e, v)
if v >= s && v <= e || v <= s && v >= e 
   inrange = 1;
   return;
else
    inrange = 0;
    return;
end
end
