%Networks (for HOC - epidemics below):
%
function f=RPdiffAlphaProcess
a=(5:1:6);%Alpha values
ai=0;
w=[60,100,140,180,220];
lw=length(w);
n=10000;%
la=length(a);
reps=1;%Num of nets for each alpha;
Gcell=cell(la,reps);%XX
fpath='..\..\..\Downloads\SRebola\id_spatial_sim-master\scenarios\ebola\network\netDHh4w30pp2333r2p2_alpha';
for i=1:la
    ai=a(i);%XX
    for j=1:reps
    %
        fname1=strcat(fpath,num2str(ai),'a_arcs.out');
        fname2=strcat(fpath,num2str(ai),'a_nodes.out');
        arcs=load(fullfile(fname1)); %Households
        arcs=arcs(:,1);%1st column
        nodes=load(fullfile(fname2));
        nodes=nodes(:,5);%5th column
        %DH1: net_h3w32pp25_alpha
        %DH2: netDH4_100_p08_2_alpha
        %DH3: netDH4_120_p05_2_alpha
        %DH4: netDH4_20_p35_2_alpha (h=3)
        Gcell{i,j}=RPmakeNets(arcs,nodes,n);
    end
    %
    %{
    fname1a=strcat(fpath,num2str(ai),'w',num2str(wi),'a_arcs.out');
    fname2a=strcat(fpath,num2str(ai),'w',num2str(wi),'a_nodes.out');
    fname1b=strcat(fpath,num2str(ai),'w',num2str(wi),'b_arcs.out');
    fname2b=strcat(fpath,num2str(ai),'w',num2str(wi),'b_nodes.out');
    fname1c=strcat(fpath,num2str(ai),'w',num2str(wi),'c_arcs.out');
    fname2c=strcat(fpath,num2str(ai),'w',num2str(wi),'c_nodes.out');
    arcs=load(fullfile(fname1a)); arcs=arcs(:,1); nodes=load(fullfile(fname2a)); nodes=nodes(:,5);
    Gcell{i,1}=RPmakeNets(arcs,nodes,n);
    arcs=load(fullfile(fname1b)); arcs=arcs(:,1); nodes=load(fullfile(fname2b)); nodes=nodes(:,5);
    Gcell{i,2}=RPmakeNets(arcs,nodes,n);
    arcs=load(fullfile(fname1c)); arcs=arcs(:,1); nodes=load(fullfile(fname2c)); nodes=nodes(:,5);
    Gcell{i,3}=RPmakeNets(arcs,nodes,n);
    %}
end
f=Gcell;
%save('allNetsDH4.mat','Gcell','-v7.3')%h_w_pw_R0
save('DH1nets.mat','Gcell','-v7.3')%h_w_pw_R0
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
%
lepi=300;%(Max) length of incidence vector
epiz=zeros(lepi,lruns);
[epi{:}]=deal(epiz);
fpath='..\..\..\Downloads\SRebola\id_spatial_sim-master\scenarios\ebola\output\epiDHh4w30pp2333r2p2_alpha';
for i=1:la
    ai=a(i);
    %events=importdata(strcat('DH_h4w120pp05_alpha',num2str(ai),'_pset_0_Events.out'));%,' ',1,0);
    events=importdata(fullfile(strcat(fpath,num2str(ai),'_pset_0_Events.out')));
    %DH1: DH4_30_p3_2_alpha
    %DH2: DH_h4w100pp08_alpha
    %DH_h4w120pp05_alpha
    %
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
        %For full epidemics:
        epi{i}(1:length(x),j)=x;
    end
    zevAll=event; zevAll(zevAll>0)=1; dayAll=day+1;
    x=accumarray(dayAll,zevAll);
    epi{i}=x/n/lruns;
    clear events zevAll dayAll
end
f=P; g=Z; h=epi;
save('allEpis.mat','P','Z','epi')
%}