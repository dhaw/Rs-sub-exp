function [f,g]=RPprepPlots(data)
alpha=(0:6);
la=length(alpha);
%
a=[alpha',[1,8,18,24,33,39,50]',[7,17,23,32,38,49,55]'];
%Could automate - rows of next alpha?
cols=[2,3];%10 %net/run/peak/final
lcols=length(cols)';
c=cell(1,la);
cmean=zeros(la,lcols);
%
iterations=10;%1 for means in input, 10 otherwise
for i=1:la
    from=a(i,2); from=iterations*(from-1)+1;
    to=a(i,3); to=iterations*to;
    ci=data(from:to,cols);
    c{i}=ci;
    cmean(i,:)=nanmean(ci,1);
end
f=c;
g=cmean;