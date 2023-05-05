close all
clear all

pathin='D:\';
pathout='D:\OutputVDTtrials\';
pathfig='D:\OutputVDTFigures\';

maxret = 1000000;

% recorddates=strvcat('160714','150714','160714','150714','220814','220814','220814'); %day month year
% mousenames=strvcat('Alan','Watson','Watson','Steve','Sherlock','Charles','Freud');

recorddates=strvcat('271114_L1'); %day month year
mousenames=strvcat('Fe','Ar','Ex','Bu');

evSig=[1 2 3 4];%Anm?
evVDT=[3 4 1 2];%Which VDT chamber

tankName='November2014';

numanim=4;

wind1=4;
wind2=12;
fs=256;
x=-wind1*fs+1:wind2*fs;
x=x/fs;
cols='rmb';

p1=0.5; p2=100; s1=0.1; s2=120;Wp=[p1 p2]/(fs/2); Ws=[s1 s2]/(fs/2); Rp=3; Rs=20; [n, Wn]=cheb2ord(Wp,Ws,Rp,Rs);[bb1,aa1]=cheby2(n,Rs,Wn);
notchfilter=50;Qfactor=100;Wo = notchfilter/(fs/2); BW = Wo/Qfactor; [bb2,aa2] = iirnotch(Wo,BW);

extVDTstarttime=14400;%in sec
extVDTduration=14400;
extVDTendtime=extVDTstarttime+extVDTduration;

for mouse=1:numanim
    
    mousename=mousenames(mouse,:); mousename(isspace(mousename))=[];
    
    %block=['Sh_Ch_Fr_',recorddates(mouse,:)];
    block=['Fe_Ar_Ex_Bu_',recorddates];
    
    event = ['INI',num2str(evVDT(mouse))];
    TTX = actxcontrol('TTank.X');
    % Then connect to a server.
    invoke(TTX,'ConnectServer', 'Local', 'Me');
    
    tank=tankName;
    
    % Now open a tank for reading.
    invoke(TTX,'OpenTank', [pathin tankName], 'R');
    
    % Select the block to access
    invoke(TTX,'SelectBlock', block);
    %pause
    TTX.CreateEpocIndexing;
    TimeRanges=TTX.GetEpocsV(event,extVDTstarttime,extVDTendtime,maxret);
    vdt=TimeRanges(2,:); numtr=length(vdt);
    
    EEGf=zeros(numtr,length(x));
    EEGo=zeros(numtr,length(x));
    EMG=zeros(numtr,length(x));
    VDTtr=[]; INI=[];
    
    for st=1:numtr
        
        t1=vdt(st)-wind1; t2=vdt(st)+wind2;
        invoke(TTX, 'SetGlobalV', 'T1', t1);
        invoke(TTX, 'SetGlobalV', 'T2', t2);
        
        VDT=[];
        TTX.CreateEpocIndexing;
        for ev=1:3
            if ev==1 event=['INI',num2str(evVDT(mouse))]; elseif ev==2 event=['COR',num2str(evVDT(mouse))]; elseif ev==3 event=['INC',num2str(evVDT(mouse))]; end
            TimeRanges=TTX.GetEpocsV(event,t1+wind1-1,t2,maxret);
            if isnan(TimeRanges)==1 VDT=[VDT 0]; else VDT=[VDT TimeRanges(2,1)]; end
        end
        
        VDTtr=[VDTtr;VDT]; INI=[INI;t1];
        
        vv=find(VDT);
        %CH=[1 2 4]
        
        for chan=1:3
            %chan=CH(chh)
            invoke(TTX, 'SetGlobalV', 'Channel', chan);
            % read EEG frontal
            L2 = invoke(TTX, 'ReadEventsV', maxret, ['Anm',num2str(evSig(mouse))], chan, 0, t1, t2, 'ALL');
            sig = invoke(TTX,'ReadWavesV',['Anm',num2str(evSig(mouse))]); sig=resample(double(sig),256,257)*10^6;
            if chan<3 sig=filtfilt(bb1,aa1,sig);end; sig=filtfilt(bb2,aa2,sig);
            if chan==1 f=sig; EEGf(st,:)=f'; elseif chan==2 o=sig; EEGo(st,:)=o'; else e=sig; EMG(st,:)=e'; end
        end
        
        myFig = figure; set(myFig, 'Position',[100 200 1000 900]);
        
        subplot(3,1,1)
        plot(x,f,'-r');
        hold on
        axis([-wind1 wind2 -500 500])
        grid on
        ylabel('EEG frontal (uV)')
        title([mousename,', ',recorddates, ', Trial: ',num2str(st),', second: ',num2str(t1), ', epoch: ',num2str(ceil(t1/4))])
        
        subplot(3,1,2)
        plot(x,o,'-b');
        hold on
        plot([0 0],[-1000 1000],'-k','LineWidth',4)
        axis([-wind1 wind2 -500 500])
        grid on
        ylabel('EEG occipital (uV)')
        
        subplot(3,1,3)
        plot(x,e,'-k');
        hold on
        plot([0 0],[-1000 1000],'-k','LineWidth',2)
        axis([-wind1 wind2 -500 500])
        grid on
        xlabel('Time [seconds]')
        ylabel('EMG (uV)')
        
        for p=1:3
            subplot(3,1,p); for v=1:length(vv) pv=VDT(vv(v))-t1-wind1; plot([pv pv],[-1000 1000],['-',cols(vv(v))],'LineWidth',4); end
        end
        
        figname=[pathfig,mousename,'-',recorddates, '-Trial',num2str(st)];
        saveas(gcf,figname,'tiff')
        
        close (myFig)
        fnout=[mousename,'-',recorddates, '-Trial',num2str(st)];
        eval(['save ',pathout,fnout,'.mat event x f o e t1 VDT -mat']); % save VDT data ind
        
        %pause
        
    end
   
    fnout1=[mousename,'-',recorddates, '-VDTtrials'];
    eval(['save ',pathout,fnout1,'.mat event x EEGf EEGo EMG INI VDTtr -mat']); % save VDT data all
    
    invoke(TTX,'CloseTank');
end

