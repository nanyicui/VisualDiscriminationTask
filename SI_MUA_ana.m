%% Sleep Inertia MUA Analysis (in rats)
clear all
close all
for episode=1
for swpwinsize=[5 9] 

allVSUnits=[];allVSepochs=[];allVSspectra=[];
%%% Loading %%%

path = 'D:\OutputUnitsLFPs\';
ratnumber=174;
baseline=9;


for VS=[2 1 3];
    
    load([path 'rw' num2str(ratnumber) '-BSL' num2str(baseline) '-VS' num2str(VS) '-TS-LFP-500ms-F-Epi' num2str(episode) '.mat'])
    VSlength(VS)=length(Units);%wrong here, fixed below
    allVSUnits=[allVSUnits Units];allVSepochs=[allVSepochs; epochs];allVSspectra=[allVSspectra spectra];
    
end
%%% Identify All "OFF" Periods of all VS of one animal%%%

% windowsize for sweeping kernel, Must Be ODD

[off_periods,sum_windowsweep,centreunq]=classifier_onoff(allVSUnits,swpwinsize);
% for nsam=1:5
% for b=1:size(allVSUnits,1)
% randoff(b,:)=allVSUnits(b,randperm(length(allVSUnits)));
% end
% allrandoff{nsam,:}=randoff;
% clearvars randoff
% [rpoff(nsam,:),~]=classifier_onoff(allrandoff{nsam,1},swpwinsize);
% end


%% plotting

VSlength=[VSlength(2) VSlength(1) VSlength(3)];

xt=1:1:(allVSepochs(end)-allVSepochs(1)+1);
f1=figure(1); 
for n=1:length(allVSepochs)
    
    w1_(n)= ~isempty(find(w1==allVSepochs(n), 1));
    nr2_(n)= ~isempty(find(nr2==allVSepochs(n), 1));
    r3_(n)= ~isempty(find(r3==allVSepochs(n), 1));
    w_(n)= ~isempty(find(w==allVSepochs(n), 1));
    nr_(n)= ~isempty(find(nr==allVSepochs(n), 1));
    r_(n)= ~isempty(find(r==allVSepochs(n), 1));
    
end

%SWA % units of spectra
for n=1:size(allVSspectra,2)
   SWA(n)=mean(allVSspectra(3:16,n));
end
SWA(w1_)=0;SWA(nr2_)=0;SWA(r3_)=0;
artSWA=zeros(1,length(xt));artSWA(allVSepochs-allVSepochs(1)+1)=SWA;

subplot('position',[0.18 1-0.25 0.693 0.2]);
bar(xt,artSWA,0.5);
axis([0.5 (allVSepochs(end)-allVSepochs(1)+1)+0.5 0 max(SWA)]); 
xlabel('epochs ','Fontsize',20);
title('Slow Wave Activity','Fontsize',20)
ylabel('SWA /\muV^2','Fontsize',20)

% Hypnogram
artw_=zeros(1,length(xt));artw_(allVSepochs-allVSepochs(1)+1)=w_;
artnr_=zeros(1,length(xt));artnr_(allVSepochs-allVSepochs(1)+1)=nr_;
artr_=zeros(1,length(xt));artr_(allVSepochs-allVSepochs(1)+1)=r_;
for vs=1:3
    if vs==1 v=artw_; elseif vs==2 v=artnr_; else v=artr_; end;
    subplot('position',[0.18 1-0.4-0.03*(vs-1) 0.693 0.03]);
    bar(xt,v,1); axis([0.5 (allVSepochs(end)-allVSepochs(1)+1)+0.5 0 1]);ylabel('NR','FontAngle','oblique','Fontsize',16);
    if vs==1 title(['Hypnogram'],'Fontsize',20);ylabel('W','FontAngle','oblique','Fontsize',16); 
    end;
    set(gca, 'YTick', []); set(gca, 'XTick', []);
    if vs==3  xlabel('epochs','Fontsize',20);ylabel('R','FontAngle','oblique','Fontsize',16);
    end;
end;
orient tall

% Firing Rates

FR=sum(reshape(sum(allVSUnits,1),500,length(sum(allVSUnits,1))/500))/(size(allVSUnits,1));
w1_s=reshape(repmat(w1_,4,1),1,length(w1_)*4);FR(w1_s)=0;
nr2_s=reshape(repmat(nr2_,4,1),1,length(nr2_)*4);FR(nr2_s)=0;
r3_s=reshape(repmat(r3_,4,1),1,length(r3_)*4);FR(r3_s)=0;

