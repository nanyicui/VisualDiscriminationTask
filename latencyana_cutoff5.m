%% All Latencies smaller than 5 seconds
clear all;close all;
pathname1 = 'D:\Dropbox\Batch4\Batch4rawdata\';
latencyallanim=[];
for animID=1:8
    %figure(animID)
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
        latencyallanim=[latencyallanim;[[TS(:,2)-TS(:,1)],TS(:,3:4),TS(:,2)]];
        
    end
end
latencyallanim=latencyallanim(latencyallanim(:,1)<5,:);
figure;
hist(latencyallanim(:,1),5);title('Histogram of latencies (initiate-touch) of all animals in both CO & SD condition')
xlabel('latency /second');h=findobj(gca,'Type','patch');
%set(gca,'Xscale','log');
set(h,'FaceColor',[0,0,0],'EdgeColor',[0,0,0]);
latencyallanim_15=latencyallanim(latencyallanim(:,4)<900,1);
latencyallanim_30=latencyallanim(latencyallanim(:,4)<1800 & latencyallanim(:,4)>=900,1);
latencyallanim_45=latencyallanim(latencyallanim(:,4)<2700 & latencyallanim(:,4)>=1800,1);
latencyallanim_60=latencyallanim(latencyallanim(:,4)<3600 & latencyallanim(:,4)>=2700,1);

meanallanim_15=mean(latencyallanim_15);rmsallanim_15=std(latencyallanim_15)/sqrt(length(latencyallanim_15));
meanallanim_30=mean(latencyallanim_30);rmsallanim_30=std(latencyallanim_30)/sqrt(length(latencyallanim_30));
meanallanim_45=mean(latencyallanim_45);rmsallanim_45=std(latencyallanim_45)/sqrt(length(latencyallanim_45));
meanallanim_60=mean(latencyallanim_60);rmsallanim_60=std(latencyallanim_60)/sqrt(length(latencyallanim_60));

figure;plot([1,2,3,4],[meanallanim_15,meanallanim_30,meanallanim_45,meanallanim_60]);errorbar([1,2,3,4],[meanallanim_15,meanallanim_30,meanallanim_45,meanallanim_60],[rmsallanim_15,rmsallanim_30,rmsallanim_45,rmsallanim_60]);
p=linhyptest([meanallanim_15,meanallanim_30,meanallanim_45,meanallanim_60]);
title(sprintf('Average latencies of all animals in both CO & SD condition divided in four sessions\n linearity test p=%f',p));xlabel('15-minute sessions')
%% Condition Dependence
clear all;pathname1 = 'D:\Dropbox\Batch4\Batch4rawdata\';
latencyCOanim=[];
for animID=1:8
    cond=1;
        if cond==1
            condition='CO';
        else condition='SD';
        end
        fileID = fopen([pathname1,'mouse',num2str(animID),condition,'.mat'],'r');
        load([pathname1,'mouse',num2str(animID),condition,'.mat'])
        latencyCOanim=[latencyCOanim;[[TS(:,2)-TS(:,1)],TS(:,3:4),TS(:,2)]];
end
latencyCOanim=latencyCOanim(latencyCOanim(:,1)<5,:);
[NCOall,X]=hist(latencyCOanim(:,1),5);
latencySDanim=[];
for animID=1:8
 cond=2;
        if cond==1
            condition='CO';
        else condition='SD';
        end
        fileID = fopen([pathname1,'mouse',num2str(animID),condition,'.mat'],'r');     
        load([pathname1,'mouse',num2str(animID),condition,'.mat'])
        latencySDanim=[latencySDanim;[[TS(:,2)-TS(:,1)],TS(:,3:4),TS(:,2)]];
