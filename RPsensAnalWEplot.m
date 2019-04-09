function f=RPsensAnalWEplot(cCell)
%Takes output from RPmclusterLoop
%a=1:3;
C=cCell;%(2,:);%Pick alpha
%
w=(60:40:220);%[30,60,120,150];
%la=size(cCell,1);%Alpha
lw=length(w);%=size(cCell,2)
clusmax=size(C{1},1);
m1=zeros(clusmax,lw);%lines/yvalues (for each w)
M1=zeros(clusmax,lw,2);%lines/yvalues/2
for i=1:lw
    Xi=C{i};
    Xi(:,5)=Xi(:,6)-Xi(:,5);
    Xi(:,7)=Xi(:,7)-Xi(:,6);
    M1(:,i,:)=Xi(:,[5,7]);
    m1(:,i)=Xi(:,6);
end
%}
%{
m1(1,:)=X1(:,6); m1(end,:)=X6(:,6);
M1(1,:,:)=[X1(:,6)-X1(:,5),X1(:,7)-X1(:,6)];
M1(end,:,:)=[X6(:,6)-X6(:,5),X6(:,7)-X6(:,6)];
%}
x=repmat(w,clusmax,1);
cmap=lines(lw);
colors=cell(lw,1);
for i=1:lw
    colors{i}=cmap(i,:);
end
lineProps.col=colors;
lineProps.style='-';
%
fs=12; lw=2;
figure
hold on
%
x1=w;%1:clusmax;
%
mseb(x,m1,M1,lineProps,1);
h1=scatter(x1,m1(1,:),[],cmap(1,:),'o','filled','linewidth',lw);
h2=scatter(x1,m1(2,:),[],cmap(2,:),'o','filled','linewidth',lw);
h3=scatter(x1,m1(3,:),[],cmap(3,:),'o','filled','linewidth',lw);
h4=scatter(x1,m1(4,:),[],cmap(4,:),'o','filled','linewidth',lw);
hold off
set(gca,'fontsize',fs)
axis ([60,220,0,1])
xlabel('Workplace size')
ylabel('CC^m (nodes)')
legend([h1,h2,h3,h4],'m=1','m=2','m=3','m=4','location','NE')
grid on
grid minor
box on