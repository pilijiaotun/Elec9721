clc
clf
clear all
close all
%  Park McClellan method using Matlab (Matlab command firpm). 
fs = 15000; %Sampling frequency
Wp = [0, 2300/(fs/2)]; %Passband
Ws = [2400/(fs/2), 7500/(fs/2)]; %Stopband 
Rp = 2; %Passband ripple
Rs = -30; %Stopband attenuation
eps = 10e-10;

f = [0 Ws(1) Wp Ws(end) 1];
m = [0 0 1 1 0 0];

Passbandripple = 10;
Stopbandattenuation = -10;
n=10;
pass = [];
stop = [];

while(Passbandripple > Rp && Stopbandattenuation > -Rs)
    b = firpm(n,f,m);
    [H,w] = freqz(b);
    w=w/(pi);
    Hdb = 20*log10(abs(H));
    Passabandripple = abs(max(Hdb(w>Wp(1) & w < Wp(end)))-min(Hdb(w>Wp(1) & w < Wp(end))));
    pass(end+1)=Passabandripple;
    Stopbandattenuation = min(Hdb((w>Ws(1) & w < Wp(1)) | ((w>Wp(end) & w < Ws(end)))));
    stop(end+1)=Stopbandattenuation;
    n = n+1;
end

st = zeros(1,length(w));
st((w>Ws(1) & w < Wp(1)) | ((w>Wp(end) & w < Ws(end)))) = Stopbandattenuation;
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
hold on
plot([0, 1000],[Stopbandattenuation Stopbandattenuation],'r')
hold on
plot([2500, 4000],[Stopbandattenuation Stopbandattenuation],'r');
hold on
plot([0, 4000],[1 1],'r')
hold on

xlabel('Hz')
ylabel('dB')
title('Magnitude response')