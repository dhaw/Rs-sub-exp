function f=RPcellMean1D(cell)
%Mean over dim 2 of a cell array
%(pointwise mean of entries - must be same size)
[l1,l2]=size(cell);
cellOut=cell(l1,1);
for i=1:l1
    x=zeros(size(cell{1},1),size(cell{1},2),l2);
    ci=cell(i,:);
    for j=1:l2
        cij=ci{j};
        x(:,:,j)=cij;
    end
    cellOut{i}=nanmean(x,3);
end
f=cellOut;

    