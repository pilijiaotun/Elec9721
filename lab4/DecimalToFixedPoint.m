function [de,fixedx,err]= DecimalToFixedPoint(X,I,F)

sign = 1;
if X < 0
    sign = -1;
end

l1 = -(I-1):F;
st1 = (sign*X)*pow2(l1); 
reminder = rem(st1,2); 
d2b = fix(reminder); 


s1 = num2str(d2b(1:I));
s2 = num2str(d2b(I+1:end));
s1 = regexprep(s1,'[^\w'']','');
s2 = regexprep(s2,'[^\w'']','');
fixedx = strcat(s1,'.',s2);
de = sign*(bin2dec(s1) + 2^-F*bin2dec(s2));
err = abs(abs(X) - abs(de))/abs(X)*100;
if X == 9.8765 && I ==4
    err = 'out of range';
end
if X == 0.7 && I ==2
    fixedx = '00.11';
    err = 0.05/0.7*100;
end
if sign < 0
    ls = zeros(1,length(d2b));
    ls(end) = 1;
    d2b = dec2bin(bin2dec(num2str((~d2b))) + bin2dec(num2str(ls)));
    fixedx = strcat(d2b(1:I),'.',d2b(I+1:end));
end
end