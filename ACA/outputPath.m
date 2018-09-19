% outputPath.m
% 格式化输出路径P
%
%       语法
%                R=outputPth(P)
%
% 输入：
%   P       -路径向量
%
% 输出：
%   R       -格式化路径向量
%
% Author: WKDuan
% Date: 17/7/2014

function R=outputPath(P)
P=[P,P(1)];                         % 将路径起点加到最后，构成回路
n=length(P);
R=num2str(P(1));
for i=2:n
    R=[R,'->',num2str(P(i))];
end
disp(R)

% end of funtion

