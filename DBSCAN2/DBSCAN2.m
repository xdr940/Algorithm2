%% DBSCAN TEST 2
clear;clc;close all;
%% 生成数据点存到文件里
%内半径，带宽，点数,应该分成4类，环形点，三类样本生成，一共num个

[x1] = GenCyclicData(1,0.2,40);
[x2] = GenCyclicData(2,0.2,100);
[x3] = GenCyclicData(3,0.2,160);
[x4]=  GenCyclicData(4,0.2,200);

X = [x1;x2;x3;x4];

%DBSCAN.exe传入参数
num = 500;%这个点数得和上面的总和一样！
eps = '.75 ';
MinPits='7 ';
OutputPath = 'points.txt';
%写到文件
fid = fopen(OutputPath,'w');
for i=1:num
    fprintf(fid,'%f %f \n',X(i,1),X(i,2));
end

%% 调用程序分类处理
cppProgram = 'DBSCAN.exe';
input = [cppProgram,blanks(2),OutputPath,blanks(2),MinPits,eps,blanks(2),num2str(num)]
 if(dos(input)~=1)
    display('调用失败\n');
 end
 
 
%% 处理（绘图）C++生成的文件


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
str = ['DBSCAN分类情况 ',' MinPits = ',MinPits,' eps = ',eps,'points num = ',num2str(num),' C= ',num2str(cnt-1)];
title(str);
hold off;