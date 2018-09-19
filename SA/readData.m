% Read the data from ciyt.txt, filling D in column order
function [Title Dxy]=readData(datafile)
fid = fopen(datafile);
Title=[];
for i=1:2
    Title(i,:)=fscanf(fid,'%s',1);
end
Dxy = fscanf(fid, '%f %f ', [2 inf]);
fclose(fid);

% Transpose so that D matches
% the orientation of the file
Dxy=Dxy';
