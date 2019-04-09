function f=RPsensAnalWPprocess
a=[0,6];%(0:1:6);%Alpha values
w=[30,60,120,150];%(30:30:150);
n=10000;
la=length(a);
lw=length(w);
reps=1;%Num of nets for each alpha;
Gcell=cell(la,lw);%Add 3rd dimension for reps
fpath='..\..\..\Downloads\SRebola\id_spatial_sim-master\scenarios\ebola\network\';
for i=1:la
    ai=a(i);
    for j=1:lw
        wj=w(j);
        fname1=strcat(fpath,'SAwp_alpha',num2str(ai),'w',num2str(wj),'_arcs.out');
        fname2=strcat(fpath,'SAwp_alpha',num2str(ai),'w',num2str(wj),'_nodes.out');
        arcs=load(fullfile(fname1)); %Households
        arcs=arcs(:,1);%1st column
        nodes=load(fullfile(fname2));
        nodes=nodes(:,5);%5th column
        Gcell{i,j}=RPmakeNets(arcs,nodes,n);
    end
end
f=Gcell;
save('SAwpAlpha06w30to150.mat','Gcell','-v7.3')%h_w_pw_R0