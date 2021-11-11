clear all
clc
clf
close all

fs = 2500;
passband = [0 500];
stopband = [600 1250];
fc = (passband(end) + stopband(1))/2;
N = 21;
Beta = (N-1)/2;
thetac = fc/fs * 2*pi;
n = 0:N-1;
thetanopi = fc/fs * 2;

h = sinc(thetanopi*(n-Beta))*thetanopi;


figure(1)
[H,w] = freqz(h);
w = w*fs/(2*pi);
subplot(2,1,1)
plot(w,unwrap(angle(H))*180/pi)
xlabel('Hz')
title('Phase response (Freqz1)')
subplot(2,1,2)
plot(w,abs(H))
xlabel('Hz')
title('Magnitude response (Freqz1)')

Nf = 2024; 
Hfft = (fftshift(fft(h, Nf)));
Hfft = Hfft((length(Hfft)+1)/2:end);
F = ([0:(Nf-1)/2]/Nf)*fs;
figure(2)
subplot(2,1,1)
plot(F,unwrap(angle(Hfft))*180/pi)
xlabel('Hz')
title('Phase response (FFT)')
subplot(2,1,2)
plot(F,abs(Hfft))
xlabel('Hz')
title('Magnitude response (FFT)')


