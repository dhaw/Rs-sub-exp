function f=RPdistHist(x0)%,x3,x6)
%x0=x0(x0>0);
maxy=max([x0]);%;x3;x6]);
figure
fs=12; lw=2;
hist(x0,1:5:5570)%(0:.05:1))
xlabel('Distance');
ylabel('Frequency');
set(gca,'FontSize',fs);
axis ([0,1000,0,200])
grid on
grid minor
box on
hold off