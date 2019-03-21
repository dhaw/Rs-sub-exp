function f=RPplotSRepi(c)
%Input - cell array of epidemics - 1 for each alpha (singlke or average)
%Or change "runs" to correct number
runs=1;%Runs per network - =1 if averaged!
%
lc=length(c);
fs=12; lw=2;
cmap=parula(length(c));
figure
colormap(cmap);
c1=c{1};
lc1=length(c1);
semilogy(1:lc1,c1,'linewidth',lw,'color',cmap(1,:))
%plot(1:lc1,c1,'linewidth',lw,'color',cmap(1,:))
hold on
if lc>1
for i=runs+1:runs:lc
    ci=c{i};
    lci=length(ci);
    semilogy(1:lci,ci,'linewidth',lw,'color',cmap(i,:))
    %plot(1:lci,ci,'linewidth',lw,'color',cmap(i,:))
end
end
xlabel('Time (days)')
ylabel('Incidence')
axis ([050,150,.01,.1])
set(gca,'fontsize',fs)
legend('\alpha=0','\alpha=1','\alpha=2','\alpha=3','\alpha=4','\alpha=5','\alpha=6','location','SW');
grid on
grid minor
box on
hold off