clc
clear all
A = FixedPointToDecimal('011.101',3,3);
A
B = FixedPointToDecimal('101.111',3,3);% filpover 010.000 LSB 010.001
B
D = FixedPointToDecimal('111.001',3,3);%% 000.110 LSB 000.111
D
c = FixedPointToDecimal('011.100',3,3);
c