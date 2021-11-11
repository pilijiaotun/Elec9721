
load('speech')
s = speech';



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

freqspec = [];

while i < length(s)-12-1
    s1 = [tobeappended s(i:i+L-1)];
    freqspec = [freqspec fft(s1).*fft(h1)];
    yprime = ifft(fft(s1).*fft(h1));
    y = [y yprime(M:end)];
    tobeappended = yprime(length(yprime)-M+2:end);
    i = i+L;
end
subplot(2,1,1)
y_conv =conv(h,speech);
plot(abs(y_conv));
title('conv of h and speech')
subplot(2,1,2);
plot(abs(freqspec))
title('after overlap save')

figure(2)
subplot(2,1,1)
plot(y)
subplot(2,1,2)
plot(F,abs(speech_filt_fre));
title('Frequency domain filtered signal after overlap save')

sound(y)
