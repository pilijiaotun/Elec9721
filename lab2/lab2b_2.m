clc
close all
clear all

load('speech')


Fs = 8000;
a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N1 = [a b c d a];
D = [1 0 0 0 0];
% filter

fredomain = [];
timedomain = [];
fre_afterfil = [];
[h,t] = impz(N1,D,12);
N = 12;
i = 1;
filt = fft(h,N);
while i < length(speech)-13
    temp = fft(speech(i:i+11),N);
    fredomain = [fredomain temp];
    filtered = filt.*temp;
    fre_afterfil = [fre_afterfil filtered];
    temp2 = ifft(filtered);
    timedomain = [timedomain temp2'];
    i = i+12;
end
figure(1)
ts = 0:1/Fs:(length(timedomain)-1)/Fs;
plot(ts,timedomain)
title('Time domain filtered signal')

figure(2)

plot(F,abs(speech_filt_fre));
title('Frequency domain filtered signal')
sound(timedomain)