function f=RPforSteven
%Need RPmclusterStats
%and RPbaramasiStats
%and all files to load

load('mon0.mat')
load('mon3.mat')
load('mon4.mat')
load('mon5.mat')
load('mon6.mat')
v=[0,3,4,5,6];
lv=lebgth(v);
mmax=5;

disp('Thank you Steven')
for i=1:lv
    vname=strcat('mon',num2str(v(i)));
    G=genvarname(vname);
    mcluster=RPmclusterStats(G,mmax);
    Barabasi=RPbarabasiStats(G,mmax);
    save(strcat(vname,'Stats'),mcluster,Barabasi)
end