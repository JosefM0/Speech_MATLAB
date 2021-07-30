clear all
close all
w1 = randn (1,10000);
n = 1:10000;
w2 = cos(0.2 * n);
w = w1 + w2;

[R,nu] = xcorr(w,50,'unbiased');
subplot(111)
stem(nu,R)
ylabel('R[nu]')
grid
axis([-50 50 -1 2])
