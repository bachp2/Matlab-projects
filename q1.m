%hw1 :: 09/30/2017
%Bach Phan
%B ENGR 310A Computation Physical Modeling

%fibonacci using formula

for n = 1:10
   y = fibo(n);
   disp(y);
end

%fibonacci using recursion
A = zeros(10,1);
A(1) = 1;
A(2) = 1;
for i = 3:10
    A(i) = A(i-1) + A(i-2);
    disp(A(i));
end

