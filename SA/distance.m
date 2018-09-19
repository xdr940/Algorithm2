% distance(md).m
% 该函数计算矩阵MD所表示的点之间的距离
%       Syntax:
%               D=distance(MD)
%
% 输入：
%    MD  -坐标矩阵
%
% 输出：
%    D     -两点间距离矩阵，对角线元素为0

% Author: WKDuan
% Date: 17/7/2014

function D=distance(MD)
n = size(MD,1);                             % 点的数目
D=zeros(n,n);                                % 初始化点间距离矩阵
for i=1:n
    for j=i+1: n
        D(i,j)=((MD(i,1)-MD(j,1))^2+(MD(i,2)-MD(j,2))^2)^0.5;
        D(j,i)=D(i,j);
    end
end

% end function