end
latencySDanim=latencySDanim(latencySDanim(:,1)<5,:);
[NSDall,X]=hist(latencySDanim(:,1),5);
figure;h=bar(X,[NCOall;NSDall]');
[~,p]=ttest2(latencyCOanim(:,1),latencySDanim(:,1));
title(sprintf('Histogram of latencies (initiate-touch) of all animals in CO vs SD condition\np=%f',p))
xlabel('latency /second');%set(gca,'Xscale','log');
legend(h,'CO','SD');

latencyCOanim_15=latencyCOanim(latencyCOanim(:,4)<900,1);
latencyCOanim_30=latencyCOanim(latencyCOanim(:,4)<1800 & latencyCOanim(:,4)>=900,1);
latencyCOanim_45=latencyCOanim(latencyCOanim(:,4)<2700 & latencyCOanim(:,4)>=1800,1);
latencyCOanim_60=latencyCOanim(latencyCOanim(:,4)<3600 & latencyCOanim(:,4)>=2700,1);

meanCOanim_15=mean(latencyCOanim_15);rmsCOanim_15=std(latencyCOanim_15)/sqrt(length(latencyCOanim_15));
meanCOanim_30=mean(latencyCOanim_30);rmsCOanim_30=std(latencyCOanim_30)/sqrt(length(latencyCOanim_30));
meanCOanim_45=mean(latencyCOanim_45);rmsCOanim_45=std(latencyCOanim_45)/sqrt(length(latencyCOanim_45));
meanCOanim_60=mean(latencyCOanim_60);rmsCOanim_60=std(latencyCOanim_60)/sqrt(length(latencyCOanim_60));

latencySDanim_15=latencySDanim(latencySDanim(:,4)<900,1);
latencySDanim_30=latencySDanim(latencySDanim(:,4)<1800 & latencySDanim(:,4)>=900,1);
latencySDanim_45=latencySDanim(latencySDanim(:,4)<2700 & latencySDanim(:,4)>=1800,1);
latencySDanim_60=latencySDanim(latencySDanim(:,4)<3600 & latencySDanim(:,4)>=2700,1);

meanSDanim_15=mean(latencySDanim_15);rmsSDanim_15=std(latencySDanim_15)/sqrt(length(latencySDanim_15));
meanSDanim_30=mean(latencySDanim_30);rmsSDanim_30=std(latencySDanim_30)/sqrt(length(latencySDanim_30));
meanSDanim_45=mean(latencySDanim_45);rmsSDanim_45=std(latencySDanim_45)/sqrt(length(latencySDanim_45));
meanSDanim_60=mean(latencySDanim_60);rmsSDanim_60=std(latencySDanim_60)/sqrt(length(latencySDanim_60));
Y=[[meanCOanim_15,meanCOanim_30,meanCOanim_45,meanCOanim_60]',[meanSDanim_15,meanSDanim_30,meanSDanim_45,meanSDanim_60]'];
E=[[rmsCOanim_15,rmsCOanim_30,rmsCOanim_45,rmsCOanim_60]',[rmsSDanim_15,rmsSDanim_30,rmsSDanim_45,rmsSDanim_60]'];
figure;hold on;plot([1,2,3,4],Y);errorbar([[1,2,3,4]',[1,2,3,4]'],Y,E);hold off
pCO=linhyptest([meanCOanim_15,meanCOanim_30,meanCOanim_45,meanCOanim_60]);
pSD=linhyptest([meanSDanim_15,meanSDanim_30,meanSDanim_45,meanSDanim_60]);
title(sprintf('Average latencies of CO and SD animals divided in four sessions\n linearity test in CO p=%f, and in SD p=%f',pCO,pSD));xlabel('15-minute sessions')
legend('CO','SD')


%% Outcome Dependence
latallanim=[];
for animID=1:8
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
        latallanim=[latallanim;[[TS(:,2)-TS(:,1)],TS(:,3:4)]];   
    end
end
latallanim=latallanim(latallanim(:,1)<5,:);
latallanim_correct=latallanim(latallanim(:,2)==1,1);
latallanim_incorrect=latallanim(latallanim(:,2)==0,1);
[Ncorrect,X]=hist(latallanim_correct,5);
[Nincorrect,X]=hist(latallanim_incorrect,5);
figure;h=bar(X,[Ncorrect;Nincorrect]');
[~,p]=ttest2(latallanim_correct,latallanim_incorrect);
title(sprintf('Histogram of latencies (initiate-touch) of \n CORRECT vs INCORRECT trials of all animals in both CO & SD condition\np=%f',p))
xlabel('latency /second');%set(gca,'Xscale','log');
legend('Correct','Incorrect');

%% Meshing Condition and Outcome Dependence
latCOcorrect=latencyCOanim(latencyCOanim(:,2)==1,1);[NCOcorrect,X]=hist(latCOcorrect,5);
latCOincorrect=latencyCOanim(latencyCOanim(:,2)==0,1);[NCOincorrect,XX]=hist(latCOincorrect,5);
latSDcorrect=latencySDanim(latencySDanim(:,2)==1,1);[NSDcorrect,Y]=hist(latSDcorrect,5);
latSDincorrect=latencySDanim(latencySDanim(:,2)==0,1);[NSDincorrect,YY]=hist(latSDincorrect,5);

[~,p]=ttest2(latCOcorrect,latCOincorrect);
figure;h=bar(XX,[NCOcorrect;NCOincorrect]');title(sprintf('Histogram of latencies (initiate-touch) of \n CORRECT vs INCORRECT of CO condition\np=%f',p))
xlabel('latency /second');%set(gca,'Xscale','log');
legend('COCorrect','COIncorrect');
[~,p]=ttest2(latSDcorrect,latSDincorrect);
figure;h=bar(YY,[NSDcorrect;NSDincorrect]');title(sprintf('Histogram of latencies (initiate-touch) of \n CORRECT vs INCORRECT of SD condition\np=%f',p))
xlabel('latency /second');%set(gca,'Xscale','log');
legend('SDCorrect','SDIncorrect');
[~,p]=ttest2(latCOcorrect,latSDcorrect);
figure;h=bar(Y,[NCOcorrect;NSDcorrect]');title(sprintf('Histogram of latencies (initiate-touch) of \n CO vs SD in CORRECT trials\np=%f',p))
xlabel('latency /second');%set(gca,'Xscale','log');
legend('COCorrect','SDCorrect');
[~,p]=ttest2(latCOincorrect,latSDincorrect);
figure;h=bar(YY,[NCOincorrect;NSDincorrect]');title(sprintf('Histogram of latencies (initiate-touch) of \n CO vs SD in INCORRECT trials\np=%f',p))
xlabel('latency /second');%set(gca,'Xscale','log');
legend('COInorrect','SDIncorrect');

%% Difficulty Dependence
latCOhv=latencyCOanim((latencyCOanim(:,3)==1 | latencyCOanim(:,3)==15),1);
latCOeasy=latencyCOanim((latencyCOanim(:,3)==3 | latencyCOanim(:,3)==13),1);
latCOmedium=latencyCOanim((latencyCOanim(:,3)==5 | latencyCOanim(:,3)==11),1);
latCOhard=latencyCOanim((latencyCOanim(:,3)==7 | latencyCOanim(:,3)==9),1);
latSDhv=latencySDanim((latencySDanim(:,3)==1 | latencySDanim(:,3)==15),1);
latSDeasy=latencySDanim((latencySDanim(:,3)==3 | latencySDanim(:,3)==13),1);
latSDmedium=latencySDanim((latencySDanim(:,3)==5 | latencySDanim(:,3)==11),1);
latSDhard=latencySDanim((latencySDanim(:,3)==7 | latencySDanim(:,3)==9),1);

[COhv,X]=hist(latCOhv,5);[COeasy,X]=hist(latCOeasy,5);[COmedium,X]=hist(latCOmedium,5);[COhard,X]=hist(latCOhard,5);
[SDhv,X]=hist(latSDhv,5);[SDeasy,X]=hist(latSDeasy,5);[SDmedium,X]=hist(latSDmedium,5);[SDhard,X]=hist(latSDhard,5);
[~,p]=ttest2(latCOhv,latSDhv);
figure;bar(X,[COhv;SDhv]');title(sprintf('Histogram of latencies of 0 & 90 degrees (training images)\np=%f',p));
xlabel('latency/second');legend('COhv','SDhv');
[~,p]=ttest2(latCOeasy,latSDeasy);
figure;bar(X,[COeasy;SDeasy]');title(sprintf('Histogram of latencies of 10 & 80 degrees (easy images)\np=%f',p));
xlabel('latency/second');legend('COeasy','SDeasy');
[~,p]=ttest2(latCOmedium,latSDmedium);
figure;bar(X,[COmedium;SDmedium]');title(sprintf('Histogram of latencies of 20 & 70 degrees (medium images)\np=%f',p));
xlabel('latency/second');legend('COmedium','SDmedium');
[~,p]=ttest2(latCOhard,latSDhard);
figure;bar(X,[COhard;SDhard]');title(sprintf('Histogram of latencies of 30 & 60 degrees (hard images)\np=%f',p));
xlabel('latency/second');legend('COhard','SDhard');
%% Meshing Condition, Outcome and Difficulty Dependence
latCOhvcorrect=latencyCOanim(((latencyCOanim(:,3)==1 | latencyCOanim(:,3)==15) & latencyCOanim(:,2)==1),1);
latCOeasycorrect=latencyCOanim(((latencyCOanim(:,3)==3 | latencyCOanim(:,3)==13) & latencyCOanim(:,2)==1),1);
latCOmediumcorrect=latencyCOanim(((latencyCOanim(:,3)==5 | latencyCOanim(:,3)==11) & latencyCOanim(:,2)==1),1);
latCOhardcorrect=latencyCOanim(((latencyCOanim(:,3)==7 | latencyCOanim(:,3)==9) & latencyCOanim(:,2)==1),1);
latSDhvcorrect=latencySDanim(((latencySDanim(:,3)==1 | latencySDanim(:,3)==15) & latencySDanim(:,2)==1),1);
latSDeasycorrect=latencySDanim(((latencySDanim(:,3)==3 | latencySDanim(:,3)==13) & latencySDanim(:,2)==1),1);
latSDmediumcorrect=latencySDanim(((latencySDanim(:,3)==5 | latencySDanim(:,3)==11) & latencySDanim(:,2)==1),1);
latSDhardcorrect=latencySDanim(((latencySDanim(:,3)==7 | latencySDanim(:,3)==9) & latencySDanim(:,2)==1),1);
latCOhvincorrect=latencyCOanim(((latencyCOanim(:,3)==1 | latencyCOanim(:,3)==15) & latencyCOanim(:,2)==0),1);
latCOeasyincorrect=latencyCOanim(((latencyCOanim(:,3)==3 | latencyCOanim(:,3)==13) & latencyCOanim(:,2)==0),1);
latCOmediumincorrect=latencyCOanim(((latencyCOanim(:,3)==5 | latencyCOanim(:,3)==11) & latencyCOanim(:,2)==0),1);
latCOhardincorrect=latencyCOanim(((latencyCOanim(:,3)==7 | latencyCOanim(:,3)==9) & latencyCOanim(:,2)==0),1);
latSDhvincorrect=latencySDanim(((latencySDanim(:,3)==1 | latencySDanim(:,3)==15) & latencySDanim(:,2)==0),1);
latSDeasyincorrect=latencySDanim(((latencySDanim(:,3)==3 | latencySDanim(:,3)==13) & latencySDanim(:,2)==0),1);
latSDmediumincorrect=latencySDanim(((latencySDanim(:,3)==5 | latencySDanim(:,3)==11) & latencySDanim(:,2)==0),1);
latSDhardincorrect=latencySDanim(((latencySDanim(:,3)==7 | latencySDanim(:,3)==9) & latencySDanim(:,2)==0),1);

[COhvcorrect,X]=hist(latCOhvcorrect,5);[COeasycorrect,X]=hist(latCOeasycorrect,5);[COmediumcorrect,X]=hist(latCOmediumcorrect,5);[COhardcorrect,X]=hist(latCOhardcorrect,5);
[SDhvcorrect,X]=hist(latSDhvcorrect,5);[SDeasycorrect,X]=hist(latSDeasycorrect,5);[SDmediumcorrect,X]=hist(latSDmediumcorrect,5);[SDhardcorrect,X]=hist(latSDhardcorrect,5);
[~,p]=ttest2(latCOhvcorrect,latSDhvcorrect);
figure;bar(X,[COhvcorrect;SDhvcorrect]');title(sprintf('Histogram of latencies correct trials of 0 & 90 degrees (training images)\np=%f',p));
xlabel('latency/second');legend('COhvcorrect','SDhvcorrect');
[~,p]=ttest2(latCOeasycorrect,latSDeasycorrect);
figure;bar(X,[COeasycorrect;SDeasycorrect]');title(sprintf('Histogram of latencies correct trials of 10 & 80 degrees (easy images)\np=%f',p));
xlabel('latency/second');legend('COeasycorrect','SDeasycorrect');
[~,p]=ttest2(latCOmediumcorrect,latSDmediumcorrect);
figure;bar(X,[COmediumcorrect;SDmediumcorrect]');title(sprintf('Histogram of latencies correct trials of 20 & 70 degrees (medium images)\np=%f',p));
xlabel('latency/second');legend('COmediumcorrect','SDmediumcorrect');
[~,p]=ttest2(latCOhardcorrect,latSDhardcorrect);
figure;bar(X,[COhardcorrect;SDhardcorrect]');title(sprintf('Histogram of latencies correct trials of 30 & 60 degrees (hard images)\np=%f',p));
xlabel('latency/second');legend('COhardcorrect','SDhardcorrect');

[COhvincorrect,X]=hist(latCOhvincorrect,5);[COeasyincorrect,X]=hist(latCOeasyincorrect,5);[COmediumincorrect,X]=hist(latCOmediumincorrect,5);[COhardincorrect,X]=hist(latCOhardincorrect,5);
[SDhvincorrect,X]=hist(latSDhvincorrect,5);[SDeasyincorrect,X]=hist(latSDeasyincorrect,5);[SDmediumincorrect,X]=hist(latSDmediumincorrect,5);[SDhardincorrect,X]=hist(latSDhardincorrect,5);
[~,p]=ttest2(latCOhvincorrect,latSDhvincorrect);ally,
figure;bar(X,[COhvincorrect;SDhvincorrect]');title(sprintf('Histogram of latencies incorrect trials of 0 & 90 degrees (training images)\np=%f',p));
xlabel('latency/second');legend('COhvincorrect','SDhvincorrect');
[~,p]=ttest2(latCOeasyincorrect,latSDeasyincorrect);
figure;bar(X,[COeasyincorrect;SDeasyincorrect]');title(sprintf('Histogram of latencies incorrect trials of 10 & 80 degrees (easy images)\np=%f',p));
xlabel('latency/second');legend('COeasyincorrect','SDeasyincorrect');
[~,p]=ttest2(latCOmediumincorrect,latSDmediumincorrect);
figure;bar(X,[COmediumincorrect;SDmediumincorrect]');title(sprintf('Histogram of latencies incorrect trials of 20 & 70 degrees (medium images)\np=%f',p));
xlabel('latency/second');legend('COmediumincorrect','SDmediumincorrect');
[~,p]=ttest2(latCOhardincorrect,latSDhardincorrect);
figure;bar(X,[COhardincorrect;SDhardincorrect]');title(sprintf('Histogram of latencies incorrect trials of 30 & 60 degrees (hard images)\np=%f',p));
xlabel('latency/second');legend('COhardincorrect','SDhardincorrect');

%% Longest X% latencies
FS=10;latencyCOanim_sort=sort(latencyCOanim(:,1));latlongCO=latencyCOanim_sort(end-ceil(length(latencyCOanim)/FS):end);
latencySDanim_sort=sort(latencySDanim(:,1));latlongSD=latencySDanim_sort(end-ceil(length(latencySDanim)/FS):end);
mean_latlongCO=mean(latlongCO);
mean_latlongSD=mean(latlongSD);
rms_latlongCO=std(latlongCO)/sqrt(length(latlongCO));
rms_latlongSD=std(latlongSD)/sqrt(length(latlongSD));
[~,p]=ttest2(latlongCO,latlongSD);
figure;bar([1,2],[mean_latlongCO,mean_latlongSD],'w');hold on;errorbar([1,2],[mean_latlongCO,mean_latlongSD],[rms_latlongCO,rms_latlongSD]);hold off;
title(sprintf('longest 10 percent latencies in CO and SD contitions\np=%f',p));xlabel(sprintf(['CO                                         SD']));ylabel('latency /sec');
latlongCO=cell(1,4);mean_latlongCO=zeros(1,4);rms_latlongCO=zeros(1,4);
[latlongCO{1},mean_latlongCO(1),rms_latlongCO(1)]=longestxlat(latencyCOanim_15,10);
[latlongCO{2},mean_latlongCO(2),rms_latlongCO(2)]=longestxlat(latencyCOanim_30,10);
[latlongCO{3},mean_latlongCO(3),rms_latlongCO(3)]=longestxlat(latencyCOanim_45,10);
[latlongCO{4},mean_latlongCO(4),rms_latlongCO(4)]=longestxlat(latencyCOanim_60,10);
latlongSD=cell(1,4);mean_latlongSD=zeros(1,4);rms_latlongSD=zeros(1,4);
[latlongSD{1},mean_latlongSD(1),rms_latlongSD(1)]=longestxlat(latencySDanim_15,10);
[latlongSD{2},mean_latlongSD(2),rms_latlongSD(2)]=longestxlat(latencySDanim_30,10);
[latlongSD{3},mean_latlongSD(3),rms_latlongSD(3)]=longestxlat(latencySDanim_45,10);
[latlongSD{4},mean_latlongSD(4),rms_latlongSD(4)]=longestxlat(latencySDanim_60,10);
for n=1:4
[~,p(n)]=ttest2(latlongCO{n},latlongSD{n});end
figure;bar([1,2,3,4],[mean_latlongCO;mean_latlongSD]');errorbar([1,2,3,4;1,2,3,4]',[mean_latlongCO;mean_latlongSD]',[rms_latlongCO;rms_latlongSD]')
title(sprintf('Means of longest latencies of those smaller than 5 seconds\n of four 15-minute sessions in CO and SD conditions\np1=%f, p2=%f, p3=%f, p4=%f',p(1),p(2),p(3),p(4)));
legend('CO','SD');