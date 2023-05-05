trialnum=[];
accur=[];
for daynum=1:30
    for animid=[3 4 5 6 7 9 10 12]
        
        animind=find(everyday(:,1,daynum)==animid);
        
        trialnum=[trialnum everyday(animind,2,daynum)];
        accur=[accur everyday(animind,3,daynum)];
        
    end
end

trialnum=[trialnum(1:223) NaN trialnum(224:230) NaN trialnum(231:237) NaN]; 
accur=[accur(1:223) NaN accur(224:230) NaN accur(231:237) NaN]; 

trialnum=reshape(trialnum,8,30);
accur=reshape(accur,8,30);

semtr=nanstd(trialnum)/sqrt(8);
semacc=nanstd(accur)/sqrt(8);

figure;
hold on
plot(1:30,accur)
plot(1:30,nanmean(accur),'k','Linewidth',2.5)
errorbar(1:30,nanmean(accur),semacc,'k','Linewidth',2.5)
hold off
title('VDT PD Learning Curves - Accuracy','Fontsize',20)
ylabel('Accuracy including omissions','Fontsize',20)
xlabel('PD Days','Fontsize',20)
set(gca,'Fontsize',20)
axis([0 30 0 100])
legend 
legend('Animal 1','Animal 2','Animal 3','Animal 4', 'Animal 5', 'Animal 6', 'Animal 7', 'Animal 8', 'Mean', 'Location','NorthWest')

figure;
hold on
plot(1:30,trialnum)
plot(1:30,nanmean(trialnum),'k','Linewidth',2.5)
errorbar(1:30,nanmean(trialnum),semtr,'k','Linewidth',2.5)
hold off
title('VDT PD Learning Curves - Completed Trial Numbers','Fontsize',20)
ylabel('Completed Trial Number','Fontsize',20)
xlabel('PD Days','Fontsize',20)
set(gca,'Fontsize',20)
axis([0 30 0 200])

legend('Animal 1','Animal 2','Animal 3','Animal 4', 'Animal 5', 'Animal 6', 'Animal 7', 'Animal 8', 'Mean', 'Location','NorthWest')