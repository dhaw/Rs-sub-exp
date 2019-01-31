function f=RPscatterplots(T0,T3,T6)
numnodes=584396;
Rs0=T0(1:end,1);
R00=T0(1:end,2);
peak0=T0(1:end,3);
ext0=T0(1:end,4);
z0=T0(1:end,5)/numnodes;
pval0=T0(:,6)/numnodes;

Rs3=T3(1:end,1);
R03=T3(1:end,2);
peak3=T3(1:end,3);
ext3=T3(1:end,4);
z3=T3(1:end,5)/numnodes;
pval3=T3(:,6)/numnodes;

Rs6=T6(1:end,1);
R06=T6(1:end,2);
peak6=T6(1:end,3);
ext6=T6(1:end,4);
z6=T6(1:end,5)/numnodes;
pval6=T6(:,6)/numnodes;

figure
fs=12; lw=2;
hold on
scatter(Rs0,pval0,'filled')
scatter(Rs3,pval3,'filled')
scatter(Rs6,pval6,'filled')
%v=[min(Rs0),max([R00;R03;R06])];
%plot(v,v,'k-','linewidth',2)
xlabel('R^*','FontSize',fs);
%xlabel('R_0','FontSize',fs);
ylabel('Peak size','FontSize',fs);
set(gca,'FontSize',fs);
axis tight

legend('\alpha=0','\alpha=3','\alpha=6','location','NW')
grid on
grid minor
box on
hold off