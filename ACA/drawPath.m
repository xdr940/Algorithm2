% drawPath.m - (Draw Path)
% 在城市坐标图上画路径轨迹
%       Syntax:
%               drawPath(fh,axh,Dxy,P)
%
% 输入：
%   fh      -figure句柄
%   axh   -axes句柄
%   Dxy   -城市坐标矩阵
%   P       -搜索路径向量
%
% 输出：
%   路径轨迹图

% Author: WKDuan
% Date: 17/7/2014

function drawPath(fh,axh,Dxy,P)

%在axh坐标中画出城市坐标，并标注序号
figure(fh)
axes(axh)
hold on

% 生成路径回路及按路径排序的城市坐标矩阵
P=[P P(1)];                  % 将路径中的第一个城市加到路径向量最后
R=Dxy(P,:);                 % 根据路径向量P重新生成城市坐标矩阵R，该矩阵元素是按路径顺序排列

% 根据路径P在axh中标注起始城市
plot(axh,R(1,1),R(1,2),'rv','MarkerSize',10);           % 标注起始城市

% 画路径轨迹
n=size(R,1);            % 路径中城市数目
for i=2:n
        [arrowX arrowY]=dsxy2figxy(gca,R(i-1:i,1),R(i-1:i,2));
        annotation(fh,'textarrow',arrowX,arrowY,'LineWidth',1.2,'HeadWidth',6,'color',[0 0 1]);
end
xlabel('横坐标')
ylabel('纵坐标')
legend('城市','起始城市',4)
% end of function



