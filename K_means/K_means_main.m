%% 2d样本点生成
% X个数为100个，为2d随机变量，两个特征各自服从正态分布，MU=[5 5]，不指定协方差矩阵。从0~10
clear all;clc;
close all;
MU = [5 3];
SIGMA = [1 0 ; 
         0 1];
num = 100;
OutputPath = 'points.txt';

X = mvnrnd(MU,SIGMA,num);%生成随机矢量
% 保存文件路径
fid = fopen(OutputPath,'w');
for i=1:num
    fprintf(fid,'%f %f \n',X(i,1),X(i,2));
end
%% C++处理
cppProgram = 'K_means.exe';
input = [cppProgram,blanks(2),OutputPath];
 if(dos(input)~=1)
    display('调用失败\n');
 end
%% 处理（绘图）C++生成的文件
clear;clc;
close all;
num=100;

Y=load('out.txt');
Je=load('out2.txt');
hold on;

[m,n]=size(Y);
k1=1;k2=0;
cnt=1;% 变换点样式
hold on;

xlim=[0,10];
ylim=[0,10];
title('分类情况');
s=['r*';'b*';'g*';'m*';'y*'];%点样式切换
for i=1:m
    if i==100
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(cnt,:));
        break;
    end
    if Y(i,1)~=Y(i+1,1)
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(cnt,:));
        cnt=cnt+1;
    end
end
hold off;
figure();
plot(Je,'r');
title('Je');
 
