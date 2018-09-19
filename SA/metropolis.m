% metropolis.m
% 按metropolis准则产生新解
%
%       语法
%                [S,R]=metropolis(S1,S2,D,T)
% 输入
%  S1      -当前解
%  S2      -新解
%  D       -两城市间距离矩阵
%  T        -当前温度
%
%  输出
%  S        -下一个当前解
%  R        -下一个当前解的路线距离

function [S,R]=metropolis(S1,S2,D,T)
R1=pathLength(D,S1);                    % 计算路线长度
n=length(S1);                                  % 城市数目

R2=pathLength(D,S2);
dc=R2-R1;
if dc<0
    S=S2;
    R=R2;
elseif exp(-dc/T)>=rand
    S=S2;
    R=R2;
else
    S=S1;
    R=R1;
end