t = 0:1024;
a = rand(16,1);
A1 = dft_slow(a);
A2 = b_fft(a);
all_close(A1,A2)
