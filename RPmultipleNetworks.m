function f=RPmultipleNetworks
%To date, requires files to be inported into MATLAB as 2-column matrix of
%adj pairs
alpha=(0:6);%Alpha values
mmax=6;
sampleNumber=100;
la=length(alpha);
for i=1:la
    iindex=num2str(i);
    fileName=strcat('gos',iindex');%Load monAlpha.csv
    G=RPcombine(fileName);
    f=RPmclusterSample(G,mmax,sampleNumber);
    fileName=strcat(fileName,'mcluster',num2str(mmax));
    save(fileName,'f');
end