%% Spectral Analysis

clear all;
close all;
clc;

Exp = 'ReachingExp1-';
block = 'block15-';
ch = 'ch10-';
Type = 'EEG_cFFT';
FileExtension = '.txt';
W=[];
NR=[];
R=[];
M=[];
W1=[];
R1=[];
N1=[];
w=zeros(1,21503);nr=w;r=w;m=w;w1=w;r1=w;n1=w;

block15=importdata([Exp block ch Type FileExtension]);

for n=20:21522
    if block15.textdata{n,2}=='W'
        W=[W, (n-20)]; w(n-19)=1;
    elseif block15.textdata{n,2}=='NR'
        NR=[NR, (n-20)]; nr(n-19)=1;
    elseif block15.textdata{n,2}=='R'
        R=[R, (n-20)]; r(n-19)=1;
    elseif block15.textdata{n,2}=='M'
        M=[M, (n-20)]; m(n-19)=1;
    elseif block15.textdata{n,2}=='W1'
        W1=[W1, (n-20)]; w1(n-19)=1;
    elseif block15.textdata{n,2}=='R1'
        R1=[R1, (n-20)]; r1(n-19)=1;
    elseif block15.textdata{n,2}=='N1'
        N1=[N1, (n-20)]; n1(n-19)=1;
    end
    hourvalue(n-19)=str2double(block15.textdata{n,3}(12:13));
end

%calculating average spectrum for each vigilance state

spectW=block15.data(W+1,:);
ave_specW=mean(spectW);

spectW1=block15.data(W1+1,:);
ave_specW1=mean(spectW1);

spectNR=block15.data(NR+1,:);
ave_specNR=mean(spectNR);

spectN1=block15.data(N1+1,:);
ave_specN1=mean(spectN1);

spectR=block15.data(R+1,:);
ave_specR=mean(spectR);

spectR1=block15.data(R1+1,:);
ave_specR1=mean(spectR1);

spectM=block15.data(M+1,:);
ave_specM=mean(spectM);

%plot average spectrum for each VS
xaxis=[0:0.25:20];
figure(1)
bar(xaxis,ave_specW);
title('Waking')
figure (2)
bar(xaxis,ave_specW1);
title('Waking Artifect')
figure (3)
bar(xaxis,ave_specNR);
title('NREM')
figure (4)
bar(xaxis,ave_specN1);
title('NREM Artifect')
figure (5)
bar(xaxis,ave_specR);
title('REM')
figure (6)
bar(xaxis,ave_specR1);
title('REM Artifect')
figure (7)
bar(xaxis,ave_specM);
title('Movement')

%% Episode detection
%conditions: SWA(0.5-4Hz) for NREM, theta(6-9Hz) for REM

%episode detection for NREM (one-hour episode). condition: more than 5mins
%of NREM in 60-min interval
NRepok=zeros(1,21600);NRepok(nr==1)=1;
NR1h=sum(reshape(NRepok,900,24));


% computing NREM sleep episodes

NRepoch=[NR 21522];
NRdif=diff(NRepoch);
NRdif1=find(NRdif>4+1); NRendvs=NRepoch(NRdif1);

NRstartvs=NRepoch(NRdif1+1);
NRstartvs=[NRepoch(1) NRstartvs]; NRstartvs(end)=[];

NRnepivs=NRendvs-NRstartvs;
NRnepi1vs=find(NRnepivs>75);    % episodes longer than interruption
NRepidurvs=NRnepivs(NRnepi1vs); %episode durations
NRstartep=NRstartvs(NRnepi1vs); %start epoch of each episodes
NRnumvs=length(NRstartep);      %number of episodes
NRendep=NRendvs(NRnepi1vs);
NRstartend=[NRstartep' NRendep']
NRepidur=NRendep-NRstartep;

allepoch=1:21503;
figure(8)
SWA=mean(block15.data(:,3:17),2);
SWA(nr==0)=NaN;
SWA(w1==1)=NaN;

