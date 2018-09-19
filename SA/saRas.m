clear
clc
ObjectiveFunction=@Rastrigin;                 % 目标函数句柄
X0=[-2.5 2.5];                                              % 初始值
lb=[-5 -5];                                                  % 变量下界
ub=[5 5];                                                    % 变量上界
options=saoptimset('MaxIter',500,'StallIterLim',500,'TolFun',1e-10,'AnnealingFcn',@annealingfast,...
    'InitialTemperature',100,'TemperatureFcn',@temperatureexp,'ReannealInterval',500,...
    'PlotFcns',{@saplotbestx,@saplotbestf,@saplotx,@saplotf});
[x,fval]=simulannealbnd(ObjectiveFunction,X0,lb,ub,options);