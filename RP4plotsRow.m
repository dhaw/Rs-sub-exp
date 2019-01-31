function f=RP4plotsRow(tvec,yvec,genvec,genrat,alpha)%Row or column!
%1=inc, 2=log inc, 3=gradloginc, 4=gen
%all data in columns: dim=1
asp=1.5;%Aspect ratio - pbaspect 1st arg
dim=1; otherdim=1+mod(dim,2);
movav=0; movavnum=3;
%[a,b]=size(yvec);
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

col1=.7*[1,1,1];
col2=.5*[0,0,1];
fs=10; lw=2;
figure
%FigH=figure('DefaultAxesPosition',[0.1,0.1,0.8,0.8]);
suptitle(strcat('\alpha=',num2str(alpha)))
subplot(4,1,1)
plot(tvec,yvec,'-','linewidth',.5,'color',col1)
hold on
plot(tvec,y1,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
ylabel('Incidence','FontSize',fs);
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])
axis tight
grid on
grid minor
box on
hold off
%
subplot(4,1,2)
semilogy(tvec,yvec,'-','linewidth',.5,'color',col1)
hold on
semilogy(tvec,y1,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
ylabel('Incidence','FontSize',fs);
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])
axis tight
grid on
grid minor
box on
hold off
%
subplot(4,1,3)
plot(t3,y3,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
ylabel('Grad(log incidence)','FontSize',fs);
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])
axis tight
grid on
grid minor
box on
%
subplot(4,1,4)
plot(genvec,genrat,'-','linewidth',.5,'color',col1)
hold on
plot(genvec,g,'-','linewidth',lw,'color',col2)
xlabel('Generation','FontSize',fs);
ylabel('Generation ratio','FontSize',fs);
set(gca,'FontSize',fs);
set(gca,'LooseInset',get(gca,'TightInset'));
pbaspect([asp,1,1])
axis tight
%legend()
grid on
grid minor
box on
hold off
end