subplot('position',[0.13 1-0.25 0.693 0.2]);
bar(allepoch./900,SWA);
set(gca,'XTick', [0:4:24]);
ylabel('EEG Power/ \muV^2')
title('Timecourse of SWA in NREM in 24-hour period')
axis([0 allepoch(end)./900 0 0.01])


% vigilance states
xt=0:24/21600:(21503*(24/21600));xt(end)=[];
for vs=1:3
    if vs==1 v=w; elseif vs==2 v=nr; else v=r; end;
    subplot('position',[0.13 1-0.3-0.011*(vs-1) 0.693 0.011]);
    bar(xt,v,0.1); axis ([0 24 0 1]);
    %if vs==1 title(['rw0',num2str(rats(rat))]); end;
    set(gca, 'YTick', []); set(gca, 'XTick', []);
    if vs==3 set(gca, 'XTick', [0:4:24]); xlabel('Hours');
    end;
end;
orient tall

dayornight=hourvalue>22 | hourvalue<10;
subplot('position',[0.13 1-0.4 0.693 0.011]);
bar(xt,dayornight,0.1,'k');axis([0 24 0 1]);

%episode detection for REM (one-hour episode). condition: more than 3mins
%of REM in 60-min interval
Repok=zeros(1,21600);Repok(r==1)=1;
R1h=sum(reshape(Repok,900,24));


% computing REM sleep episodes

Repoch=[R 21522];
Rdif=diff(Repoch);
Rdif1=find(Rdif>4+1); Rendvs=Repoch(Rdif1);

Rstartvs=Repoch(Rdif1+1);
Rstartvs=[Repoch(1) Rstartvs]; Rstartvs(end)=[];

Rnepivs=Rendvs-Rstartvs;
Rnepi1vs=find(Rnepivs>45);    % episodes longer than interruption
Repidurvs=Rnepivs(Rnepi1vs); %episode durations
Rstartep=Rstartvs(Rnepi1vs); %start epoch of each episodes
Rnumvs=length(Rstartep);      %number of episodes
Rendep=Rendvs(Rnepi1vs);
Rstartend=[Rstartep' Rendep']
Repidur=Rendep-Rstartep;

figure(9)
theta=mean(block15.data(:,25:37),2);
theta(r==0)=NaN;

subplot('position',[0.13 1-0.25 0.693 0.2]);
bar(allepoch./900,theta);
set(gca,'XTick', [0:4:24]);
ylabel('EEG Power/ \muV^2')
title('Timecourse of theta activity in REM in 24-hour period')
axis([0 allepoch(end)./900 0 0.01])


% vigilance states

for vs=1:3
    if vs==1 v=w; elseif vs==2 v=nr; else v=r; end;
    subplot('position',[0.13 1-0.3-0.011*(vs-1) 0.693 0.011]);
    bar(xt,v,0.1); axis ([0 24 0 1]);
    %if vs==1 title(['rw0',num2str(rats(rat))]); end;
    set(gca, 'YTick', []); set(gca, 'XTick', []);
    if vs==3 set(gca, 'XTick', [0:4:24]); xlabel('Hours');
    end;
end;
orient tall

dayornight=hourvalue>22 | hourvalue<10;
subplot('position',[0.13 1-0.4 0.693 0.011]);
bar(xt,dayornight,0.1,'k');axis([0 24 0 1]);


%% NREM to REM transition

NRnepi1vs_nc=find(NRnepivs>45);    % episodes longer than interruption
NRepidurvs_nc=NRnepivs(NRnepi1vs_nc); %episode durations
NRstartep_nc=NRstartvs(NRnepi1vs_nc); %start epoch of each episodes
NRnumvs_nc=length(NRstartep_nc);      %number of episodes
NRendep_nc=NRendvs(NRnepi1vs_nc);
NRstartend_nc=[NRstartep_nc' NRendep_nc']
NRepidur_nc=NRendep_nc-NRstartep_nc;

Rdif1_nc=find(Rdif>1);
Rendvs_nc=Repoch(Rdif1_nc);

