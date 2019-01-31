function [f,g]=RPcluster(G,N)
n=length(G);
%N=3;
eps=.01;
clusmax=1;

bins=(0:eps:1);
measureA=cell(N,1); measureB=measureA;
%[C1,C2,C]=clust_coeff(G);
measureA{1}=G; measureB{1}=G;
A=G; B=G;
X=zeros(n,1);
if N==1
%Standard clustering:
for i=1:n
    vi=A(i,:);
    vfind=find(vi);
    lv=length(vfind);
    Wi=B(vfind,vfind);
    X(i)=sum(sum(triu(Wi)))/(lv*(lv+1)/2);
end
%clusmax=max(C2);

else
%N-clustering:
for i=2:N
    nextA=A*G;
    nextA(speye(n)==1)=0;
    nextA(B==1)=0;
    nextA(nextA>1)=1;
    nextB=B+nextA; nextB(nextB>1)=1;
    measureA{i}=nextA; measureB{i}=nextB;
    A=nextA; B=nextB;
end

%X=zeros(n,1);
Ax=measureA{N}; Ax(speye(n)==1)=0;
Bx=measureB{N}; Bx(speye(n)==1)=0;
B1=measureB{1};
BNm1=measureB{N-1};
for i=1:n
    vi=Bx(i,:);%Ax if exactly N steps from i, Bx if up to N steps
    vfind=find(vi);
    lv=length(vfind);
    Wi=Bx(vfind,vfind);%B1 for neighbours, Bx for up to N steps between, BNm1 for N-1
    X(i)=sum(sum(triu(Wi)))/(lv*(lv+1)/2);
end
%{
for i=1:n
    vi=Ax(i,:);
    vfind=find(vi);
    lv=length(vfind);
    Wi=Bx(vfind,vfind);
    X(i)=sum(sum(triu(Wi)))/(lv*(lv-1)/2);
end
%}
end
%f=measureA; g=measureB;
f=[mean(X),var(X),min(X),prctile(X,[5,25,50,75,95]),max(X)];
%
fs=15; col1=[0,0,0];
figure
%{
subplot(2,1,1)
[counts,centers]=hist(C2,bins);
bar(centers,counts,'facecolor',col1,'edgecolor',col1,'barwidth',1);
maxF=max(counts);
axis([-eps/2,clusmax+eps/2,0,max(counts)])
%xlabel('Degree','FontSize',fs)
ylabel('Frequency','FontSize',fs)
subplot(2,1,2)
%}
[counts1,centers1]=hist(X,bins);
bar(centers1,counts1,'facecolor',col1,'edgecolor',col1,'barwidth',1);
axis([-eps/2,1+eps/2,0,2000])%clusmax+eps/2 max(counts1)
xlabel('Measure','FontSize',fs)
ylabel('Frequency','FontSize',fs)
%}