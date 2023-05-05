close all;clear all

load('D:\Dropbox\Batch5\Batch5PD2sets.mat')
animalnum=8;
daynum=19;
figure;
hold on
plot(squeeze(Batch5PD2sets(:,1,1:daynum))','.-')
plot(mean(squeeze(Batch5PD2sets(:,1,1:daynum)))','.-k','LineWidth',3,...
    'MarkerEdgeColor','k','MarkerSize',10)
errorbar(1:daynum,mean(squeeze(Batch5PD2sets(:,1,1:daynum)))',...
    std(squeeze(Batch5PD2sets(:,1,1:daynum)))'/sqrt(animalnum),...
    '.-k','LineWidth',3,'MarkerEdgeColor','k','MarkerSize',10)
hold off
set(gca,'Fontsize',20)
title(sprintf('Pairwise Discrimination + Omission training\n Total trials completed, 45 vs H/V'),'Fontsize',20)
xlabel('Day','Fontsize',20)
ylabel('Total trials completed','Fontsize',20)

figure;
hold on
plot(squeeze(Batch5PD2sets(:,2,1:daynum))','.-')
plot(mean(squeeze(Batch5PD2sets(:,2,1:daynum)))','.-k','LineWidth',3,...
    'MarkerEdgeColor','k','MarkerSize',10)
errorbar(1:daynum,mean(squeeze(Batch5PD2sets(:,2,1:daynum)))',...
    std(squeeze(Batch5PD2sets(:,2,1:daynum)))'/sqrt(daynum),...
    '.-k','LineWidth',3,'MarkerEdgeColor','k','MarkerSize',10)
hold off
set(gca,'Fontsize',20)
title(sprintf('Pairwise Discrimination + Omission training\n Omitted trials, 45 vs H/V'),'Fontsize',20)
xlabel('Day','Fontsize',20)
ylabel('Omitted trials','Fontsize',20)

figure;
hold on
plot(squeeze(Batch5PD2sets(:,3,1:daynum))','.-')
plot(mean(squeeze(Batch5PD2sets(:,3,1:daynum)))','.-k','LineWidth',3,...
    'MarkerEdgeColor','k','MarkerSize',10)
errorbar(1:daynum,mean(squeeze(Batch5PD2sets(:,3,1:daynum)))',...
    std(squeeze(Batch5PD2sets(:,3,1:daynum)))'/sqrt(animalnum),...
    '.-k','LineWidth',3,'MarkerEdgeColor','k','MarkerSize',10)
hold off
set(gca,'Fontsize',20)
title(sprintf('Pairwise Discrimination + Omission training\n Accuracy percentage counting omission trials, 45 vs H/V'),'Fontsize',20)
xlabel('Day','Fontsize',20)
ylabel('Accuracy percentage','Fontsize',20)

conventcorrecttrial=Batch5PD2sets(:,1,1:daynum).*Batch5PD2sets(:,3,1:daynum);
conventtrialnum=Batch5PD2sets(:,1,1:daynum)-Batch5PD2sets(:,2,1:daynum);
conventaccuracy=conventcorrecttrial./conventtrialnum;
figure;
hold on
plot(squeeze(conventaccuracy(:,1,1:daynum))','.-')
plot(mean(squeeze(conventaccuracy(:,1,1:daynum)))','.-k','LineWidth',3,...
    'MarkerEdgeColor','k','MarkerSize',10)
errorbar(1:daynum,mean(squeeze(conventaccuracy(:,1,1:daynum)))',...
    std(squeeze(conventaccuracy(:,1,1:daynum)))'/sqrt(animalnum),...
    '.-k','LineWidth',3,'MarkerEdgeColor','k','MarkerSize',10)
hold off
set(gca,'Fontsize',20)
title(sprintf('Pairwise Discrimination + Omission training\n Accuracy percentage NOT counting omission trials, 45 vs H/V'),'Fontsize',20)
xlabel('Day','Fontsize',20)
ylabel('Accuracy percentage','Fontsize',20)



