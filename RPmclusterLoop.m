function [cm0,cm1,cm2,cm3,cm4,cm5,cm6]=RPmclusterLoop(G0,G1,G2,G3,G4,G5,G6)
m=4;
sam=200;
cm0=RPmclusterSampleSpeed(G0,m,sam);
cm1=RPmclusterSampleSpeed(G1,m,sam);
cm2=RPmclusterSampleSpeed(G2,m,sam);
cm3=RPmclusterSampleSpeed(G3,m,sam);
cm4=RPmclusterSampleSpeed(G4,m,sam);
cm5=RPmclusterSampleSpeed(G5,m,sam);
cm6=RPmclusterSampleSpeed(G6,m,sam);
%save('clusDH4_30_p3_2.mat','cm0','cm1','cm2','cm3','cm4','cm5','cm6');%h_w_pw_"R0"
save('clusDH1.mat','cm0','cm1','cm2','cm3','cm4','cm5','cm6');