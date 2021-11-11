clear all
close all
clc
clf
figure(2)
subplot(2,2,1)
plot(x)
title('input X','interpreter','latex','fontsize',16);

subplot(2,2,2)
plot(y)
title('Filtered with convolution','interpreter','latex','fontsize',16);

[y2,zf] = filter(num,den,x); %Filter returns x filtered but at the same length.
subplot(2,2,3) 
plot(y2) % So y2 are missing the last values, but found in zf.
title('Filtered with matlabs filter function','interpreter','latex','fontsize',16);

subplot(2,2,4) 
plot([y2 zf']) % So y2 are missing the last values, but found in zf.
% Contains the values that are supposed to go as input to "next sequence"
% or delayed values, in this case we have 4 delayed values.
title('Corrected','interpreter','latex','fontsize',16);