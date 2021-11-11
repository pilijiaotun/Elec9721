clear all
close all
clc
clf

fs = 8000; %Sampling frequency
Wp = [1500/(fs/2), 2000/(fs/2)]; %Passband
Ws = [1000/(fs/2), 2500/(fs/2)]; %Stopband 
bd = 500;
thetac = mean(Wp)*pi;
thetab = ((Wp(end)-Wp(1))/2)*pi;
N= 22; %Order
Beta = N/2;

n = 0:N-1;

h = (1./(pi*(n-Beta))).*(sin((thetac+thetab)*(n-Beta)) - sin((thetac-thetab)*(n-Beta)));
h(12)=0.25;

figure(1)
stem(n,h)
title('Impulse response')

figure(2)
[H,w] = freqz(h);
w = w*fs/(2*pi);
subplot(2,1,1)
plot(w,unwrap(angle(H))*180/pi)
xlabel('Hz')
title('Phase response (Freqz)')
subplot(2,1,2)
plot(w,abs(H))
xlabel('Hz')
title('Magnitude response (Freqz)')