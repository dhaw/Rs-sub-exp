function f=RPplotMeans2(X,Y,HH,numClus)%(f0stats,f3stats,f4stats,f5stats,f6stats)
%numClus=1;
la=length(X);
M=zeros(la,9);
for i=1:la
    Xi=X{i};
    M(i,:)=Xi(numClus,:);
    %
    if numClus<=2
        Yi=Y{i};
        M(i,:)=Yi(numClus,:);
    end
    %}
end
M=M(:,4:8);
M=HH(:,4:8);
f=M;
figure;
%plot(0:6,HH(:,1),'k-','linewidth',1)
hold on
h=boxplot(M','positions',0:6,'labels',0:6);
set(h,{'linew'},{1})
%%% modify the figure properties (set the YData property)  
%h(5,1) correspond the blue box  
%h(1,1) correspond the upper whisker  
%h(2,1) correspond the lower whisker  
%{
set(h(5,1), 'YData', [50,75,25,75,25]);% blue box  
upWhisker = get(h(1,1), 'YData');  
set(h(1,1), 'YData', [100 100])  
dwWhisker = get(h(2,1), 'YData');  
set(h(2,1), 'YData', [0 0]) 
%}
hold off
set(gca,'fontsize',12)
%set(gca,'xtick',0:6)
axis ([-.5,6.5,0,.5])%.2 
xlabel('\alpha')%ylabel(strcat('Clustering order',num2str(alpha),')'))
%ylabel(strcat('Order ',{' '},num2str(numClus))))
ylabel(strcat('Order ',{' '},num2str(numClus),{' '},'(households)'))
grid on
grid minor
%{
yyaxis right
plot(1:numClus,X(1,:),'--','linewidth',1.5)
axis([.8,numClus+.2,-1,1])
ylabel('Correlation with \alpha')%,'rot',-90)
%hold on
%plot(1:numClus,X(2,:),':','linewidth',1.5)
%hold off
%}