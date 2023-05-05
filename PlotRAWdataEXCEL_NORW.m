clear all;
close all;


recorddate='310714'; % change day month year
Lon='09:00:00' % always 9

% recstart='13:41:33' % dont need anymore
tank='Batch6';
%block=['Al_Wa_St_',recorddate];% change
block=['Sh_Ch_Fr_',recorddate];

pathSIG='L:\VVyazovskiy\Collaborators\';
pathRW='L:\VVyazovskiy\Collaborators\RW\';

pathfig='L:\VVyazovskiy\Collaborators\FinalPlots28JUL\'; mkdir(pathfig)

for mouseid=3
    if mouseid==1
        %mousename='Alan';
        mousename='Sherlock';
        eeg='EEG1';
        numch=2;
        emg='EMG1';
       % rw='WHE1';
        
    elseif mouseid==2
        %mousename='Watson';
        mousename='Charles';
        eeg='EEG2';
        numch=2;
        emg='EMG2';
        %rw='WHE2';
        
    elseif mouseid==3
        %mousename='Steve';
        mousename='Freud';
        eeg='EEG3';
        numch=2;
        emg='EMG3';
       % rw='WHE3';
    end
% mousename='Claude';
% eeg='EEG4';
% numch=2;
% emg='EMG4'
% rw='WHE4'

%read title, notes, additional information from excel
[num,txt,raw] = xlsread('L:\VVyazovskiy\Collaborators\MouseExperimentalData\15Jul14_MouseDataCollectionOutline.xlsx',mousename,'a17:l65')
index = strcmp(txt(1:end,2),recorddate);
recstart2 = raw(index,4);
recstart = [recstart2{:}]
durationfromexcel = raw(index,5);
titlefromexcel = raw(index,10);
notesfromexcel = raw(index,11);
addinfofromexcel = raw(index,12);

% read implant date from excel
[num2,txt2,raw2] = xlsread('L:\VVyazovskiy\Collaborators\MouseExperimentalData\15Jul14_MouseDataCollectionOutline.xlsx',mousename,'a4:b15')
index2 = strcmp(txt2(1:end,1),'Date of surgery:');
implantdatefromexcel = raw2(index2,2);

channames=strvcat('fro','occ','emg')

% no checking required here
otherinfo=['Implanted: ' implantdatefromexcel{:} '; ' eeg ': frontal (ch1), occipital (ch2); ' emg]% ', RW-activity: ' rw]
notes=notesfromexcel
% notes=[sprintf('17.55 (PC) \n(4hours 13 minTDT rec) - disconnected TDT. 17.58pm (PC) -  reconnected TDT. Note: two chambers now able to record events simulataneously so two mice ran at same time.')]

% check scaling
ay1=[0 18000]; % scaling for EEG frontal
ay2=[0 18000]; % scaling for EEG occipital
ay3=[0 12000]; % scaling for EMG

%
ep24=21600;
fs=256;
epochl=4;

% no checking required here
titlestr=[titlefromexcel{:} ' EEG/EMG recording, mouse ID: ',mousename,', tank: ',tank, ', date: ',recorddate,', start: ',recstart2{:},', duration: ', durationfromexcel{:}];
notchfilter=50;Qfactor=100;Wo = notchfilter/(fs/2); BW = Wo/Qfactor; [b,a] = iirnotch(Wo,BW); % notch filter


% calculate file start relative to L on (do not need to change anything here)
sec1=str2num(Lon(1:2))*3600+str2num(Lon(4:5))*60+str2num(Lon(7:8))
sec2=str2num(recstart(1:2))*3600+str2num(recstart(4:5))*60+str2num(recstart(7:8))
delay=sec2-sec1;

% EEG variance (total power)
for chan=1:numch
    fnout=[tank,'-',mousename,'-',recorddate,'-',channames(chan,:)];
    
    eval(['load ',pathSIG,fnout,'.mat -mat']);
    
    sig=resampled_sig; clear resampled_sig;
    
    if delay>=0
        sig(1:delay*fs)=NaN;
    else
        sig(1:abs(delay*fs))=[];
    end
    
    le=length(sig);out=rem(le,(fs*epochl)); sig(le-out+1:end)=[];
    maxep=length(sig)/(fs*epochl);
    
    if maxep>ep24
        sig=sig(1:epochl*fs*ep24);
    else
        fillep=zeros(1,(ep24-maxep)*epochl*fs); fillep(fillep==0)=NaN; sig=[sig fillep];
    end
    
    EEG=reshape(sig,fs*epochl,ep24);
    
    if chan==1 EEG1=var(EEG); else EEG2=var(EEG); end
    
end
x1=1:1:length(EEG1); x1=x1/900;

% EMG variance

fnout=[tank,'-',mousename,'-',recorddate,'-',channames(3,:)];
eval(['load ',pathSIG,fnout,'.mat -mat']);

sig=resampled_sig; clear resampled_sig;
sig=filtfilt(b,a,sig);


if delay>=0 sig(1:delay*fs)=NaN; else sig(1:abs(delay*fs))=[]; end
le=length(sig);out=rem(le,(fs*epochl)); sig(le-out+1:end)=[]; maxep=length(sig)/(fs*epochl);

if maxep>ep24 sig=sig(1:epochl*fs*ep24);
else fillep=zeros(1,(ep24-maxep)*epochl*fs); fillep(fillep==0)=NaN; sig=[sig fillep];
end

maxep=length(sig)/(fs*epochl)
EMG=var(reshape(sig,fs*epochl,maxep));

% RW-activity
% fnout=[tank,'-',mousename,'-',recorddate,'-',rw];
% eval(['load ',pathRW,fnout,'.mat TimeRanges rw r  -mat']); % RW data
% rw=TimeRanges(2,:); rw(rw<delay)=[]; rw=rw/(60*60);rw=rw(rw>0); r=ones(1,length(rw));

myFig = figure; set(myFig, 'Position',[100 75 1400 900]);

xx=[0 1]; yy=[0 1];                       % LD bar
subplot('position',[0.08 0.9 0.9 0.02]); bar(xx,yy,1,'k');  axis([0 1 0 1]);  set(gca, 'XTick', [-0.1:2.2:2.1]); set(gca, 'YTick', [-0.1:1.2:1.1]);
title(titlestr)

subplot('position',[0.08 0.72 0.9 0.15]);
bar(x1,EEG1,'r')
axis([0 24 ay1])
set(gca,'XTick',[0:2:24])
ylabel('EEG frontal (var, uV)')

subplot('position',[0.08 0.52 0.9 0.15]);
bar(x1,EEG2,'b')
axis([0 24 ay2])
set(gca,'XTick',[0:2:24])
ylabel('EEG occipital (var, uV)')

subplot('position',[0.08 0.35 0.9 0.12]);
bar(x1,EMG,'k')
axis([0 24 ay3])
set(gca,'XTick',[0:2:24])
ylabel('EMG (var, uV)')

% subplot('position',[0.08 0.2 0.9 0.1]);
% bar(rw,r,'m')
% axis([0 24 0 1])
% set(gca,'XTick',[0:2:24])
% ylabel('RW-activity')
% xlabel('Hours')

text(0,-0.7,otherinfo)
text(0,-1.2,notes)

orient landscape
saveas(gcf,[pathfig,mousename,'-',recorddate],'pdf')
%close all
end

