clear all
clc
close all

load('s');
load('speech')

a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N = [a b c d a];
D = [1 0 0 0 0];
ts = 0:1/8000:(length(s)-1)/8000;
% flilter from lab2a

Fs = 8000; %sampled at 8k Hz
len = max([length(s)/Fs length(speech)/Fs]);
% sound(s,Fs)
% pause(len) %Pause after finish play
% sound(speech,Fs)
% pause(len)

[s_filt,zf] = filter(N,D,s);
[speech_filt,zf2] = filter(N,D,speech);
% sound(s_filt,Fs)
% pause(len)
% sound(speech_f,Fs)
% The sound has become less sharp and the volume has decreased
% The noise is decreased

N = 2048;

% figure(1)
% subplot(3,1,1)
% ts = 0:1/Fs:(length(s)-1)/Fs;
% plot(ts,s)
% title('Time domain before filtering')
% subplot(3,1,2)
% plot(ts,s)
% title('Time domain before filtering between(0.1,0.2)')
% xlim([0.1,0.2])
% zoomed

s_fre = fftshift(fft(s,N));
F = ([-N/2:(N-1)/2]/N)*Fs;
% subplot(3,1,3)
% plot(F,abs(s_fre));
% title('Frequency domain before filtering')

% figure(2)
% subplot(3,1,1)
% ts = 0:1/Fs:(length(s_filt)-1)/Fs;
% plot(ts,s_filt)
% title('Time domain after filtering')
% subplot(3,1,2)
% plot(ts,s_filt)
% title('Time domain after filtering between(0.1,0.2)')
% xlim([0.1,0.2])


s_filt_fre = fftshift(fft(s_filt,N));
F = ([-N/2:(N-1)/2]/N)*Fs;
% subplot(3,1,3)
% plot(F,abs(s_filt_fre));
% title('Frequency domain after filtering')
% 

% figure(3)
% subplot(4,1,1)
% ts = 0:1/Fs:(length(speech)-1)/Fs;
% plot(ts,speech)
% speech_fre = fftshift(fft(speech,N));
% F = ([-N/2:(N-1)/2]/N)*Fs;
% subplot(4,1,2)
% plot(F,abs(speech_fre));
% title('Frequency domain before filtering')
% subplot(4,1,3)
ts = 0:1/Fs:(length(speech_filt)-1)/Fs;
% plot(ts,speech_filt)
speech_filt_fre = fftshift(fft(speech_filt,N));
F = ([-N/2:(N-1)/2]/N)*Fs;
% subplot(4,1,4)
% plot(F,abs(speech_filt_fre));
% title('Frequency domain after filtering')

s_filt_fre = fftshift(fft(s_filt,N));
F = ([-N/2:(N-1)/2]/N)*Fs;
L = 12;
i = 1;
i = i+L;
s1 =1
Fs = 8000;
a = -0.0625;
b = 0.25;
c = 0.625;
d = 0.25;
N1 = [a b c d a];
D = [1 0 0 0 0];

tot = [];
out = [];
filtot = [];
[h,t] = impz(N1,D);
h = h';

M = length(h);
L = 12;
N = L+M-1;
i = 1;
s1 = [zeros(1,M-1) s(i:i+L-1)];
i = i+L;
h1 = [h zeros(1,L-1)];

yprime = ifft(fft(s1).*fft(h1));
yprime;
y = [];
y = [y yprime(M:end)];
tobeappended = yprime(length(yprime)-M+2:end);

yprime = ifft(fft(s1).*fft(h1));
yprime;
y = [];
y = [y yprime(M:end)];
tobeappended = yprime(length(yprime)-M+2:end);

freqspec = [];

while i < length(s)-12-1
    s1 = [s(i:i+L-1) zeros(1,M-1)];
    freqspec = [freqspec fft(s1).*fft(h1)];
    yprime = ifft(fft(s1).*fft(h1));
    y = [y(1:length(y)-M+1) y(length(y)-M+2:end)+yprime(1:M-1) yprime];
    tobeadded = yprime(1:length(yprime)-M+1);
    i = i+L;
end

plot(F,abs(speech_filt_fre));
title('Spec of overlap add')