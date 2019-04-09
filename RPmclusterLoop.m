%function [cm0,cm1,cm2,cm3,cm4,cm5,cm6]=RPmclusterLoop(G0,G1,G2,G3,G4,G5,G6)
function f=RPmclusterLoop(Gcell)
[l1,l2]=size(Gcell);
cellOut=cell(l1,l2);
sam=200;
m=4;
Csub=cell(l2,1);
for i=1:l1
    Gsub=Gcell(i,:);
    parfor j=1:l2
        G=Gsub{j};
        c=RPmclusterSampleSpeed(G,m,sam);
        Csub{j}=c;
    end
    cellOut(i,:)=Csub;
end
%save('clusDH4_30_p3_2.mat','cm0','cm1','cm2','cm3','cm4','cm5','cm6');%h_w_pw_"R0"
SAwpClus=cellOut;
f=SAwpClus;
save('SAwClus.mat','SAwpClus');