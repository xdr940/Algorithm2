clear
clc
fitnessfcn=@ga_demo3f;              % 适应度函数句柄
nvars=2;                                       % 个体所含的变量数目
options=gaoptimset('PopulationSize',100,'EliteCount',10,'CrossoverFraction',0.75,'Generations',500,...
    'StallGenLimit',500,'TolFun',1e-100,'PlotFcns',{@gaplotbestf,@gaplotbestindiv});
[x_best,fval]=ga(fitnessfcn,nvars,[],[],[],[],[],[],[],options);
