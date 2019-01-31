function [f]=RPbarabasiStats(G,mmax)

%G(G>1)=1;%Already in "RPcombine"

n=length(G);
sampleNumber=40;
sampleN=randsample(1:n,sampleNumber);
X=zeros(mmax,sampleNumber);

%sampleNbrs=cell(1,sampleNumber);

for i=1:sampleNumber
    samplei=sampleN(i);
    vi=G(samplei,:);
    vfind=find(vi);
    lv=length(vfind);
    Gi=G;
    Gi(samplei,:)=Gi(samplei,:)-Gi(samplei,:);
    Gi(:,samplei)=Gi(:,samplei)-Gi(:,samplei);
    Gm=Gi;
    Gred=Gm(vfind,vfind);
    X(1,i)=sum(sum(triu(Gred)))/(lv*(lv-1)/2);
    for m=2:mmax
        Gnext=Gm*Gi; Gm=Gm+Gnext; Gm(Gm~=0)=1; Gm(speye(n)==1)=0;
        Gred=Gm(vfind,vfind);
        X(m,i)=sum(sum(triu(Gred)))/(lv*(lv-1)/2);
    end
end

X(isnan(X)==1)=0;
f=X;%[nanmean(X,2),nanvar(X,0,2),min(X,[],2),prctile(X,[5,25,50,75,95],2),max(X,[],2)];