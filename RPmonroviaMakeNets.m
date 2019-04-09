%
function f=RPmonroviaMakeNets
a=0:6;
la=length(a);
Gcell=cell(la,1);
fpath='..\HOC netsAndData\';
%fpath='..\Monrovia HHS 4 WPS 50 pwp 0.14 set C\Monrovia HHS 4 WPS 50 pwp 0.14 set C\';
for i=1:la
    ai=a(i);
    fname=strcat(fpath,'HHnet',num2str(ai),'.csv');
    netData=csvread(fullfile(fname),1,1);
    Gcell{i}=RPcombine(netData);
end
f=Gcell;
%}
%{
G0=G{1};
G1=G{2};
G2=G{3};
G3=G{4};
G4=G{5};
G5=G{6};
G6=G{7};
psave('G')
%}
%{
function f=RPmonroviaMakeNets(H0,H1,H2,H3,H4,H5,H6)
la=7;
Hcell={H0,H1,H2,H3,H4,H5,H6};%cell(la,1);
%{
Hcell{0}=RPcombine(H0);
Hcell{1}=RPcombine(H1);
Hcell{2}=RPcombine(H2);
Hcell{3}=RPcombine(H3);
Hcell{4}=RPcombine(H4);
Hcell{5}=RPcombine(H5);
Hcell{6}=RPcombine(H6);
%}
f=Hcell;
%}