Rstartvs_nc=Repoch(Rdif1_nc+1);
Rstartvs_nc=[Repoch(1) Rstartvs_nc]; Rstartvs_nc(end)=[];

Rnepivs_nc=Rendvs_nc-Rstartvs_nc;
Rnepi1vs_nc=find(Rnepivs_nc>15);    % episodes longer than interruption
Repidurvs_nc=Rnepivs_nc(Rnepi1vs_nc); %episode durations
Rstartep_nc=Rstartvs_nc(Rnepi1vs_nc); %start epoch of each episodes
Rnumvs_nc=length(Rstartep_nc);      %number of episodes
Rendep_nc=Rendvs_nc(Rnepi1vs_nc);
Rstartend_nc=[Rstartep_nc' Rendep_nc']
Repidur_nc=Rendep_nc-Rstartep_nc;


for kr=1:Rnumvs_nc
    
    preceedvsr(:,kr)=block15.textdata(((Rstartep_nc(kr)-15):(Rstartep_nc(kr)-1))+20,2);
    
    for knr=1:15
        
        vscomparer(knr,kr)=isequal(preceedvsr{knr,kr},'NR');
        
    end
    
end

Rstart_tran=Rstartep_nc((sum(vscomparer,1)>10) & (vscomparer(15,:)==1)); %transition is the first epoch of REM episodes
ColormapValue=colormap(jet(128));

