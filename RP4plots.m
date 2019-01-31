function f=RP4plots(tvec,yvec,column)
%1=inc, 2=log inc, 3=gradloginc, 4=gen
%all data in columns: dim=1
dim=1; otherdim=1+mod(dim,2);
movav=1; movavnum=3;
%[a,b]=size(yvec);
%
%Moving average:
if movav==1
    tvec=movmean(tvec,movavnum);
    yvec=movmean(yvec,movavnum,dim);
end
%
%Gradient
if column==3
    y=nanmean(yvec,otherdim);
    y=log10(y);
    tdiff=diff(tvec);
    y=diff(y).*tdiff;
    tvec(1)=[];
else
    y=nanmean(yvec,otherdim);
end

col1=.5*[1,1,1];
col2=.5*[0,0,1];
fs=12; lw=2;
if column==1
figure
plot(tvec,yvec,'-','linewidth',.5,'color',col1)
hold on
plot(tvec,y,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
ylabel('Incidence','FontSize',fs);
set(gca,'FontSize',fs);
axis tight
%legend()
grid on
grid minor
box on
hold off
%
elseif column==2
figure
semilogy(tvec,yvec,'-','linewidth',.5,'color',col1)
hold on
semilogy(tvec,y,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
ylabel('Incidence','FontSize',fs);
set(gca,'FontSize',fs);
axis tight
%legend()
grid on
grid minor
box on
hold off
%
elseif column==3
figure
plot(tvec,y,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
ylabel('Log incidence','FontSize',fs);
set(gca,'FontSize',fs);
axis tight
%legend()
grid on
grid minor
box on
%
elseif column==4
figure
plot(tvec,yvec,'-','linewidth',.5,'color',col1)
hold on
plot(tvec,y,'-','linewidth',lw,'color',col2)
xlabel('Generation','FontSize',fs);
ylabel('Generation ratio','FontSize',fs);
set(gca,'FontSize',fs);
axis tight
%legend()
grid on
grid minor
box on
hold off
end