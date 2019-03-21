function f=RPHHnet(H,W)
%Assumes V1i<V2i - otherwise order each row
%G=W(:,[1,4]);
%w=W(:,[1,3]);
%
%H=sortrows(H,1);

h=H(:,[1,4]);

h1=h(:,1);%
maxind=max(max(h));
v=(1:maxind)';
X=zeros(size(W,1),4);%%HH/rep/long/lat
i=1;%HH index
endnumber=length(h1);
%
while endnumber>0
    hfirst=h1(1);
    upto=find(h1>hfirst,1)-1;
    householdi=unique([hfirst;h(1:upto,2)]);
    v(householdi)=hfirst;
    X(i,:)=[i,hfirst,H(1,[2,3])];
    %
    maxhouseholdi=max(householdi);
    getrid=find(h1>maxhouseholdi,1)-1;
    i=i+1;%Next household
    h(1:getrid,:)=[]; h1(1:getrid)=[];
    endnumber=length(h1);
end
%}
%W-replace individual by HH number - via rep
G=v(G);
G=sparse(G(:,1),G(:,2),1);
G(G>1)=0;
%
f=RPclustersample(G,1,min(200,i-1));
    
