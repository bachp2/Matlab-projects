function b = all_close(A, B)
atol = 5e-6;rtol = 3e-5; 
b = all( abs(A(:)-B(:)) <= atol+rtol*abs(B(:)) );
return;
end

