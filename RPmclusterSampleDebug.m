function [f,g,h]=RPmclusterSample(G,mmax,sampleNumber,v)%Or input v
%G must be simple: undirected with no self loops
%v=randsample(n,sampleNumber);%v is indices
lv=length(v);
clusterVec1=zeros(lv,mmax);

imvw1=v';%node
imvw2=ones(lv,1);%info order
Cv={};%Cell array of data for each node
lengthC=lv;

%Standard clustering:
for i=1:lv
    %Find neighbours of node i:
    vx=v(i);
    v1=mNbr(G,vx,1,vx);%Indices of neighbours
    %Update stored data:
    Cv{i}=v1;
    %
    Gred=G(v1,v1);%Adj mat of neighbourhood
    lv1=length(v1);%Number of neighbours
    C1=sum(sum(triu(Gred)))/lv1/(lv1-1)*2;%How many links exist/how many could exist
    clusterVec1(i,1)=C1;
end
%m-clustering, m>1:
if mmax>1
for m=2:mmax
    for i=1:lv
        %m-neighbours of v(i):
        vi=v(i);
        vx=Cv{i};%m-1 OR m (if already xcalculated in loop) nbrs of v(i)
        imvw2i=imvw2(i);
        if imvw2i<m%i.e.==m-1
            vm=mNbr(G,vx,m-imvw2i,vi);%Neighbours of i
            %vm=vm(vm~=vi) here?
            imvw2(i)=m;
            Cv{i}=vm;
        else
            vm=vx;
        end
        vmx=vm;%(vm~=vi);%Exclude node i
        lvm=length(vmx);
        %m-clustering:
        %
        links1=0;
        %m-neighbours of each m-neighbour:
        for j=1:lvm%parfor
            vmj=vmx(j);%vmOrder(j);
            %if vmj~=vi
            %Faster to order or to find all links?
            if ismember(vmj,imvw1)%If have already calculated some nbhds
                index=find(imvw1==vmj);%How many
                thisFar=imvw2(index);
                vmjSoFar=Cv{index};
                if thisFar<m
                    mNj=mNbr(G,vmjSoFar,m-thisFar,vmj);
                    imvw2(index)=m;
                    Cv{index}=mNj;
                else
                    mNj=Cv{index}; %mNjOnly=Cw{index};
                end
            else
                mNj=mNbr(G,vmj,m,vmj);
                lengthC=lengthC+1;
                index=lengthC;
                imvw1(index)=vmj;
                imvw2(index)=m;
                Cv{index}=mNj;
            end
            %Other method: find subgraph
            %mNj=mNj(~vi); mNjOnly=mNjOnly(~vi);
            mNjx=mNj;%(mNj~=vmj);%m-neighbours of node j, not including j
            links1=links1+length(intersect(vmx,mNjx));
            %end
        end
        clusterVec1(i,m)=links1/lvm/(lvm-1);
        %}
        %Other method: how many m-nbrs of i are 1-nbrs of each other:
        %{
        imvw2(i)=m;
        Cv{i}=vm;
        Gred=G(vmx,vmx);%Adj mat of neighbourhood
        clusterVec1(i,m)=sum(sum(triu(Gred)))/lvm/(lvm-1)*2;
        %}
    end
end
end
%****Save output****
f=clusterVec1;
g=Cv;
h=[imvw1,imvw2];
end

function f=mNbr(G,vx1,mMore,vi)
    vx=vx1;
    G1=G(vx,:);
    sumG1=sum(G1,1); 
    v1=find(sumG1>0);%Indices of neighbours
    v1=v1(v1~=vi);
    vx=v1;%In case want wx etc.
    if mMore>1
        k=2;
        while k<=mMore
            Gm=G(vx,:);
            sumGm=sum(Gm,1); vm=find(sumGm>0); 
            vm=union(vx,vm);%up-to-m-neighbours of i
            vm=vm(vm~=vi);
            vx=vm;
            k=k+1;
        end
    end
    f=vx;
end