function fixed_bin=my_fix_flr_bin(a,numint,numdec)
% aΪ�����㻯�ľ�������,Ϊʵ��
% numintλ������numdecλС��
% ѡȡ����λ��Ϊ1+numint+numdec������1Ϊ����λ��ռ��
fixed_a=floor(a*2^numdec);  % ģ��������ֱ�ӽ�λ�Ľ��
% �޷�
if ((fixed_a>=2^(numint+numdec))||(fixed_a<-2^(numint+numdec)))
    fixed_a=sign(a)*(2^(numint+numdec)-1)+0.5*(sign(a)-1);
    % ���������2^(numint+numdec)-1�����������-2^(numint+numdec)
end
% ת��Ϊ����
if (a<0)
    % ��Ҫд�ɲ������ʽ
    fixed_a=fixed_a+2^(numint+numdec);
    fixed_bin=dec2bin(fixed_a,numint+numdec);
    fixed_bin=strcat('1',fixed_bin);
else
    fixed_bin=dec2bin(fixed_a,numint+numdec);
    fixed_bin=strcat('0',fixed_bin);
end