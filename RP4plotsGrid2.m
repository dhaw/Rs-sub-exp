%{
[tv0,yv0,gv0,gr0]=RPprep44plots(alpha0inc,alpha0gen,alpha0vec);
[tv3,yv3,gv3,gr3]=RPprep44plots(alpha3inc,alpha3gen,alpha3vec);
[tv6,yv6,gv6,gr6]=RPprep44plots(alpha6inc,alpha6gen,alpha6vec);
tvecin=cell(3,1);
yvecin=cell(3,1);
genvecin=cell(3,1);
genratin=cell(3,1);
tvecin{1}=tv0; tvecin{2}=tv3; tvecin{3}=tv6;
yvecin{1}=yv0; yvecin{2}=yv3; yvecin{3}=yv6;
genvecin{1}=gv0; genvecin{2}=gv3; genvecin{3}=gv6;
genratin{1}=gr0; genratin{2}=gr3; genratin{3}=gr6;
%}
function f=RP4plotsGrid2(tvecin,yvecin,genvecin,genratin)%Row or column!
numnodes=584396;
%1=inc, 2=log inc, 3=gradloginc, 4=gen
%all data in columns: dim=1
int=10;%Plot every int'th as grey line
tend=400;%tvec(end);
%
%Change 1st plot title accordingly
alphas=[0,3,6];
%alphas=(1:.2:2.2);
la=length(alphas);
%
col1=.7*[1,1,1];
col2=.5*[0,0,1];
fs=12; lw=2;
%FigH=figure('DefaultAxesPosition',[0.1,0.1,0.8,0.8]);
%suptitle(strcat('\alpha=',num2str(alpha)))

tvec=tvecin; yvec=yvecin; genvec=genvecin; genrat=genratin;
y0=cell(la,1); y1=y0; y3=y0; t3=y0; g=y0;
%
%Moving average:
dim=1; otherdim=1+mod(dim,2);
movav=0; movavnum=3;%Done in RPprep44plots
for i=1:la
if movav==1
    tvec{i}=movmean(tvec{i},movavnum);
    yvec{i}=movmean(yvec{i},movavnum,dim);
end
%
%Gradient
yi=yvec{i}/numnodes;
ti=tvec{i};
yi=nanmean(yi,otherdim);
y0{i}=yi;
yi=log10(yi);
y1{i}=yi;
tdiffi=diff(ti);
y3i=diff(yi).*tdiffi;%,1,1).*repmat(tdiffi,size(yi,2));
t3{i}=ti(2:end);%tdiffi;
y3{i}=y3i;
g{i}=nanmean(genrat{i},otherdim);
end

%{
figure
plot(tvec,yvec(:,1:int:end),'-','linewidth',.5,'color',col1)
hold on
plot(tvec,y1,'-','linewidth',lw,'color',col2)
xlabel('Time (days)','FontSize',fs);
ylabel('Incidence','FontSize',fs);
title(strcat(num2str(alpha),'<R_0<',num2str(alpha+.2)))%,'fontsize',15) strcat('\alpha=',num2str(alpha)))%
set(gca,'FontSize',fs);
axis([tvec(1),tend,0,10000])
legend('\alpha=0','\alpha=3','\alpha=6')
grid on
grid minor
box on
hold off
%}
figure
semilogy(tvec{1},y0{1},'-','linewidth',lw)%,'color',col2)
hold on
for i=2:la
    semilogy(tvec{i},y0{i},'-','linewidth',lw)%,'color',col2)
end
hold off
xlabel('Time (days)','FontSize',fs);
ylabel('Incidence','FontSize',fs);
%yticks([1,10,100,1000,10000])
set(gca,'FontSize',fs);
axis([0,360,10^(-5),max(y0{1})])
legend('\alpha=0','\alpha=3','\alpha=6','location','NW')
grid on
grid minor
box on
%
figure
miny=10^5; maxy=0;
hold on
for i=1:la
    t3i=movmean(t3{i},movavnum);
    y3i=movmean(y3{i},movavnum,dim);
    plot(t3i,y3i(:,1:int:end),'-','linewidth',lw)%,'color',col2)
    maxy=max([abs(y3i);maxy]);
    %miny=max([y3i;-y3i;miny]);
end
%plot([1,180],[0,0],'k--','linewidth',1.5)
hold off
xlabel('Time (days)','FontSize',fs);
ylabel('Grad(log incidence)','FontSize',fs);
set(gca,'FontSize',fs);
axis([1,180,0,maxy])
legend('\alpha=0','\alpha=3','\alpha=6','location','NE')
grid on
grid minor
box on
%
figure
hold on
maxg=0;
for i=1:la
    geni=genvec{i};
    gi=g{i};
    plot(geni,gi,'-','linewidth',lw)%,'color',col2)
    maxg=max([gi;maxg]);
    %ming=max([g{i},ming]);
end
xlabel('Generation','FontSize',fs);
ylabel('Generation ratio','FontSize',fs);
set(gca,'FontSize',fs);
axis tight%([0,6,0,max(max(g))])
legend('\alpha=0','\alpha=3','\alpha=6','location','NE')
grid on
grid minor
box on
hold off
end