clear all
close all
clc
clf

a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
num = [a b c d a];
den = [1 0 0 0 0];
[h,t] = impz(num,den);

x = [1 2 5 7 9 11 9 7 5 3 1];
[y,t] = my_conv(x);
figure(1)
plot(t,y,'b')
hold on
plot(t,conv(h,x),'r--')
title('My_conv function');
legend('My conv','Matlabs conv')

figure(2)
subplot(5,1,1)
plot(x)
title('X[n]');

subplot(5,1,2)
plot(y)
title('conv filtered');

[matlab_y,zf] = filter(num,den,x);
subplot(5,1,3) 
plot(matlab_y) 
title('matlab fliter');

subplot(5,1,4) 
plot([matlab_y zf'])
title('Corrected');

subplot(5,1,5)
zi = [0 1 2 4];
zi_y = filter(num,den,x,zi);
plot(matlab_y)
title('Corrected by zi');

figure(3)

fy = fft(y,11);
yfromfreq = ifft(fy);
fy2 = fft(y,15);
yfromfreq2 = ifft(fy2);

subplot(1,2,1);plot(yfromfreq)
title('11 Samples');
subplot(1,2,2);plot(yfromfreq2)
title('15 Samples');

length(y) + length(h) - 1