artFR=zeros(1,(allVSepochs(end)-allVSepochs(1)+1)*4);
artFR_=(allVSepochs-allVSepochs(1)+1)*4-3;
artFR_=[artFR_ artFR_+1 artFR_+2 artFR_+3];
artFR_=sort(artFR_(:))';
artFR(artFR_)=FR;

subplot('position',[0.18 1-0.75 0.693 0.2]);
bar([1:1:(allVSepochs(end)-allVSepochs(1)+1)*4],artFR,0.5);
axis([0 (allVSepochs(end)-allVSepochs(1)+1)*4 0 max(FR)]); 

title('Firing Rate','Fontsize',20)
xlabel('Time(s)','Fontsize',20)
ylabel('Firing Rate / s / neuron','Fontsize',20)

off_periods(end)=0;
seq=find(off_periods==1);
sequ=diff(seq);
seque= sequ~=1;
offend=seq(seque);offend=[offend; seq(end)];offend(1)=[];
seq0=find(off_periods==0);
sequ0=diff(seq0);
seque0= sequ0~=1;
offstart=seq0(seque0)+1;
if offstart(2)<offend(1)
    offstart(1)=[];
elseif offstart(2)==offend(1)
    offstart(2)=[];
end
if swpwinsize==5
   offperiods=[offstart-2 offend+2];
elseif swpwinsize==9
    offperiods=[offstart-4 offend+4];
end
    offdur=offend-offstart;
tempoffdur=offdur>0;%minimum criteria of 2ms
offdur=offdur(tempoffdur)*2;

% for b=1:size(rpoff,1)
%     rpoff(b,end)=0;
%     bseq=find(rpoff(b,:)==1);
%     bsequ=diff(bseq);
%     bseque= bsequ~=1;
%     boffend{b,:}=bseq(bseque);boffend{b,1}=[boffend{b,1} bseq(end)];
%     clearvars bseq bsequ bseque
%     bseq0=find(rpoff(b,:)==0);
%     bsequ0=diff(bseq0);
%     bseque0= bsequ0~=1;
%     boffstart{b,:}=bseq0(bseque0)+1;
%     clearvars bseq0 bsequ0 bseque0
% 
%     if boffstart{b,1}(end)>boffend{b,1}(end)
%         boffstart{b,1}(1)=[];
%     elseif boffstart{b,1}(1)>boffend{b,1}(1)
%         boffend{b,1}(1)=[];
%     end
%     boffperiods{b,:}=[boffstart{b,:}' boffend{b,:}'];
%     boffdur{b,:}=boffend{b,:}-boffstart{b,:};
%     tempboffdur{b,:}=boffdur{b,:}>0;
%     boffdur{b,:}=boffdur{b,:}(tempboffdur{b,:});
% 
% end

f2=figure(2);
% allboffdur=[boffdur{:,:}]*2;
% [bf,bxi]=ksdensity(allboffdur,linspace(2,200,100));
[f,xi]=ksdensity(offdur,linspace(2,200,7921));
% bfq=interp1(bxi,bf,2:0.025:200);
% temp1=f-bfq;temp2=find(temp1>0);temp3=find(temp2>1121);temp4=temp3(1);temp4=temp2(temp4);
% threshold=2+0.025*temp4;
for n=1:7921
    if f(1:n)*xi(1:n)'>f*xi'*0.5 && f(1:n)*xi(1:n)'<f*xi'*0.505
        threshold=xi(n);
    end
end


newtempoffdur=offdur>threshold;
offduration=offdur(newtempoffdur);

hold on
% plot(bxi,bf,'b');
plot(xi,f,'g');
plot(threshold,f(find(abs(xi-threshold)==min(abs(xi-threshold)))),'r*');

hold off
title('surrogate vs real data on OFF periods duration pdf')
xlabel('duration /ms');
ylabel('probability')
legend('Real data','Threshold')

%off periods duration distribution
f3=figure(3);
artoffduration___=[];
artoffduration=zeros(1,(allVSepochs(end)-allVSepochs(1)+1)*2000);
artoffduration_=(allVSepochs-allVSepochs(1)+1)*2000-1999;

for n=0:1:1999
    
    artoffduration___=[artoffduration___ artoffduration_+n];
    
end
artoffduration___=sort(artoffduration___(:))';

artoffduration__=artoffduration___(offstart(tempoffdur));artoffduration__=artoffduration__(newtempoffdur);

artoffduration(artoffduration__)=offduration;

