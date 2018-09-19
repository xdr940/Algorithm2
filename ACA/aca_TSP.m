%% 清空环境变量

clear all
close all
clc

tic
%% 导入城市数据文件（citydata.xls），得到城市坐标矩阵cityaxes
citydata=importdata('citydata.xls'); 
Cityaxes=citydata.data.Sheet1;
ncity=size(Cityaxes,1);

%% 根据城市坐标矩阵（Cityaxes）画城市地图
lb=floor(min(Cityaxes));                  % 计算最小X和Y坐标，向下取整
ub=ceil(max(Cityaxes));                   % 计算最大X和Y坐标，向上取整
Tick=[lb(1) ub(1) lb(2) ub(2)];

% 画随机路线的figure和axes
fh1=figure(1);
axh1=axes();
axis(Tick);
title('随机路线轨迹图')

% 画最优路线的figure和axes
fh2=figure(2);
axh2=axes();
axis(Tick)
title('最优解轨迹图')

% 各代最短距离
fh3=figure(3);
axh3=axes();
xlabel('迭代次数')
ylabel('距离')
title('各代最短距离')

%% 在axh1坐标中画出城市地图
drawMap(axh1,Cityaxes);

%% 画初始解（随机路线）轨迹
S1=randperm(ncity);                       % 随机产生一个初始解（随机路线）
drawPath(fh1,axh1,Cityaxes,S1);      %画初始解（随机路线）轨迹

%% 计算城市间相互距离（城市距离矩阵Citydist对角线上元素设为1e-4，以便于计算启发函数）
Citydist=zeros(ncity,ncity);
for i=1:ncity
    for j=1:ncity
        if (i~=j)
            Citydist(i,j)=sqrt((Cityaxes(i,1)-Cityaxes(j,1)).^2+(Cityaxes(i,2)-Cityaxes(j,2)).^2);
        else
            Citydist(i,j)=1e-4;
        end
    end
end

%%  在Command Window 输出初始随机路线
Plength=pathLength(Citydist,S1);                       % 计算初始路线总长度
disp('随机路线')
outputPath(S1);                                                 % 输出初始路线
disp(['总距离：',num2str(Plength)]);                   % 输出初始路线总长度

%% 初始化参数
nant= ncity;                                                        % 蚂蚁数量
alpha=1;                                                             % 信息素重要程度因子
beta = 5;                                                             % 启发函数重要程度因子
rho=0.1;                                                              % 信息素挥发因子
Q=1;                                                                   % 常系素
Eta=1./Citydist;                                                   % 启发函数
Tau=ones(ncity,ncity);                                        % 信息素矩阵
Route=zeros(nant,ncity);                                    % 路径记录表
iter=1;                                                                 % 迭代次数初值
iter_max=200;                                                     % 最大迭代次数
Route_best=zeros(iter_max,ncity);                     % 各代最佳路径
Len_bestRoute=zeros(iter_max,1);                     % 各代最佳路径的长度
Avg_Route=zeros(iter_max,1);                           % 各代路径的平均长度

%% 迭代寻找最佳路径
disp(['迭代完成次数：'])
while iter<=iter_max
    % 随机产生各个蚂蚁的起点城市
    Start=zeros(nant,1);
    Temp=randperm(ncity);
    Start(:,1)=Temp(1,1:nant);
    Route(:,1)=Start;
        
    % 构建解空间（城市编号）
    Index_city=1:ncity;
    % 逐个蚂蚁路径选择
    for i=1:nant
        % 逐个城市路径选择
        for j=2:ncity
            Tabu=Route(i,1:(j-1));                                            % 已访问城市集合（禁忌表）
            Logic_allow=~ismember(Index_city,Tabu);           % 待访问城市逻辑向量（1-待访问；0-已访问）
            Allow=Index_city(Logic_allow);                             % 待访问的城市集合
                                                             
            % 计算城市间转移概率（从禁忌表Tabu中最后一个元素到待访问表Allow中各元素的概率）
            P=zeros(1,length(Allow));                                               
            for k=1:length(Allow)
                P(k)=(Tau(Tabu(end),Allow(k)))^alpha*(Eta(Tabu(end),Allow(k)))^beta;
            end
            P=P/sum(P);
            
            % 轮盘赌法选择下一个访问城市
            Pc=cumsum(P);                                      % 累计值
            Index_target=find(Pc>=rand);               % 累计值不小于随机数的序列
            target=Allow(Index_target(1));               % 待转移到的城市编号
            Route(i,j)=target;
        end
    end
    
    % 计算各蚂蚁的路径距离（从起点到遍历各城市回到起点的距离）
    Len_path=zeros(nant,1);
    for i=1:nant
        Path=Route(i,:);
        for j=1:ncity-1
            Len_path(i)=Len_path(i)+Citydist(Path(j),Path(j+1));
        end
         Len_path(i)=Len_path(i)+Citydist(Path(ncity),Path(1));
    end
    
    % 计算最短路径距离及平均距离
    if iter==1
        [min_length,min_index]=min(Len_path);     % min_index - 蚂蚁编号；min_length - 编号为min_index的蚂蚁的路径长度
        Len_bestRoute(iter)=min_length;
     %   Avg_Route(iter)=mean(Len_Path);
        Route_best(iter,:)=Route(min_index,:);
    else
        [min_length,min_index]=min(Len_path);     % 当代的最短路径长度及蚂蚁编号
        Len_bestRoute(iter)=min(Len_bestRoute(iter-1),min_length);  % 当代（第iter代）的最短路径长度设为当代和上一代的最短路径长度的最小值
       % Avg_Route(iter)=mean(Len_Path)               
       
        if  Len_bestRoute(iter)==min_length
            Route_best(iter,:)=Route(min_index,:);
        else
            Route_best(iter,:)=Route_best((iter-1),:);
        end
    end
    
    % 更新信息素
    Delta_tau=zeros(ncity,ncity);
    
    % 逐个蚂蚁计算
    for i=1:nant
        for j=1:(ncity-1)
            Delta_tau(Route(i,j),Route(i,j+1))=Delta_tau(Route(i,j),Route(i,j+1))+Q/Len_path(i);
        end
        Delta_tau(Route(i,ncity),Route(i,1))=Delta_tau(Route(i,ncity),Route(i,1))+Q/Len_path(i);
    end
    
    Tau=(1-rho)*Tau+Delta_tau;              % 更新信息素
    
    % 输出迭代次数   
    fprintf(1,'%d  ',iter);
     if mod(iter,25)==0
        fprintf(1,'\n');
    end;
    
    % 迭代次数加1，清空路径记录表
    iter=iter+1;
    Route=zeros(nant,ncity);
end
fprintf(1,'\n');

%%  在Command Window 输出最优解路线
[length_shortest,index]=min(Len_bestRoute);
Route_shortest=Route_best(index,:);                           % 最优路线
Plength=pathLength(Citydist,Route_shortest);            % 计算最优路线总长度
disp('最优路线')
outputPath(S1);                                                            % 输出最优路线
disp(['总距离：',num2str(Plength)]);                             % 输出最优路线总长度

%% 画最优路径图
drawMap(axh2,Cityaxes);
drawPath(fh2,axh2,Cityaxes,Route_shortest);

%% 各代最短距离图
axes(axh3);
hold on
plot(1:iter_max,Len_bestRoute');
toc
