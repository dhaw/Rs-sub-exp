%Networks (for HOC - epidemics below):
%
function f=RPdiffAlphaProcess
a=(0:1:6);%Alpha values
n=20000;
la=length(a);
a=(0:1:6);%Alpha values
n=20000;
la=length(a);
reps=1;%Num of nets for each alpha;
Gcell=cell(la,reps);
for i=1:la
    ai=a(i);
    for j=1:reps
        fname1=strcat('net_h3w32pp25_alpha',num2str(ai),'_arcs.out');
        fname2=strcat('net_h3w32pp25_alpha',num2str(ai),'_nodes.out');
        arcs=load(fname1); %Households
        arcs=arcs(:,1);%1st column
        nodes=load(fname2);
        nodes=nodes(:,5);%5th column
        Gcell{i,j}=RPmakeNets(arcs,nodes,n);
    end
end
f=Gcell;
%save('allNetsDH4_30_p3_2.mat','Gcell','-v7.3')%h_w_pw_R0
%clearvars
%}
%%
%Epidemics:
%{
function [f,g,h]=RPdiffAlphaProcess
a=(0:1:6);%Alpha values
n=10000; lruns=10;
la=length(a);
P=zeros(la,lruns); Z=P;%5=max poss runs;
epi=cell(la,1);
for i=1:la
    ai=a(i);
    events=importdata(strcat('DH4_30_p3_2_alpha',num2str(ai),'_pset_0_Events.out'));%,' ',1,0);
    run=events.data(:,1);%events(2:end,1);
    day=events.data(:,2);%events(2:end,2);
    event=events.data(:,3);%events(3:10:end);%(2:end,3);
    %index=events(2:end,4);
    runs=unique(run);
    lruns=length(runs);
    for j=1:lruns
        runj=runs(j);
        d=day(run==runj)+1;
        ev=event(run==runj);
        lev=length(ev); zev=zeros(lev,1);
        zev(ev==0)=1;
        %zev=ev; zev(zev>0)=1;
        x=accumarray(d,zev);
        [peak,~]=max(x);
        z=sum(zev);
        P(i,j)=peak/n; Z(i,j)=z/n;
        %epi{i}=x;
    end
    zevAll=event; zevAll(zevAll>0)=1; dayAll=day+1;
    x=accumarray(dayAll,zevAll);
    epi{i}=x/n/lruns;
    clear events zevAll dayAll
end
f=P; g=Z; h=epi;
save('allEpis.mat','P','Z','epi')
%}