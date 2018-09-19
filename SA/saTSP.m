% 模拟退火法解决TSP问题
% 输入：
%  city.txt     -城市坐标文本文件
%
%  输出：
%   随机路线图、最优路线图
%   随机中路径及其长度、最优路径及其长度

clear
clc
close all

%% 初始数据设置
tic
Tinit=1500;               % 初始温度
Tend=1e-3;              % 终止温度
L=200;                      % 各温度下的迭代次数（链长）
q=0.9;                      % 降温速率

%读取城市数据文件（city.txt），得到城市坐标数据Dxy
%[Title,Dxy]=readData('city.txt'); 

% City=importdata('city.txt');
% Dxy=City.data;

citydata=importdata('citydata.xls');
Dxy=citydata.data.Sheet1;

% 设置画路径图的axh1和axh2的坐标轴显示
lb=floor(min(Dxy));                  % 计算最小X和Y坐标，向下取整
ub=ceil(max(Dxy));                   % 计算最大X和Y坐标，向上取整
Tick=[lb(1) ub(1) lb(2) ub(2)];  
% 画随机路线的figure和axes
fh1=figure(1);
axh1=axes();
axis(Tick);                                       % 设置坐标轴的最小和最大值
title('随机路线轨迹图')

% 画最优路线的figure和axes
fh2=figure(2);
axh2=axes();
axis(Tick);                                       % 设置坐标轴的最小和最大值
title('最优解轨迹图')

% 画优化过程的figure和axes
fh3=figure(3);
axh3=axes();

 % 根据城市坐标数据Dxy产生城市两两间距离数据D
N=size(Dxy,1);                                %  计算机城市数目
D=distance(Dxy);                            % 产生城市两两间距离数据D

%% 在axh1坐标中画出城市地图
drawMap(axh1,Dxy);

%% 画初始解（随机路线）轨迹
S1=randperm(N);                     % 随机产生一个初始解（随机路线）
drawPath(fh1,axh1,Dxy,S1);      %画初始解（随机路线）轨迹

%%  在Command Window 输出初始路线
Plength=pathLength(D,S1);                               % 计算初始路线总长度
disp('随机路线')
outputPath(S1);                                                 % 输出初始路线
disp(['总距离：',num2str(Plength)]);                   % 输出初始路线总长度

%%
%计算迭代次Times
Times=ceil(double(solve(['1000*(0.9)^x=',num2str(1e-3)])));
count=0;
Obj=zeros(Times,1);                         % 目标值矩阵初始化
track=zeros(Times,N);                      % 每代的最优路线矩阵初始化

% 迭代
while Tinit>Tend
    count=count+1;
    temp=zeros(L,N+1);
    for k=1:L
        S2=newPath(S1);                         %产生新解
        [S1,R]=metropolis(S1,S2,D,Tinit); 
        temp(k,:)=[S1,R];                         % 记录下一路线及路线长度
    end

    % 记录每次迭代过程的最优路线
    [d0,index]=min(temp(:,end));          % 当前温度下的最优路线
    if count==1 || d0<Obj(count-1)
        Obj(count)=d0;                           % 如果当前温度下最优路程小于上一路程，则记录当前路程
    else
        Obj(count)=Obj(count-1);          % 如果当前温度下最优路程大于上一路程，则记录上一路程
    end
    track(count,:)=temp(index,1:end-1);     % 记录当前温度的最优路线
    Tinit=q*Tinit;                                        %降温
    fprintf(1,'%s','.')                                    % 迭代
end
fprintf(1,'共迭代%d次\n',count)                 % 输出当前迭代次数
%% 优化过程迭代图
figure(fh3);
axes(axh3);
plot(1:count,Obj)
xlabel('迭代次数')
ylabel('距离')
title('优化过程')

%% 画最优解路线图
drawMap(axh2,Dxy);
drawPath(fh2,axh2,Dxy,track(end,:));

%% 输出最优解路线和总距离
disp('最优解')
S=track(end,:);
p=outputPath(S);
disp(['总距离:',num2str(pathLength(D,S))]);
disp('----------------------------------------------------------------')
toc

% end of program
