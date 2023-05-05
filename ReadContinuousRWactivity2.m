close all
clear all

pathout='D:\OutputRW\'; mkdir(pathout)
pathin='D:\';

maxret = 10000000;
recorddates=strvcat('221214_D');%day month year

numd=size(recorddates,1);
block1=strvcat('Bdr1_Ctr1_Thy1_Op1_')
mousenames=strvcat('Bdr1','Ctr1','Thy1','Op1');

numanim=1;

tankName='BDRtanks';

for day=1:1
    
    recorddate=[recorddates(day,:)];
    block=[block1,recorddate]
   
    figure
    for mouse=1:numanim
        
        event = ['WHE',num2str(mouse)];
        %mousename=['Anm',num2str(mouse)];
        mousename=mousenames(mouse,:);
         mousename(isspace(mousename))=[];
        
        TTX = actxcontrol('TTank.X')
        % Then connect to a server.
        invoke(TTX,'ConnectServer', 'Local', 'Me')
        
        tank=tankName;
        
        % Now open a tank for reading.
        invoke(TTX,'OpenTank', [pathin tankName], 'R')
        
        % pause
        % Select the block to access
        invoke(TTX,'SelectBlock', block)
        %pause
        TTX.CreateEpocIndexing;
        
        TimeRanges=TTX.GetEpocsV(event,0,0,maxret);
        %pause
        if isnan(TimeRanges)==1
            rw=0; r=0;
        else
            rw=TimeRanges(2,:);rw=rw/(60*60);rw=rw(rw>0); r=ones(1,length(rw));
        end
        
        %clear figure 1
        fnout=[mousename,'-',recorddate,'-RW'];
        eval(['save ',pathout,fnout,'.mat TimeRanges rw r event -mat']); % save RW data
        
        subplot(2,2,mouse)
        bar(rw,r)
        axis([0 12 0 1])
        set(gca,'XTick',[0:2:12])
        title([mousename,' ',recorddate])
        
        %clear TimeRanges rw r;
        %pause
    end
    % pause
end

invoke(TTX,'CloseTank');
