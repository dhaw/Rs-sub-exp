%
function f=RPscatterBurnIn(X0,X3,X6,T0,T3,T6)
Rs0=T0(:,1); Rs3=T3(:,1); Rs6=T6(:,1);
numnodes=584396;
%%
RsFrom=0; RsTo=5;
%peakFrom=900/numnodes; peakTo=1100/numnodes;
peakFrom=0.003; peakTo=.0065;
ind=3;%Rs=2, peak=3, fs=4
var=4;
%%
%n0=X0(:,1); n03=X3(:,1); n06=X6(:,1);%Network
x0=X0(:,[1,3,4,7]); x3=X3(:,[1,3,4,7]); x6=X6(:,[1,3,4,7]);
x0(:,[3,4])=x0(:,[3,4])/numnodes; x3(:,[3,4])=x3(:,[3,4])/numnodes; x6(:,[3,4])=x6(:,[3,4])/numnodes;
%
%Choose variables:
from=peakFrom; to=peakTo;
%
x0(x0(:,ind)<from,:)=[]; x0(x0(:,ind)>to,:)=[];
x3(x3(:,ind)<from,:)=[]; x3(x3(:,ind)>to,:)=[];
x6(x6(:,ind)<from,:)=[]; x6(x6(:,ind)>to,:)=[];
%
vals0=x0(:,1); vals3=x3(:,1); vals6=x6(:,1);
y0=x0(:,var); y3=x3(:,var); y6=x6(:,var);

y0=accumarray(vals0,y0); y3=accumarray(vals3,y3); y6=accumarray(vals6,y6);
v0=accumarray(vals0,1); v3=accumarray(vals3,1); v6=accumarray(vals6,1);
y0=y0./v0; y3=y3./v3; y6=y6./v6;

%Filter by Rstar:
%
from=RsFrom; to=RsTo;
y0(Rs0<from)=NaN; y0(Rs0>to)=NaN;
y3(Rs3<from)=NaN; y3(Rs3>to)=NaN;
y6(Rs6<from)=NaN; y6(Rs6>to)=NaN;
%
f=[nanmean(y0),nanmean(y3),nanmean(y6)];
%}
%%
%{
%R*/peak size in range, all peak size/final size
function f=RPscatterBurnIn(X0,X3,X6,T0,T3,T6)
Rs0=T0(:,1); Rs3=T3(:,1); Rs6=T6(:,1);
numnodes=584396;
ind=2;%Col of X using to eliminate burn-outs
thresh=0;%Threshold for above
%X's are output_matrix
vals0=X0(:,1); vals3=X3(:,1); vals6=X6(:,1);
X0=X0(:,3:7); X3=X3(:,3:7); X6=X6(:,3:7);
%f0=find(X0(:,4)<100); f3=find(X3(:,4)<100); f6=find(X6(:,4)<100);
vals0(X0(:,ind)<thresh)=[]; vals3(X3(:,ind)<thresh)=[]; vals6(X6(:,ind)<thresh)=[];
X0(X0(:,ind)<thresh,:)=[]; X3(X3(:,ind)<thresh,:)=[]; X6(X6(:,ind)<thresh,:)=[];

R00=X0(:,1); R03=X3(:,1); R06=X6(:,1);
fs0=X0(:,5)/numnodes; fs3=X3(:,5)/numnodes; fs6=X6(:,5)/numnodes;

R00=accumarray(vals0,R00); R03=accumarray(vals3,R03); R06=accumarray(vals6,R06);
fs0=accumarray(vals0,fs0); fs3=accumarray(vals3,fs3); fs6=accumarray(vals6,fs6);
v0=accumarray(vals0,1); v3=accumarray(vals3,1); v6=accumarray(vals6,1);
R00=R00./v0; R03=R03./v3; R06=R06./v6;%repmat(v6,5);
fs0=fs0./v0; fs3=fs3./v3; fs6=fs6./v6;

figure
fs=12; lw=2;
hold on
scatter(Rs0,fs0,'filled')
scatter(Rs3,fs3,'filled')
scatter(Rs6,fs6,'filled')
%v=[min(Rs0),max([R00;R03;R06])];
%plot(v,v,'k-','linewidth',2)
hold off
xlabel('R^*','FontSize',fs);
%xlabel('R_0','FontSize',fs);
ylabel('Final size','FontSize',fs);
set(gca,'FontSize',fs);
axis tight
legend('\alpha=0','\alpha=3','\alpha=6','location','NW')
grid on
grid minor
box on
%}