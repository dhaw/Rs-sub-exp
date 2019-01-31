function f=RPmclusPlotsError(X,HH1,HH2)
%numClus=1;
clusmax=4;
clusmax2=2;
la=length(X);
m1=zeros(clusmax,la);
h1=[HH1(:,6),HH2(:,6)];
H1=zeros(clusmax2,la,2);
M1=zeros(clusmax,la,2);
for i=1:la
    Xi=X{i};
    Xi(:,5)=Xi(:,6)-Xi(:,5);
    Xi(:,7)=Xi(:,7)-Xi(:,6);
    M1(:,i,:)=Xi(:,[5,7]);
    m1(:,i)=Xi(:,6);
end
H1(1,:,:)=[HH1(:,6)-HH1(:,5),HH1(:,7)-HH1(:,6)];
H1(2,:,:)=[HH2(:,6)-HH2(:,5),HH2(:,7)-HH2(:,6)];
x=repmat((0:6),clusmax,1);
x2=repmat((0:6),clusmax2,1);

cmap=lines(clusmax);
colors=cell(clusmax,1);
for i=1:clusmax
    colors{i}=cmap(i,:);
end
lineProps.col=colors;
lineProps.style='-o';
%{
figure
%lineProps=[];
%lineProps.col=lines(clusmax);
mseb(x,m1,M1,lineProps,1);
hold off
set(gca,'fontsize',12)
axis ([0,6,0,.35])
xlabel('Distance power \alpha')
ylabel(strcat('CC^m (nodes)'))
legend('m=1','m=2','m=3','m=4','location','NW')
grid on
grid minor
box on
%}
%
figure
mseb(x2,h1',H1,lineProps,1);
set(gca,'fontsize',12)
axis ([0,6,0,.35])
xlabel('Distance power \alpha')
ylabel(strcat('CC^m (households)'))
legend('m=1','m=2','location','NW')
grid on
grid minor
box on
%}