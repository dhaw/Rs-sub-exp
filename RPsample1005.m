function [f,g]=RPsample1005(G,mmax,sampleNumber)%Or input v
%Followed up in RPmclusterSample - most intuitive measure only
%
%G must be simple: undirected with no self loops
n=length(G);
v=randsample(n,sampleNumber);%v is indices
lv=length(v);
clusterVec1=zeros(lv,mmax);
clusterVec2=clusterVec1;

imvw1=v';%node
imvw2=ones(lv,1);%info order
Cv={};%Cell array of data for each node
Cw={};
lengthC=lv;

%Standard clustering:
for i=1:lv
    Ci=zeros(1,mmax);
    CiBar=Ci;
    %Find neighbours of node i:
    vx=v(i);
    [v1,w1]=mNbr(G,vx,1);%Indices of neighbours
    %Update stored data:
    Cv{i}=v1; Cw{i}=v1;
    %
    Gred=G(v1,v1);%Adj mat of neighbourhood
    lv1=length(v1);%Number of neighbours
    C1=sum(sum(triu(Gred)))/lv1/(lv1+1)*2;%How many links exist/how many could exist
    clusterVec1(i,1)=C1;
    clusterVec2(i,1)=C1;
end
%m-clustering, m>1:
if mmax>1
for m=2:mmax
    for i=1:lv
        vi=v(i);
        vx=Cv{i};%m-1 nbrs of v(i)
        if imvw2(i)<m%i.e.==m-1
            [vm,wm]=mNbr(G,vx,1);%Neighbours of i
        else
            vm=vx; wm=Cw{i};
        end
        vmx=vm(vm~=vi); wmx=wm(wm~=vi);
        lvm=length(vmx); lwm=length(wmx);
        links1=0; links2=0;
        for j=1:lvm%parfor
            vmj=vmx(j);%vmOrder(j);
            if vmj~=vi
            %Faster to order or to find all links?
            if ismember(vmj,imvw1)
                index=find(imvw1==vmj);
                thisFar=imvw2(index);
                vmjSoFar=Cv{index};
                if thisFar<m
                    [mNj,mNjOnly]=mNbr(G,vmjSoFar,m-thisFar);
                    imvw2(index)=m;
                    Cv{index}=mNj;
                    Cw{index}=mNjOnly;
                else
                    mNj=Cv{index}; %mNjOnly=Cw{index};
                end
            else
                [mNj,mNjOnly]=mNbr(G,vmj,m);
                lengthC=lengthC+1;
                index=lengthC;
                imvw1(lengthC)=vmj;
                imvw2(lengthC)=m;
                Cv{index}=mNj;
                Cw{index}=mNjOnly;
            end
            %Other method: find subgraph
            %mNj=mNj(~vi); mNjOnly=mNjOnly(~vi);
            mNjx=mNj(mNj~=vmj);
            links1=links1+length(intersect(vmx,mNjx));
            %
            inw=0;
            if ismember(vmj,wmx)==1
                inw=1;
                links2=links2+length(intersect(wmx,mNjx));
            end
            %
            end
        end
        clusterVec1(i,m)=links1/lvm/(lvm-1);
        %
        if lwm==0 || inw==0
            clusterVec2(i,m)=0;
        else
            clusterVec2(i,m)=links2/lwm/(lwm-1);
        end
        %
    end
end
f=clusterVec1;
g=clusterVec2;
end
end

function [f,g]=mNbr(G,vx1,m)
    vx=vx1;
    G1=G(vx,:);
    sumG1=sum(G1,1); 
    v1=find(sumG1>0);%Indices of neighbours
    vx=v1;
    wx=setdiff(v1,vx1);
    if m>1
        i=2;
        while i<m
            Gm=G(vx,:);
            sumGm=sum(Gm,1); vm=find(sumGm>0); 
            wm=setdiff(vm,vx);
            vm=union(vx,vm);%up-to-m-neighbours of i
            %getRid=ismember(vm,vx); wm=setdiff(vm,getRid);%vm(~getRid);%m-neighbours of i
            vx=vm;
            wx=wm;
            i=i+1;
        end
    end
    f=vx;
    g=wx;
end