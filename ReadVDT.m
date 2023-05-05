close all
clear all

pathin='I:\mice\rawdata\';
pathout='I:\ExtendedVDT\VDT\'; mkdir(pathout)

maxret = 1000000;
recorddate='150714';%day month year
tankName='Batch6';
%block=['Sh_Ch_Fr_',recorddate];
block=['Al_Wa_St_',recorddate];

mousename='Steve';
numanim=1;
numch=3;

for ev=1:3
    
    if ev == 1
        event = 'INI2';
    elseif ev == 2
        event = 'COR2';
    elseif ev == 3
        event = 'INC2';
    end
    TTX = actxcontrol('TTank.X');
    % Then connect to a server.
    invoke(TTX,'ConnectServer', 'Local', 'Me');
    
    tank=tankName;
    
    % Now open a tank for reading.
    invoke(TTX,'OpenTank', [pathin tankName], 'R')
    
    % Select the block to access
    invoke(TTX,'SelectBlock', block)
    %pause
    TTX.CreateEpocIndexing;
    
    TimeRanges=TTX.GetEpocsV(event,0,0,maxret);
    
    vdt=TimeRanges(2,:);vdt=vdt/(60*60);
    
    vdt=vdt(vdt>0);
    
    if ev==1
        r1=ones(1,length(vdt))*ev; TimeRanges1=TimeRanges; vdt1=vdt;
    elseif ev==2
        r2=ones(1,length(vdt))*ev; TimeRanges2=TimeRanges; vdt2=vdt;
    else
        r3=ones(1,length(vdt))*ev; TimeRanges3=TimeRanges; vdt3=vdt;
    end
    
end

clear figure 1
fnout=[tank,'-',mousename,'-',recorddate,'-VDT'];
eval(['save ',pathout,fnout,'.mat TimeRanges1 TimeRanges2 TimeRanges3 r1 r2 r3 vdt1 vdt2 vdt3 -mat']); % save RW data

bar(vdt1,r1,'b')
hold on
bar(vdt2,r2,'r')
bar(vdt3,r3,'k')

axis([0 24 0 3])
set(gca,'XTick',[0:2:24])

clear TimeRanges rw r;

invoke(TTX,'CloseTank');