subplot('position',[0.18 1-0.3 0.693 0.2]);
hold on
bar(1:1:(ceil((allVSepochs(end)-allVSepochs(1)+1)/15)),[sum(reshape(artoffduration(1:end-rem(length(artoffduration),30000)),30000,(length(artoffduration)-rem(length(artoffduration),30000))/30000))...
    sum(artoffduration(end-rem(length(artoffduration),30000):end))]/1000)
% plot([find(hist(find(artw_==1),0.5:15:(allVSepochs(end)-allVSepochs(1)+1)+0.5)>7, 1 ) find(hist(find(artw_==1),0.5:15:(allVSepochs(end)-allVSepochs(1)+1)+0.5)>7, 1, 'last' )],...
...[max([sum(reshape(artoffduration(1:end-rem(length(artoffduration),30000)),30000,(length(artoffduration)-rem(length(artoffduration),30000))/30000)) sum(artoffduration(end-rem(length(artoffduration),30000):end))]/1000)...
    ...max([sum(reshape(artoffduration(1:end-rem(length(artoffduration),30000)),30000,(length(artoffduration)-rem(length(artoffduration),30000))/30000)) sum(artoffduration(end-rem(length(artoffduration),30000):end))]/1000)],'g','LineWidth',5)
hold off
title('average OFF periods durations per minute')
xlabel('time /min');
ylabel('total OFF periods duration /s')
axis([0 ceil((allVSepochs(end)-allVSepochs(1)+1)/15)+1 0 max([sum(reshape(artoffduration(1:end-rem(length(artoffduration),30000)),30000,(length(artoffduration)-rem(length(artoffduration),30000))/30000))...
    sum(artoffduration(end-rem(length(artoffduration),30000):end))]/1000)+5]);

%off periods incidences
offincidence=artoffduration>0;
offincidence=[sum(reshape(offincidence(1:end-rem(length(offincidence),30000)),30000,(length(offincidence)-rem(length(offincidence),30000))/30000)) sum(offincidence(end-rem(length(offincidence),30000):end))];
% offincidence(w1_s)=0; % unnecessary step, maybe useful in the future   
% offincidence(nr2_s)=0;
% offincidence(r3_s)=0;
subplot('position',[0.18 1-0.6 0.693 0.2]);
hold on
bar(1:1:(ceil((allVSepochs(end)-allVSepochs(1)+1)/15)),offincidence);
% plot([find(hist(find(artw_==1),0.5:15:(allVSepochs(end)-allVSepochs(1)+1)+0.5)>7, 1)...
%     find(hist(find(artw_==1),0.5:15:(allVSepochs(end)-allVSepochs(1)+1)+0.5)>7, 1, 'last')],...
%     [max(offincidence) max(offincidence)],'g','LineWidth',5)
hold off
axis([0 ceil((allVSepochs(end)-allVSepochs(1)+1)/15)+1 0 max(offincidence)+20]);

title('OFF periods incidences')
ylabel('OFF periods incidences /min')
xlabel('time /min')


offperiodsth=offperiods(tempoffdur,:);
offperiodsth=offperiodsth(newtempoffdur,:);

offmidpointsth=(offperiodsth(:,1)+offperiodsth(:,2))/2;
mean_offdurth=mean(offduration);
mean_offdurthbartemp=zeros(1,401);
mean_offdurthbartemp((201-round(mean_offdurth/2)):(201+round(mean_offdurth/2)))=ones(1,length(mean_offdurthbartemp((201-round(mean_offdurth/2)):(201+round(mean_offdurth/2)))));

sum_units=sum(allVSUnits,1);

for n=1:length(offmidpointsth)
    try
        offalignth(n,:)=sum_units(round(offmidpointsth(n)-100):round(offmidpointsth(n)+100));
    catch ME
        continue
    end
end
f4=figure(4);
hold on
area(0:2:400,sum(offalignth)/mean(sum(offalignth)),'FaceColor',[.5 .9 .6],'EdgeColor','g','LineWidth',0.3)
bar(mean_offdurthbartemp*2,1,'FaceColor','none','EdgeColor','b','LineWidth',0.1,'LineStyle',':')
hold off
title('detected OFF periods triggered average of MUA across NREM and Wake')
xlabel('timestamps / ms')
ylabel('average of MUA')
axis([0 400 0 3])
legend('Off periods triggered MUA','mean Off periods duration')

