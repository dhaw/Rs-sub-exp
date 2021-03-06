function [t1,y1,t2,y2]=RPprep44plots(M1,M2,v,rmin,rmax)
%Turn incidence csv into matrix with 1 column per simulation - M1
%Divide by number of runs per network - always 10?
%M1=M1/10;%Or compute mean in pivot table!
%M2=M2/10;%Mean done alreagy
%
these1=find(v>rmin);
these2=find(v<=rmax);
these=intersect(these1,these2);
if isempty(these)==0
%}

[a1,b1]=size(M1);
elevens=(11:11:b1);
N1=M1(:,elevens);
M1(:,elevens)=[];
N2=M2(:,elevens);
M2(:,elevens)=[];

M1=movmean(M1,3,1);
%M2=movmean(M2,3,1);

tend1=400;
tend2=20;
t1=(10:tend1)';
t2=(2:tend2)';
M1=M1(10:tend1,:);
M2=M2(2:tend2,:);
y1=M1(:,these);
y2=M2(:,these);
%
else
    t1=0;
    t2=0;
    y1=0;
    y2=0;
end
%}