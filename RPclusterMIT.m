function f=RPclusterMIT(G,N)
n=length(G);
A=G;
X=zeros(N,1);
for order=1:N
    if order==1
        %Standard clustering:
        [C1,C2,C]=clust_coeff(A);
        X(order)=C2;
    else
        %N-clustering:
        nextA=A*G;
        nextA(speye(n)==1)=0;
        A=nextA;
        [C1,C2,C]=clust_coeff(A);
        X(order)=C2;
    end
end
f=X;