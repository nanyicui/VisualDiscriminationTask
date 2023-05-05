%% Left/Right Asymmetry
clear;
% plot left/right turning
pathin='D:\Dropbox\Batch4\Batch4rawdata\';
figure1=figure;
hold on
counter=1;trialnumCO=[];
for m=1:8
      
    mname=['mouse',num2str(m),'CO']; 
    
    filecheck=fopen([pathin,mname,'.mat'],'r');
    
    eval(['load ',pathin,mname,'.mat beamcross TS turncol imagecol nosepokecol -mat']);
   
    
    rightturn=turncol';leftturn=~rightturn;
    createfigureci(rightturn,leftturn,counter/20,figure1)
    
    truecorrect=nosepokecol(:,1)==imagecol;
    ImageR=truecorrect(imagecol==1);ImageRacc_CO(counter)=sum(ImageR)/length(ImageR);
    ImageL=truecorrect(imagecol==0);ImageLacc_CO(counter)=sum(ImageL)/length(ImageL);
    LRasymmetry_CO(counter)=(sum(turncol)-sum(turncol==0))/length(turncol);
    rightturns=truecorrect(turncol==1);rightturnaccCO(counter)=sum(rightturns)/length(rightturns);
    leftturns=truecorrect(turncol==0);leftturnaccCO(counter)=sum(leftturns)/length(leftturns);
    
    LRmatrix=[turncol imagecol nosepokecol(:,1)];
    lll=sum(abs(LRmatrix-repmat([0 0 0],length(LRmatrix),1)),2)==0;
    llr=sum(abs(LRmatrix-repmat([0 0 1],length(LRmatrix),1)),2)==0;
    lrl=sum(abs(LRmatrix-repmat([0 1 0],length(LRmatrix),1)),2)==0;
    lrr=sum(abs(LRmatrix-repmat([0 1 1],length(LRmatrix),1)),2)==0;
    rll=sum(abs(LRmatrix-repmat([1 0 0],length(LRmatrix),1)),2)==0;
    rlr=sum(abs(LRmatrix-repmat([1 0 1],length(LRmatrix),1)),2)==0;
    rrl=sum(abs(LRmatrix-repmat([1 1 0],length(LRmatrix),1)),2)==0;
    rrr=sum(abs(LRmatrix-repmat([1 1 1],length(LRmatrix),1)),2)==0;

    LRtree_CO(counter,:)=[sum(lll) sum(llr) sum(lrl) sum(lrr) sum(rll) sum(rlr) sum(rrl) sum(rrr)]/length(LRmatrix);
    trialnumCO=[trialnumCO;length(LRmatrix)];
    counter=counter+1;
    clear LRmatrix lll llr lrl lrr rll rlr rrl rrr
end
hold off

hold on
figure2=figure;
counter=1; trialnumSD=[];
for m=1:8
    
    mname=['mouse',num2str(m),'SD']; 
    if m==5 
         mname=['mouse',num2str(m),'SDr']; end
    filecheck=fopen([pathin,mname,'.mat'],'r');
    
    eval(['load ',pathin,mname,'.mat beamcross TS turncol imagecol nosepokecol -mat']);
        
    rightturn=turncol';leftturn=~rightturn;
    createfigureci(rightturn,leftturn,counter/20,figure2)
    
    truecorrect=nosepokecol(:,1)==imagecol;
    ImageR=truecorrect(imagecol==1);ImageRacc_SD(counter)=sum(ImageR)/length(ImageR);
    ImageL=truecorrect(imagecol==0);ImageLacc_SD(counter)=sum(ImageL)/length(ImageL);
    LRasymmetry_SD(counter)=(sum(turncol)-sum(turncol==0))/length(turncol);
    rightturns=truecorrect(turncol==1);rightturnaccSD(counter)=sum(rightturns)/length(rightturns);
    leftturns=truecorrect(turncol==0);leftturnaccSD(counter)=sum(leftturns)/length(leftturns);
    
    LRmatrix=[turncol imagecol nosepokecol(:,1)];
    lll=sum(abs(LRmatrix-repmat([0 0 0],length(LRmatrix),1)),2)==0;
    llr=sum(abs(LRmatrix-repmat([0 0 1],length(LRmatrix),1)),2)==0;
    lrl=sum(abs(LRmatrix-repmat([0 1 0],length(LRmatrix),1)),2)==0;
    lrr=sum(abs(LRmatrix-repmat([0 1 1],length(LRmatrix),1)),2)==0;
    rll=sum(abs(LRmatrix-repmat([1 0 0],length(LRmatrix),1)),2)==0;
    rlr=sum(abs(LRmatrix-repmat([1 0 1],length(LRmatrix),1)),2)==0;
    rrl=sum(abs(LRmatrix-repmat([1 1 0],length(LRmatrix),1)),2)==0;
    rrr=sum(abs(LRmatrix-repmat([1 1 1],length(LRmatrix),1)),2)==0;

    LRtree_SD(counter,:)=[sum(lll) sum(llr) sum(lrl) sum(lrr) sum(rll) sum(rlr) sum(rrl) sum(rrr)]/length(LRmatrix);
     trialnumSD=[trialnumSD;length(LRmatrix)];
    counter=counter+1;
    clear LRmatrix lll llr lrl lrr rll rlr rrl rrr
end
hold off

[p,h]=ttest(LRasymmetry_CO,LRasymmetry_SD)

figure3 = figure;

axes1 = axes('Parent',figure1,'YTick',[1 2 3 4 5 6 7 8],'FontSize',28);
xlim(axes1,[-1 1]);
box(axes1,'on');
hold(axes1,'all');
bar1 = barh([LRasymmetry_CO;LRasymmetry_SD]','Horizontal','on','Parent',axes1);
set(bar1(1),'DisplayName','Control');
set(bar1(2),'DisplayName','Sleep Deprivation');
xlabel({'LEFT                                                                               Asymmetry                                                                             RIGHT'},...
    'FontSize',28);
ylabel({'Animals ID'},'FontSize',28);
title({'Average Turning Laterality of All Trials in Control versus SD'},...
    'FontSize',28);
legend(axes1,'show');
annotation(figure3,'textbox',...
    [0.661937499999999 0.745684695051784 0.239104166666667 0.0540851553509783],...
    'String',{'Student''s Paired T-test: p = 0.7633'},...
    'FontSize',28,...
    'FitBoxToText','off');

