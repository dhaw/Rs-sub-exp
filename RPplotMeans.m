function f=RPplotMeans(X)%,Y)%(f0stats,f3stats,f4stats,f5stats,f6stats)
numClus=4;
la=length(X);
plotMeans=zeros(numClus,la);
plotErr=plotMeans;
plotErrNeg=plotMeans;
plotErrPos=plotMeans;
for i=1:la
    mat=X{i};
    %mat2=Y{i};
    plotMeans(:,i)=mat(:,6);%nanmean(mat,2);%mat(:,1);%1 for mean
    plotErr(:,i)=(mat(:,2));
    plotErrNeg(:,i)=mat(:,6)-mat(:,5);
    plotErrPos(:,i)=mat(:,7)-mat(:,6);
    %Comment out for X only:
    %{
    plotMeans(1:2,i)=mat2(:,6);
    plotErr(1:2,i)=(mat2(:,2));
    plotErrNeg(1:2,i)=mat2(:,6)-mat2(:,5);
    plotErrPos(1:2,i)=mat2(:,7)-mat2(:,6);
    %}
end
%plotMeans=[f0stats(:,1),f3stats(:,1),f4stats(:,1),f5stats(:,1),f6stats(:,1)];
%plotMeans=[f0stats(:,5),f3stats(:,5),f4stats(:,5),f5stats(:,5),f6stats(:,5)];%Median
%plotMeans=[f0stats(:,1),f3stats(:,1),f6stats(:,1)];
mmax=size(plotMeans,1);

X=zeros(2,numClus);
for i=1:numClus
    cc1=corrcoef(plotMeans(i,:),0:6);
    X(1,i)=cc1(2);
    cc2=corrcoef(plotMeans(i,2:end),1:6);
    X(2,i)=cc2(2);
end
f=X;
alpha=0;
figure;
%h=plot(1:numClus,plotMeans,'-o','linewidth',2);
%h1=errorbar(1:numClus,plotMeans(:,1),plotErr(:,1),'linewidth',1);%,plotErrNeg(:,1),plotErrPos(:,1),'linewidth',1);
h1=errorbar(1:numClus,plotMeans(:,1),plotErrNeg(:,1),plotErrPos(:,1),'linewidth',1);
hold on
%{
h2=errorbar(1:numClus,plotMeans(:,2),plotErr(:,2),'linewidth',1);%,plotErrNeg(:,2),plotErrPos(:,2),'linewidth',1);
h3=errorbar(1:numClus,plotMeans(:,3),plotErr(:,3),'linewidth',1);%,plotErrNeg(:,3),plotErrPos(:,3),'linewidth',1);
h4=errorbar(1:numClus,plotMeans(:,4),plotErr(:,4),'linewidth',1);%,plotErrNeg(:,4),plotErrPos(:,4),'linewidth',1);
h5=errorbar(1:numClus,plotMeans(:,5),plotErr(:,5),'linewidth',1);%,plotErrNeg(:,5),plotErrPos(:,5),'linewidth',1);
h6=errorbar(1:numClus,plotMeans(:,6),plotErr(:,6),'linewidth',1);%,plotErrNeg(:,6),plotErrPos(:,6),'linewidth',1);
h7=errorbar(1:numClus,plotMeans(:,7),plotErr(:,7),'linewidth',1);%,plotErrNeg(:,7),plotErrPos(:,7),'linewidth',1);
%}
%
h2=errorbar(1:numClus,plotMeans(:,2),plotErrNeg(:,2),plotErrPos(:,2),'linewidth',1);
h3=errorbar(1:numClus,plotMeans(:,3),plotErrNeg(:,3),plotErrPos(:,3),'linewidth',1);
h4=errorbar(1:numClus,plotMeans(:,4),plotErrNeg(:,4),plotErrPos(:,4),'linewidth',1);
h5=errorbar(1:numClus,plotMeans(:,5),plotErrNeg(:,5),plotErrPos(:,5),'linewidth',1);
h6=errorbar(1:numClus,plotMeans(:,6),plotErrNeg(:,6),plotErrPos(:,6),'linewidth',1);
h7=errorbar(1:numClus,plotMeans(:,7),plotErrNeg(:,7),plotErrPos(:,7),'linewidth',1);

hold off

legend('\alpha=0','\alpha=1','\alpha=2','\alpha=3','\alpha=4','\alpha=5','\alpha=6','location','SW');
%legend('\alpha=0','\alpha=3','\alpha=4','\alpha=5','\alpha=6','location','NE');
set(gca,'fontsize',12)
set(gca,'xtick',1:mmax)
%set(h, {'MarkerFaceColor'}, get(h,'Color')); 
axis ([.8,numClus+.2,0,.3])%.2
xlabel('Order')
ylabel('Clustering')
grid on
grid minor
%{
yyaxis right
plot(1:numClus,X(1,:),'--','linewidth',1.5)
axis([.8,numClus+.2,-1,1])
ylabel('Correlation with \alpha')%,'rot',-90)
%hold on
%plot(1:numClus,X(2,:),':','linewidth',1.5)
%hold off
%}