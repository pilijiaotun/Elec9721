clear all
clc
clf
close all
% ‘fir1’ matlab command (that is the matlab command for windowing
% method) using the rectangular window (Matlab rectwin)

fs = 8000; %Sampling frequency
Wp = [1500/(fs/2), 2000/(fs/2)]; %Passband
Ws = [1000/(fs/2), 2500/(fs/2)]; %Stopband 
n= 22; %Order

b = fir1(n,Wp,rectwin(n+1));
figure(1)
[H,w] = freqz(b);
w = w*fs/(2*pi);
subplot(2,1,1)
plot(w,unwrap(angle(H))*180/pi)
xlabel('Hz')
ylabel('Degrees')
title('Phase response')
subplot(2,1,2)
plot(w,20*log10(abs(H)))
xlabel('Hz')
ylabel('dB')
title('Magnitude response')








