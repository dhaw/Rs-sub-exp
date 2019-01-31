function f=RP4plotsGrid(tvecin,yvecin,genvecin,genratin)%Row or column!
%1=inc, 2=log inc, 3=gradloginc, 4=gen
%all data in columns: dim=1
int=10;%Plot every int'th as grey line
tend=400;%tvec(end);
%
%Change 1st plot title accordingly
%alphas=[0,3,6];
alphas=(1:.2:2.2);
la=length(alphas);
%
asp=1.5;%Aspect ratio - pbaspect 1st arg
dim=1; otherdim=1+mod(dim,2);
movav=0; movavnum=3;
%[a,b]=size(yvec);

col1=.7*[1,1,1];
col2=.5*[0,0,1];
fs=10; lw=2;
figure
%FigH=figure('DefaultAxesPosition',[0.1,0.1,0.8,0.8]);
%suptitle(strcat('\alpha=',num2str(alpha)))
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
end