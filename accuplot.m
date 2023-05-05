clear all;
pathname1 = 'D:\Dropbox\Batch4\Batch4rawdata\';

for animID=1:8
    figure(animID)
    for cond=1:2

        if cond==1
            condition='CO';
        else condition='SD';
        end
        fileID = fopen([pathname1,'mouse',num2str(animID),condition,'.mat'],'r');
        if fileID<0
            continue
        end
        
        load([pathname1,'mouse',num2str(animID),condition,'.mat'])
       
        subplot(1,2,cond),bar([accu_0 accu_10 accu_20 accu_30 accu_60 accu_70 accu_80 accu_90])
        subplot(1,2,cond),bar([accu_0 accu_10 accu_20 accu_30 accu_60 accu_70 accu_80 accu_90])
        
        accu(:,animID,cond)=[accu_0 accu_10 accu_20 accu_30 accu_60 accu_70 accu_80 accu_90];

    end
end

meanaccu=squeeze(mean(accu,2));
rmsaccu=squeeze(std(accu,1,2)/sqrt(8));

figure;
hold on
plot([0,10,20,30,60,70,80,90],meanaccu(:,1)*100,'b*','LineWidth',5,'MarkerSize',15);errorbar([0,10,20,30,60,70,80,90],meanaccu(:,1)*100,zeros(1,8),rmsaccu(:,1)*100,'b','LineWidth',5,'MarkerSize',15);
plot([0,10,20,30,60,70,80,90],meanaccu(:,2)*100,'r*','LineWidth',5,'MarkerSize',15);errorbar([0,10,20,30,60,70,80,90],meanaccu(:,2)*100,zeros(1,8),rmsaccu(:,2)*100,'r','LineWidth',5,'MarkerSize',15);
hold off

axis([-10 100 50 100])
legend('CO Accuracy','CO Standard error mean','SD Accuracy','SD Standard error mean','Location','SouthEast','Fontsize',26);
title('Performance Accuracy against Image Similarity','Fontsize',26);
xlabel('Non-rewarded Image Orientation Degree','Fontsize',26);ylabel('Performance Accuracy / % ','Fontsize',26);
set(gca,'FontSize',26)
for degree=1:8
[t(degree),p(degree)]=ttest(accu(degree,:,1),accu(degree,:,2));
end
figure;
plot([0,10,20,30,60,70,80,90],p,'k');
xlabel('Non-rewarded Image Orientation Degree','Fontsize',20);
title('P-values against Image Similarity (Reward Image is always 45 degree oriented)','Fontsize',20);
