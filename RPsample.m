function [f,g]=RPsample(G,mmax,sampleNumber)%Or input v
n=length(G);
v=randsample(n,sampleNumber);%v is indices
lv=length(v);
clusterVec=zeros(lv,mmax);
clusterVecBar=clusterVec;

parfor i=1:lv
    Ci=zeros(1,lv);
    CiBar=Ci;
    %Find neighbours of node i:
    vx=v(i);
    [v1,w1]=mNbr(G,vx,1);%Indices of neighbours
    %
    Gred=G(v1,v1);%Adj mat of neighbourhood
    lv1=length(v1);%Number of neighbours
    C1=sum(sum(triu(Gred)))/lv1/(lv1+1)*2;%How many links exist/how many could exist
    Ci(1)=C1;
    CiBar(1)=C1;
    vx=v1;%v/G up-to-m-neighbours of i
    wx=w1;%w/H m-neighbours of i
    if mmax>1
    for m=2:mmax
        %vx=vx;%Remove i?
        [vm,wm]=mNbr(G,vx,1);%Neighbours of i
        lvm=length(vm); lwm=length(wm);
        [Vm,Wm]=mNbr(G,vm,m);%Neighbours of these neighbours
        Gv=G(vm,Vm);
        Gw=G(wm,Vm);%m-neighbours WITHIN m of each other (hence Vm)
        %For immediate neighbours, add output of mNbrs
        vSum=sum(sum(triu(Gv)));
        wSum=sum(sum(triu(Gw)));
        Ci(m)=vSum/lvm/(lvm+1)*2;
        CiBar(m)=wSum/lwm/(lwm+1)*2;
    end
    end
    clusterVec(i,:)=Ci;
    clusterVecBar(i,:)=CiBar;
end

f=clusterVec;
g=clusterVecBar;
end

function [f,g]=mNbr(G,vx,m)
    G1=G(vx,:);
    sumG1=sum(G1,1); 
    v1=find(sumG1);%Indices of neighbours
    vx=v1;
    wx=v1;
    if m>1
        for i=2:m
            Gm=G(vx,:);
            Hm=G(wx,:);
            sumGm=sum(Gm,1); vm=find(sumGm); vm=union(vx,vm);%up-to-m-neighbours of i
            sumHm=sum(Hm,1); wm=find(sumHm); getRid=ismember(wm,vx); wm=wm(~getRid);%m-neighbours of i
            vm=find(sumGm);
            vx=intersect(vx,vm);
            wx=wm;
        end
    end
    f=vx;
    g=wx;
end