offmidpoints=(offperiods(:,1)+offperiods(:,2))/2;
mean_offdur=mean(offdur);
mean_offdurbartemp=zeros(1,401);
mean_offdurbartemp((201-round(mean_offdur/2)):(201+round(mean_offdur/2)))=ones(1,length(mean_offdurbartemp((201-round(mean_offdur/2)):(201+round(mean_offdur/2)))));



% for n=1:length(offmidpoints)
%     try
%         offalign(n,:)=sum_units(round(offmidpoints(n)-100):round(offmidpoints(n)+100));
%     catch ME
%         continue
%     end
% end
% f5=figure(5);
% hold on
% area(0:2:400,sum(offalign)/mean(sum(offalign)),'FaceColor',[.5 .9 .6],'EdgeColor','g','LineWidth',0.3)
% bar(mean_offdurbartemp*2,1,'FaceColor','none','EdgeColor','b','LineWidth',0.1,'LineStyle',':')
% hold off
% title('detected OFF periods triggered average of MUA across NREM and Wake Pre-Thresholding')
% xlabel('timestamps / ms')
% ylabel('average of MUA')
% axis([0 400 0 3])
% legend('Off periods triggered MUA','mean Off periods duration')


woffperiods=offperiods(:,1)>VSlength(1) & offperiods(:,1)<(VSlength(1)+VSlength(2));
woffperiods=offperiods(woffperiods,:);
nroffperiods=offperiods(:,1)<VSlength(1) | offperiods(:,1)>(VSlength(1)+VSlength(2));
nroffperiods=offperiods(nroffperiods,:);
woffmidpoints=(woffperiods(:,1)+woffperiods(:,2))/2;
nroffmidpoints=(nroffperiods(:,1)+nroffperiods(:,2))/2;

for n=1:length(woffmidpoints)
    try
        woffalign(n,:)=sum_units(round(woffmidpoints(n)-100):round(woffmidpoints(n)+100));
    catch ME
        continue
    end
end
for n=1:length(nroffmidpoints)
    try
        nroffalign(n,:)=sum_units(round(nroffmidpoints(n)-100):round(nroffmidpoints(n)+100));
    catch ME
        continue
    end
end

f6=figure(6);

hold on
area(0:2:400,sum(woffalign)/mean(sum(woffalign)),'FaceColor',[.5 .9 .6],'EdgeColor','g','LineWidth',0.3)
area(0:2:400,sum(nroffalign)/mean(sum(nroffalign)),'FaceColor',[.9 .5 .6],'EdgeColor','r','LineWidth',0.3)
hold off
title('detected OFF periods triggered average of MUA in NREM and in Wake Pre-thresholding')
xlabel('timestamps / ms')
ylabel('average of MUA')
axis([0 400 0 3])
legend('Waking','NREM')

%%% threshold after
woffperiodsth=offperiodsth(:,1)>VSlength(1) & offperiodsth(:,1)<(VSlength(1)+VSlength(2));
woffperiodsth=offperiodsth(woffperiodsth,:);
nroffperiodsth=offperiodsth(:,1)<VSlength(1) | offperiodsth(:,1)>(VSlength(1)+VSlength(2));
nroffperiodsth=offperiodsth(nroffperiodsth,:);
nroffperiodsth2=offperiodsth(:,1)<VSlength(1);
nroffperiodsth2=offperiodsth(nroffperiodsth2,:);
nroffperiodsth3=offperiodsth(:,1)>(VSlength(1)+VSlength(2));
nroffperiodsth3=offperiodsth(nroffperiodsth3,:);
woffmidpointsth=(woffperiodsth(:,1)+woffperiodsth(:,2))/2;
nroffmidpointsth=(nroffperiodsth(:,1)+nroffperiodsth(:,2))/2;

for n=1:length(woffmidpointsth)
    try
        woffalignth(n,:)=sum_units(round(woffmidpointsth(n)-100):round(woffmidpointsth(n)+100));
    catch ME
        continue
    end
end
for n=1:length(nroffmidpointsth)
    try
        nroffalignth(n,:)=sum_units(round(nroffmidpointsth(n)-100):round(nroffmidpointsth(n)+100));
    catch ME
        continue
    end
end

f7=figure(7);

hold on
area(0:2:400,sum(woffalignth)/mean(sum(woffalignth)),'FaceColor',[.5 .9 .6],'EdgeColor','g','LineWidth',0.3)
area(0:2:400,sum(nroffalignth)/mean(sum(nroffalignth)),'FaceColor',[.9 .5 .6],'EdgeColor','r','LineWidth',0.3)
hold off
title('detected OFF periods triggered average of MUA in NREM and in Wake')
xlabel('timestamps / ms')
ylabel('average of MUA')
axis([0 400 0 3])
legend('Waking','NREM')

