% drawMap.m         -(Draw Map)
% 根据城市坐标画城市地图
%       Syntax:
%               drawPath(axh,Dxy)
%
% 输入：
%   axh   -坐标轴句柄
%   Dxy   -城市坐标矩阵
%
% 输出：
%   城市坐标图

% Author: WKDuan
% Date: 17/7/2014

function drawMap(axh,Dxy)

%在axh坐标中画出城市坐标，并标注序号
axes(axh);
hold on
plot(axh,Dxy(:,1),Dxy(:,2),'ro');
for i=1:size(Dxy,1)
    text(Dxy(i,1)+0.2,Dxy(i,2)+0.2,num2str(i));
end
hold off
% end of function



