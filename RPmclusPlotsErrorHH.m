function f=RPmclusPlotsErrorHH(HH1,HH2)
%numClus=1;
la=size(HH1,1);
clusmax2=2;
h1=[HH1(:,6),HH2(:,6)];
H1=zeros(clusmax2,la,2);
H1(1,:,:)=[HH1(:,6)-HH1(:,5),HH1(:,7)-HH1(:,6)];
H1(2,:,:)=[HH2(:,6)-HH2(:,5),HH2(:,7)-HH2(:,6)];
x2=repmat((0:6),clusmax2,1);

cmap=lines(clusmax2);
colors=cell(clusmax2,1);
for i=1:clusmax2
    colors{i}=cmap(i,:);
end
lineProps.col=colors;
lineProps.style='-o';
%
figure
mseb(x2,h1',H1,lineProps,1);
set(gca,'fontsize',12)
axis ([0,6,0,.4])
xlabel('Distance power \alpha')
ylabel(strcat('CC^m (households)'))
legend('m=1','m=2','location','NW')
grid on
grid minor
box on
%}