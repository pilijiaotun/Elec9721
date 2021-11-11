clc
clf
clear all
close all

[speech,fs] = audioread('speech.wav');

% Upsample by 3.
speechup = zeros(1,3*length(speech));
k=1;
for i=1:length(speechup)
    if mod(i,3) == 0
        speechup(i) = speech(k);
        k = k+1;
    end
end

fsU = fs*3;  %U
n = 80;
fc = 8000; % lpf 
scaledfc = fc/(fsU/2);

f1 = [0.0 scaledfc-0.1 scaledfc+0.1 1];
a1 = [1.0 1.0 0.0 0.0];
b1 = firpm(n,f1,a1);
[h1,w1] = freqz(b1,1,1024,fsU);

speechfilt = filter(b1,1,speechup);

speechfinal = speechfilt(1:2:end);
fsfinal = fsU/2; % D

figure(1)

subplot(5,1,1)
N = 2024; 
fftSpeech = abs(fftshift(fft(speech, N)));
F = [0:N/2]*(fs)/N;
plot(F,fftSpeech([N/2:end]))
title('original speech')


subplot(5,1,2)
fftSpeechUp = abs(fftshift(fft(speechup, N)));
F = [0:N/2]*(fsU)/N;
plot(F,fftSpeechUp([N/2:end]))
title('after upsamples by 3')
subplot(5,1,3)
plot(w1,abs(h1))
title('lpf')



subplot(5,1,4)
fftSpeechFilt = abs(fftshift(fft(speechfilt, N)));
F = [0:N/2]*(fsU)/N;
plot(F,fftSpeechFilt([N/2:end]))
title('after losspass')

subplot(5,1,5)
fftspeechfinal = abs(fftshift(fft(speechfinal, N)));
F = [0:N/2]*(fsfinal)/N;
plot(F,fftspeechfinal([N/2:end]))
title('result')


player1 = audioplayer(speech, fs);
play(player1);
pause(2.5)
player2 = audioplayer(speechfinal, fsfinal);
play(player2);