% Distribution of OFF periods duration

f8=figure(8);
woffperiodsdurth=(woffperiodsth(:,2)-woffperiodsth(:,1))*2;
nroffperiodsdurth=(nroffperiodsth(:,2)-nroffperiodsth(:,1))*2;
subplot(2,2,1),hist(woffperiodsdurth,[1:2:600]);set(gca,'XScale','log');
title('histogram of durations of OFF periods during Waking')
xlabel('duration of OFF periods / ms')
ylabel('frequency of occurrence')
subplot(2,2,2),hist(nroffperiodsdurth,[1:2:600]);set(gca,'XScale','log');
title('histogram of durations of OFF periods during NREM')
xlabel('duration of OFF periods / ms')
ylabel('frequency of occurrence')
nroffperiodsdurth2=(nroffperiodsth2(:,2)-nroffperiodsth2(:,1))*2;
nroffperiodsdurth3=(nroffperiodsth3(:,2)-nroffperiodsth3(:,1))*2;
subplot(2,2,3),
hold on
bar([1 2 3],[mean(woffperiodsdurth) mean(nroffperiodsdurth2) mean(nroffperiodsdurth3)])
errorbar([1 2 3],[mean(woffperiodsdurth) mean(nroffperiodsdurth2) mean(nroffperiodsdurth3)],...
    [std(woffperiodsdurth)/sqrt(length(woffperiodsdurth)) std(nroffperiodsdurth2)/sqrt(length(nroffperiodsdurth2)) std(nroffperiodsdurth3)/sqrt(length(nroffperiodsdurth3))],'r+')
hold off
title('Average Off periods duration per state')
xlabel('Waking NREM-pre NREM-post')
ylabel('duration /ms')
subplot(2,2,4),
hold on
bar([1 2 3],[sum(offincidence(round(VSlength(1)*2/1000/60):round((VSlength(1)+VSlength(2))/500/60)))/...
    length(offincidence(round(VSlength(1)*2/1000/60):round((VSlength(1)+VSlength(2))/500/60))) ...
    sum(offincidence(1:round(VSlength(1)*2/1000/60)))/length(offincidence(1:round(VSlength(1)*2/1000/60)))...
    sum(offincidence(round((VSlength(1)+VSlength(2))/500/60):end))/length(offincidence(round((VSlength(1)+VSlength(2))/500/60):end))])
hold off
title('Average Off incidence per state per minute')
xlabel('Waking NREM-pre NREM-post')
% ylabel('arbitury unit')

saveas(f1,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure1.fig']);
saveas(f2,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure2.fig']);
saveas(f3,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure3.fig']);
saveas(f4,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure4.fig']);
% saveas(f5,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure5.fig']);
saveas(f6,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure6.fig']);
saveas(f7,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure7.fig']);
saveas(f8,['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\figure8.fig']);

save(['D:\Dropbox\SfN2013\rw' num2str(ratnumber) '-BSL' num2str(baseline) '\episode' num2str(episode) '\winsize' num2str(swpwinsize) '\matlab.mat'])
clearvars Channels FR LFP ME Ncats NeuronsCh Ntypes SWA Units VS VSlength allVSUnits allVSepochs allVSspectra artFR artFR_ artSWA artnr_ artoffduration artoffduration_...
    artoffduration__ artoffduration___ artr_ artw_ baseline epidur epochs f f1 f2 f3 f4 f5 f6 f7 f8 mean_offdur mean_offdurbartemp mean_offdurth mean_offdurthbartemp n ...
    newtempoffdur nr nr2 nr2_ nr2_s nr_ nroffalign nroffalignth nroffmidpoints nroffmidpointsth nroffperiods nroffperiodsdurth nroffperiodsdurth2 nroffperiodsdurth3 ...
    nroffperiodsth nroffperiodsth2 nroffperiodsth3 off_periods offalign offalignth offdur offduration offend offincidence offmidpoints offmidpointsth offperiods offperiodsth ...
    offstart path r r3 r3_ r3_s r_ ratnumber seq seq0 sequ sequ0 seque seque0 signal spectra startend sum_units sum_windowsweep swpwinsize tempoffdur threshold v vs w w1 w1_ w1_s w_ ...
    wavesLFPn wavesLFPp woffalign woffalignth woffmidpoints woffmidpointsth woffperiods woffperiodsdurth woffperiodsth xi xt;
close all;
end
end
