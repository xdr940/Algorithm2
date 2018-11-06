%% 2d样本点生成
% X个数为100个，为2d随机变量，两个特征各自服从正态分布，MU=[5 5]，不指定协方差矩阵。从0~10
clear all;clc;
close all;
MU = [5 5];
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
%%  C++处理
eps = '0.3 ';
MinPits='4 ';

cppProgram = 'DBSCAN.exe';
input = [cppProgram,blanks(2),OutputPath,blanks(2),MinPits,eps];
 if(dos(input)~=1)
    display('调用失败\n');
 end

%% 处理（绘图）C++生成的文件

num=100;
Y=load('out1.txt');

hold on;

[m,n]=size(Y);
k1=1;k2=0;
cnt=1;% 变换点样式
hold on;

xlim=[0,10];
ylim=[0,10];

s=['r*';'b*';'g*';'k*';'y*';'m*';'c*'];%点样式切换

for i=1:m
    if i==num
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(mod(cnt,6)+1,:));
        break;
    end
    if Y(i,1)~=Y(i+1,1)
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(mod(cnt,6)+1,:));
        cnt=cnt+1;
    end
end
str = ['DBSCAN分类情况 ',' MinPits = ',MinPits,' eps = ',eps,' C= ',num2str(cnt-1)];
title(str);
hold off;


 
