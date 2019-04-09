function f=RPsuppCmTo1(X1,X6)
%alpha and clus the other way to mclusPlotsError
clusmax=6;
la=2;%size(X1,1);
m1=zeros(la,clusmax);
M1=zeros(la,clusmax,2);
%{
for i=1:la
    Xi=X{i};
    Xi(:,5)=Xi(:,6)-Xi(:,5);
    Xi(:,7)=Xi(:,7)-Xi(:,6);
    M1(:,i,:)=Xi(:,[5,7]);
    m1(:,i)=Xi(:,6);
end
%}
m1(1,:)=X1(:,6); m1(end,:)=X6(:,6);
M1(1,:,:)=[X1(:,6)-X1(:,5),X1(:,7)-X1(:,6)];
M1(end,:,:)=[X6(:,6)-X6(:,5),X6(:,7)-X6(:,6)];
x=repmat((1:clusmax),la,1);
cmap=parula(la);
colors=cell(la,1);
for i=1:la
    colors{i}=cmap(i,:);
end
lineProps.col=colors;
lineProps.style='-';
%
fs=12; lw=2;
figure
hold on
%
x1=1:clusmax;
%
mseb(x,m1,M1,lineProps,1);
h1=scatter(x1,m1(1,:),[],cmap(1,:),'o','filled','linewidth',lw);
h2=scatter(x1,m1(2,:),[],cmap(2,:),'o','filled','linewidth',lw);
%h3=scatter(x1,m1(3,:),[],cmap(3,:),'^','linewidth',lw);
%h4=scatter(x1,m1(4,:),[],cmap(4,:),'s','linewidth',lw);
hold off
set(gca,'fontsize',fs)
axis ([1,6,0,1])
xlabel('Order')
ylabel('Value')
legend([h1,h2],'\alpha=0','\alpha=6','location','NW')
grid on
grid minor
box on