for tr=1:length(Rstart_tran)
    
    HMO=HeatMap(log(block15.data(((Rstart_tran(tr)-15):(Rstart_tran(tr)+14)),:)'),'Colormap',ColormapValue,'Symmetric','false');
    
    addXLabel(HMO,'Time (Seconds)','FontSize',12)
    addYLabel(HMO,'log EEG power (\muV^2 / 0.25 Hz)','FontSize',12)
    addTitle(HMO,'NREM to REM Transitions')
    all_power_R(:,:,tr)=block15.data(((Rstart_tran(tr)-15):(Rstart_tran(tr)+14)),:)';
    
end

mean_R_trans=mean(all_power_R,3);
HMO=HeatMap(log(mean_R_trans),'Colormap',ColormapValue,'Symmetric','false');

addXLabel(HMO,'Time (Seconds)','FontSize',12)
addYLabel(HMO,'log EEG power (\muV^2 / 0.25 Hz)','FontSize',12)
addTitle(HMO,'Average of All NREM-REM Transitions')

%% NREM to Waking Transition

Waking =sort([W W1]);

%Waking criteria : minimum 15-epoch long episodes (including W1)
Wakingepoch=[Waking 21522];
Wakingdif=diff(Wakingepoch);
Wakingdif1_nc=find(Wakingdif>1);
Wakingendvs_nc=Wakingepoch(Wakingdif1_nc);

Wakingstartvs_nc=Wakingepoch(Wakingdif1_nc+1);
Wakingstartvs_nc=[Wakingepoch(1) Wakingstartvs_nc]; Wakingstartvs_nc(end)=[];

Wakingnepivs_nc=Wakingendvs_nc-Wakingstartvs_nc;
Wakingnepi1vs_nc=find(Wakingnepivs_nc>15);
Wakingepidurvs_nc=Wakingnepivs_nc(Wakingnepi1vs_nc);
Wakingstartep_nc=Wakingstartvs_nc(Wakingnepi1vs_nc);
Wakingnumvs_nc=length(Wakingstartep_nc);
Wakingendep_nc=Wakingendvs_nc(Wakingnepi1vs_nc);
Wakingstartend_nc=[Wakingstartep_nc' Wakingendep_nc']
Wakingepidur_nc=Wakingendep_nc-Wakingstartep_nc;

%NREM criteria : more than 10/15 epochs, cannot contain REM epoch
for wk=2:Wakingnumvs_nc
    
    preceedvsw(:,wk-1)=block15.textdata(((Wakingstartep_nc(wk)-15):(Wakingstartep_nc(wk)-1))+20,2);
    
    for wkn=1:15
        
        vscomparew(wkn,wk-1)=isequal(preceedvsw{wkn,wk-1},'NR');
        vscomparewr(wkn,wk-1)=isequal(preceedvsw{wkn,wk-1},'R');
        
    end
    
end
Wakingstart_tran=Wakingstartep_nc;
Wakingstart_tran(1)=[];
Wakingstart_tran=Wakingstart_tran((sum(vscomparew,1)>10) & (vscomparew(15,:)==1) & (sum(vscomparewr,1)==0));
%transition is the first epoch of W episodes

ColormapValue=colormap(jet(128));

for wt=1:length(Wakingstart_tran)
    
    HMO=HeatMap(log(block15.data(((Wakingstart_tran(wt)-15):(Wakingstart_tran(wt)+14)),:)'),'Colormap',ColormapValue,'Symmetric','false');
    
    addXLabel(HMO,'Time (Seconds)','FontSize',12)
    addYLabel(HMO,'log EEG power (\muV^2 / 0.25 Hz)','FontSize',12)
    addTitle(HMO,'NREM to Waking Transitions')
    all_power_W(:,:,wt)=block15.data(((Wakingstart_tran(wt)-15):(Wakingstart_tran(wt)+14)),:)';
    all_vs_W(:,wt)=block15.textdata(((Wakingstart_tran(wt)-15):(Wakingstart_tran(wt)+14))+20,2);

end

for ww2=1:size(all_vs_W,2)
    
    for ww1=1:size(all_vs_W,1)
        
        vscomparew1(ww1,ww2)=isequal(all_vs_W{ww1,ww2},'W1');
        
    end
end

[vscrow vsccol]=find(vscomparew1==1);

for w1ind=1:length(vscrow)
    all_power_W(:,vscrow(w1ind),vsccol(w1ind))=0;
end

mean_W_trans=mean(all_power_W,3);%mean should not include W1

HMO=HeatMap(log(mean_W_trans),'Colormap',ColormapValue,'Symmetric','false');

addXLabel(HMO,'Time (Seconds)','FontSize',12)
addYLabel(HMO,'log EEG power (\muV^2 / 0.25 Hz)','FontSize',12)
addTitle(HMO,'Average of All NREM-Waking Transitions')

%% SWA Inertia

for rt1=1:length(Rstart_tran)
    
   inertianr(rt1,:) = [nanmean(SWA((Rstart_tran(rt1)-15):(Rstart_tran(rt1)-1))) nanmean(SWA((Rstart_tran(rt1)):(Rstart_tran(rt1)+14)))];
   
end

srtinertnr=sortrows(inertianr);
swa1=median(reshape(srtinertnr(1:end,1),7,5))
swa2=median(reshape(srtinertnr(1:end,2),7,5))



figure
bar(srtinertnr([1 round(length(srtinertnr)/4) round(length(srtinertnr)/2) round(length(srtinertnr)*3/4) end],:))

xlabel('Min, Quantiles, Max')
ylabel('mean SWAs of corresponding transitions')
title('Sleep inertia in NREM to REM Transitions')

for wt1=1:length(Wakingstart_tran)
    
   inertianw(wt1,:) = [nanmean(SWA((Wakingstart_tran(wt1)-15):(Wakingstart_tran(wt1)-1))) nanmean(SWA((Wakingstart_tran(wt1)):(Wakingstart_tran(wt1)+14)))];
   
end

swa1w=median(reshape(srtinertnw(1:end,1),9,3))
swa2w=median(reshape(srtinertnw(1:end,2),9,3))

srtinertnw=sortrows(inertianw);
figure
bar(srtinertnw([1 round(length(srtinertnw)/4) round(length(srtinertnw)/2) round(length(srtinertnw)*3/4) end],:))

xlabel('Min, Quantiles, Max')
ylabel('mean SWAs of corresponding transitions')
title('Sleep inertia in NREM to Waking Transitions')











