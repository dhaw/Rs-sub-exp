function [f,g]=RPmclusIncGen(yCell,cCell)%ci are mean clustering order
%yCell{i} - row for each alpha, cols for peak and final
%cCell{i} - cell array - output from HPC (so cCell is a cell array of cell
%arrays)
startfrom=2;%First order to fit - 2 for full nets, 1 for HHs
TR=1;
alpha=(0:6);
la=length(alpha);
ly=length(yCell);
cCell1=cCell{1};
clusmax=size(cCell1{1},1);%size(cCell{1},1);
n=584396;

PZ=zeros(la,ly);
Cm=zeros(la,ly,clusmax);
col=1;%mean clus
corrs=zeros(clusmax,1);
coeffs=zeros(clusmax,2);
for i=1:ly%For each different network structure
    yi=yCell{i};
    ci=cCell{i};
    lci=length(ci);
    ciMat=zeros(la,clusmax);
    for j=1:lci%lci=la!! %Better option - extract means/medians from "out"s, then input to this function
        ciMatj=ci{j};
       ciMat(j,:)=ciMatj(:,col);
    end
    PZ(:,i)=yi(:,1);%/n;%./yi(:,2);
    Cm(:,i,:)=ciMat;
end

fs=12; lw=2;
min1=10^5; min2=min1;
max1=0; max2=max1;
reg2=reshape(PZ,la*ly,1);
cmap=parula(la);
%colormap(cmap);
figure
hold on
for j=1:clusmax
    H=Cm(:,:,j);
    reg1=reshape(H,la*ly,1);
    corrsj=corrcoef(reg1(isnan(reg1)==0),reg2(isnan(reg1)==0));
    corrsj=corrsj(2);
    corrs(j)=corrsj;
    %idx=find(isnan(reg1));
    coeffsj=polyfit(reg1(isnan(reg1)==0),reg2(isnan(reg1)==0),1);
    coeffs(j,:)=coeffsj;
    %
    if j>=startfrom
        xline=[0,.5];
        yline=coeffsj(1)*xline+coeffsj(2);
        plot(xline,yline,'-','linewidth',2,'color',[.5,.5,.5]);
    end
    %
    plotcell=cell(la,1);
    for i=1:la
        y=TR*PZ(i,:);%la by 3
        x=H(i,:);
        if j==1
            scatter(x,y,[],cmap(i,:),'o','linewidth',lw);
            %scatter(x,y,'x','linewidth',lw);
        elseif j==2
            scatter(x,y,[],cmap(i,:),'x','linewidth',lw);
            %scatter(x,y,'s','filled');
        elseif j==3
            scatter(x,y,[],cmap(i,:),'^','linewidth',lw);
        else
            scatter(x,y,[],cmap(i,:),'s','linewidth',lw);
        end
            plotcell{i}=scatter(x,-y,[],cmap(i,:),'filled','o','linewidth',lw);
    end
end
xlabel('CC^m (nodes)','FontSize',fs);
ylabel('Peak size')%/final size','FontSize',fs);
set(gca,'FontSize',fs);
axis ([0,.5,0,.03])%([.15,.5,.015,.03])%([0,.4,0,.02])%([0,.4,0,max2])
legend([plotcell{:}],'\alpha=0','\alpha=1','\alpha=2','\alpha=3','\alpha=4','\alpha=5','\alpha=6','location','SW')
grid on
grid minor
box on
hold off

f=corrs;
g=coeffs;