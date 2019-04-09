function f=RPdistHist(x0)%,x3,x6)
%x0=x0(x0>0);
maxy=max([x0]);%;x3;x6]);
figure
fs=12; lw=2;
hist(x0,0:.5:61);%5570)%(0:.05:1))
xlabel('Distance (km)');
ylabel('Frequency');
set(gca,'FontSize',fs);
axis ([0,50,0,80000])
grid on
grid minor
box on
hold off