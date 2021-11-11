function fixed_bin=my_fix_flr_bin(a,numint,numdec)
% a为被定点化的矩阵或标量,为实数
% numint位整数，numdec位小数
% 选取的总位数为1+numint+numdec，其中1为符号位所占用
fixed_a=floor(a*2^numdec);  % 模拟计算机中直接截位的结果
% 限幅
if ((fixed_a>=2^(numint+numdec))||(fixed_a<-2^(numint+numdec)))
    fixed_a=sign(a)*(2^(numint+numdec)-1)+0.5*(sign(a)-1);
    % 正数最大是2^(numint+numdec)-1，负数最大是-2^(numint+numdec)
end
% 转化为补码
if (a<0)
    % 需要写成补码的形式
    fixed_a=fixed_a+2^(numint+numdec);
    fixed_bin=dec2bin(fixed_a,numint+numdec);
    fixed_bin=strcat('1',fixed_bin);
else
    fixed_bin=dec2bin(fixed_a,numint+numdec);
    fixed_bin=strcat('0',fixed_bin);
end