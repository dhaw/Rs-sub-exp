function f=RPmakeNets(arcs,h2,n)%Single columns from SR's .out files

wplaces=reshape(arcs,2,length(arcs)/2);
G=wplaces'+1;
Gsp=sparse(G(:,1),G(:,2),1,n,n);
Gsp=Gsp+Gsp';
Gsp=Gsp-diag(diag(Gsp));

Hsp=sparse(n,n);
%h1=nodes(:,1); h2=nodes(:,2);
h2sum=cumsum(h2);
lh2=length(h2);

from=1;
%Clonky!
for i=1:lh2-1
    to=h2sum(i);
    if h2(i)>1
        h2i=h2(i);
        Hsp(from:to,from:to)=ones(h2i)-eye(h2i);
    end
    from=to+1;
end
if from<n
    Hsp(from:n,from:n)=ones(n-from+1)-eye(n-from+1);
end
Gout=Gsp+Hsp;
Gout(Gout>1)=1;
f=Gout;