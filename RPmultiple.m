function [f,g]=RPmultiple(G)
n=6;
eps=.01;
bins=(0:eps:1);
hists=zeros(n,length(bins));
stats=zeros(n,9);
parfor i=1:n
    [f1,g1]=RPcluster(G,i);
    fs=15; col1=[0,0,0];
    figure
    [counts1,centers1]=hist(f1,bins);
    bar(centers1,counts1,'facecolor',col1,'edgecolor',col1,'barwidth',1);
    maxY=max(counts1);
    axis([-eps/2,1+eps/2,0,maxY])%clusmax+eps/2 max(counts1)
    xlabel('Measure','FontSize',fs)
    ylabel('Frequency','FontSize',fs)
    %title('\alpha=6, n=')
    hists(i,:)=counts1;
    stats(i,:)=g1;
end
f=hists;
g=stats;