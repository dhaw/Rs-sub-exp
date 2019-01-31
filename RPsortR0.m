function f=RPsortR0(inc,gen,v)
r=(1:.2:2.4);
lr=length(r);
tvecin=cell(lr-1,1);
yvecin=tvecin;
genvecin=tvecin;
genratin=tvecin;
for i=1:lr-1
    [t1,y1,t2,y2]=RPprep44plots(inc,gen,v,r(i),r(i+1));
    tvecin{i}=t1;
    yvecin{i}=y1;
    genvecin{i}=t2;
    genratin{i}=y2;
end
RP4plotsGrid(tvecin,yvecin,genvecin,genratin);
    