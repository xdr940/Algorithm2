% pathLength.m
% 计算路径总长度
%       Syntax:
%               len=pathLength(D,P)
%
% 输入：
%   D    -两点距离矩阵
%   P     -路径向量
% 输出：
%   len  -路径总长度

% Author: WKDuan
% Date: 17/7/2014

function len=pathLength(D,P)
R=[P,P(1)];                         % 将路径中的起点加到最后，形成回路
len=0.0;
n=length(R);
for i=2:n
    len=len+D(R(i-1),R(i));
end

% end of function

