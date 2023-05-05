close all
clear all

pathout='D:\Batch6\RW\';
pathin='L:\VVyazovskiy\Collaborators\';
maxret = 1000000;
recorddate='170714';%day month year - only thing to change
tankName='Batch6';
block=['Sh_Ch_Fr_',recorddate];
%block=['Al_Wa_St_',recorddate];
numanim=3;
numch=3;

for mouse=1:numanim
    
    if mouse == 1
        mousename='Sherlock';
        event = 'WHE1';
    elseif mouse == 2
        mousename='Charles';
        event = 'WHE2';
    elseif mouse == 3
        mousename='Freud';
        event = 'WHE3';
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
    
        rw=TimeRanges(2,:);rw=rw/(60*60);rw=rw(rw>0); r=ones(1,length(rw));
    
    clear figure 1
    fnout=[tank,'-',mousename,'-',recorddate,'-',event];
    eval(['save ',pathout,fnout,'.mat TimeRanges rw r  -mat']); % save RW data
    
    subplot(2,2,mouse)
    bar(rw,r)
    axis([0 24 0 1])
    set(gca,'XTick',[0:2:24])
    
    %clear TimeRanges rw r;
    
end
invoke(TTX,'CloseTank');


