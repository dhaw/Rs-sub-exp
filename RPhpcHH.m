function f=RPhpcHH%(mats)
alpha=[0,1,2,3,4,5,6];% [0,6];%
%%vNames={'mon0.mat','mon3.mat','mon4.mat','mon5.mat','mon6.mat'};
numNet=length(alpha);
out=cell(numNet,1);
%
pload('H')
H0=H0-diag(diag(H0));
H1=H1-diag(diag(H1));
H2=H2-diag(diag(H2));
H3=H3-diag(diag(H3));
H4=H4-diag(diag(H4));
H5=H5-diag(diag(H5));
H6=H6-diag(diag(H6));
mats={H0,H1,H2,H3,H4,H5,H6};
%}
parfor i=1:numNet
    G=mats{i};
    %{
    alphai=alpha(i);
    varName=strcat('mon',num2str(alphai),'.mat');
    varName=vNames{i};
    pload(varName,'G');%Each network saved as 'G' in .mat file indexable by name
    G=RPcombine(matsi);
    G=G+G';
    %}
    X=RPmclusterSampleSpeed(G,2,200);
    out{i}=X;
    %out=X;
end
fname='MonroviaC1to2sam200HHa';%strcat('MonroviaC1');%,num2str(alpha));
f=out;
save(fname,'out')%('Monrovia0123456','out')
end