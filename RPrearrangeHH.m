function f=RPrearrangeHH(HH1,HH2)
numclus=2;%Number of inputs
la=size(HH1,1);
%numstats=9;
hAll=zeros(numclus,9,la);
hAll(1,:,:)=HH1';
hAll(2,:,:)=HH2';
h0=hAll(:,:,1);
h1=hAll(:,:,2);
h2=hAll(:,:,3);
h3=hAll(:,:,4);
h4=hAll(:,:,5);
h5=hAll(:,:,6);
h6=hAll(:,:,7);
f={h0,h1,h2,h3,h4,h5,h6};
