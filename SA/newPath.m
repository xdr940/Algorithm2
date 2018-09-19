% newPath.m
% 生成新解（路径）函数
%       语法：
%               function S2=newPath(S1)
%
% 输入：
% S1    -当前解（路径）
%
% 输出：
% S2    - 新解（路径）
%
% Author:
% Date:

function S2=newPath(S1)
n=length(S1);
S2=S1;
a=round(rand(1,2)*(n-1)+1);            % 产生两个随机位置用来交换
w=S2(a(1));
S2(a(1))=S2(a(2));
S2(a(2))=w;                                      % 得到一个新路线

% end of function