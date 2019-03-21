function f=RPhocIncGen2(v1,v2,v3,h21,h22,h23)%,h11,h12,h13)%,genSize,genRatio) ,clus
TR=1;
alpha=(0:6);
la=length(alpha);
col=1;
H=[h21(:,col),h22(:,col),h23(:,col)];
%V=[v1(:,col),v2(:,col),v3(:,col)];
%
fs=12; lw=2;
figure
hold on
min1=10^5; min2=min1;
max1=0; max2=max1;
%{
H1=[h11(:,col),h12(:,col),h13(:,col)];
reg1=reshape(H,3*la,1);
reg2=[v1;v2;v3];
reg2=reg2(:,1)./reg2(:,2);
f=corrcoef(reg1,reg2);
coeffs=polyfit(reg1,reg2,1);
xline=[0,.5];
yline1=coeffs(1)*xline+coeffs(2);
%}
reg1=reshape(H,3*la,1);
reg2=[v1;v2;v3];
reg2=reg2(:,1)./reg2(:,2);
f=corrcoef(reg1,reg2);
%idx=any(isnan(reg2));
coeffs=polyfit(reg1(isnan(reg1)==0),reg2(isnan(reg1)==0),1);
xline=[0,.5];
yline=coeffs(1)*xline+coeffs(2);
plot(xline,yline,'-','linewidth',2,'color',[.5,.5,.5]);

plotcell=cell(la,1);
for i=1:la
    ci1=v1(i,:); ci2=v2(i,:); ci3=v3(i,:);%cmean(i,:); %c{i};
    y=TR*[ci1(:,1)./ci1(:,2),ci2(:,1)./ci2(:,2),ci3(:,1)./ci3(:,2)]';%la by 3
    x=H(i,:);
    plotcell{i}=scatter(x,y,'filled');
    %{
    ci=v2(i,:);
    y2=TR*ci(:,1)./ci(:,2);
    x=H(i,:)*ones(size(y2));
    scatter(x,y2,'filled')
    ci=v3(i,:);
    y3=TR*ci(:,1)./ci(:,2);
    x=H(i)*ones(size(y3));
    scatter(x,y3,'filled')
    min2=min(min([y;min2]));
    max2=max(max([y;max2]));
    %}
end
xlabel('CC^2 (households)','FontSize',fs);
ylabel('Peak size/final size','FontSize',fs);
set(gca,'FontSize',fs);
axis ([0,.4,0,.02])%([0,.4,0,max2])
legend([plotcell{:}],'\alpha=0','\alpha=1','\alpha=2','\alpha=3','\alpha=4','\alpha=5','\alpha=6','location','NE')
grid on
grid minor
box on
hold off