function f=RPhocIncGen(peakOverFinal,inc,HH2)%,genSize,genRatio) ,clus
TR=1;
alpha=(0:6);
la=length(alpha);

%
a=[alpha',[1,8,18,24,33,39,50]',[7,17,23,32,38,49,55]'];
%Could automate - rows of next alpha?
cols=[4,7];%10
lcols=length(cols);
H=HH2(:,6);

X=inc;%(2:end,5:end);

c=cell(1,la);
cmean=zeros(la,lcols);
for i=1:la
    from=a(i,2); from=10*(from-1)+1;
    to=a(i,3); to=10*to;
    ci=X(from:to,cols);
    c{i}=ci;
    cmean(i,:)=nanmean(ci,1);
end
%}
fs=12; lw=2;
figure
hold on
min1=10^5; min2=min1;
max1=0; max2=max1;
runs=size(peakOverFinal,2);
for i=1:la
    %
    ci=c{i};%cmean(i,:);%c{i};
    y=TR*ci(:,1)./ci(:,2);
    x=H(i)*ones(size(y));
    scatter(x,y,'filled')
    %min1=min([ci(:,1);min1]);
    %max1=max([ci(:,1);max1]);
    min2=min([y;min2]);
    max2=max([y;max2]);
    %}
    %ci=clus{i}; xpoint=ci(4,1);
    %scatter(xpoint*ones(1,runs),peakOverFinal(i,:),'filled')
    %scatter(xpoint,mean(peakOverFinal(i,:)),'filled')
end
xlabel('CC^2 (households)','FontSize',fs);
ylabel('Peak size/final size','FontSize',fs);
%ylabel('T_R\times Peak size/final size','FontSize',fs);
set(gca,'FontSize',fs);
%set(gca,'LooseInset',get(gca,'TightInset'));
%pbaspect([asp,1,1])
axis ([0,.5,0,.026])%([0,.4,0,max2])
legend('\alpha=0','\alpha=1','\alpha=2','\alpha=3','\alpha=4','\alpha=5','\alpha=6','location','NE')
grid on
grid minor
box on
hold off


%{
for i=1:2:7
    for i=1:la
    tvec=tvecin{i};
    yvec=yvecin{i};
    genvec=genvecin{i};
    genrat=genratin{i};
    alpha=alphas(i);
    ind=i;%(i-1)*4;
%
%Moving average:
if movav==1
    tvec=movmean(tvec,movavnum);
    yvec=movmean(yvec,movavnum,dim);
end
%
%Gradient
y3=yvec;
t3=tvec;
y=nanmean(y3,otherdim);
y=log10(y);
tdiff=diff(tvec);
y=diff(y,1,1).*repmat(tdiff,size(y,2));
t3(1)=[];
y3=nanmean(y,otherdim);

y1=nanmean(yvec,2);

g=nanmean(genrat,otherdim);

subplot(4,la,ind)
plot(tvec,yvec(:,1:int:end),'-','linewidth',.5,'color',col1)
hold on
plot(tvec,y1,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
if i==1
    ylabel('Incidence','FontSize',fs);
end
title(strcat(num2str(alpha),'<R_0<',num2str(alpha+.2)))%,'fontsize',15) strcat('\alpha=',num2str(alpha)))%
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])
axis([tvec(1),tend,0,10000])
grid on
grid minor
box on
hold off
%
subplot(4,la,ind+la)
semilogy(tvec,yvec(:,1:int:end),'-','linewidth',.5,'color',col1)
hold on
semilogy(tvec,y1,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
if i==1
    ylabel('Incidence','FontSize',fs);
end
%yticks([1,10,100,1000,10000])
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])
axis([tvec(1),tend,1,10000])
grid on
grid minor
box on
hold off
%
subplot(4,la,ind+2*la)
maxy=max(max(y3(1:100)));
miny=max([min(min(y3)),-maxy]);
t3=movmean(t3,movavnum);
y3=movmean(y3,movavnum,dim);
plot([t3(1),t3(end)],[0,0],'k--','linewidth',1.5)
hold on
plot(t3,y3(:,1:int:end),'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
if i==1
    ylabel('Grad(log incidence)','FontSize',fs);
end
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])

axis([tvec(1),tend,miny,maxy])
grid on
grid minor
box on
hold off
%
subplot(4,la,ind+3*la)
G=genrat(:,1:int:end);
plot(genvec,G,'-','linewidth',.5,'color',col1)
hold on
plot(genvec,g,'-','linewidth',lw,'color',col2)
xlabel('Generation','FontSize',fs);
if i==1
    ylabel('Generation ratio','FontSize',fs);
end
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])
axis([genvec(1),genvec(end),min(min(g)),max(max(g))])
%legend()
grid on
grid minor
box on
hold off
end
%}