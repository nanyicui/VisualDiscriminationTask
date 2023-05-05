close all
clear all

pathout='D:\moneeb\SerialVDTPlots\';
pathin='D:\moneeb\rawdata\';
mousename='Steve';

maxret = 1000000;
% recorddates=strvcat('150714','160714');%day month year
tankName='Batch6';
% block=['Al_Wa_St_Cl_',recorddate]
numanim=3;
% eventsVDT=[1 2]

%find all event days from excel along with other relevant information
[num,txt,raw] = xlsread('15Jul14_MouseDataCollectionOutline.xlsx',mousename,'a17:q65')
idx = find(strcmp(txt(:,16),'Yes'));
vdtchannel = raw(idx,17);
blockname = txt(idx,3)
date = txt(idx,15);
starttime = txt(idx,4)

% mousenames = strvcat('Alan','Watson','Steve');

%titlestr=['VDT data for all days: ',mousename];
    figure;

for day=1:size(idx,1)
    
    block=char(blockname(day))
    
    for ev=1:3
        
        if ev == 1
            event = ['INI',num2str(cell2mat(vdtchannel(day)))];
        elseif ev == 2
            event = ['COR',num2str(cell2mat(vdtchannel(day)))];
        elseif ev == 3
            event = ['INC',num2str(cell2mat(vdtchannel(day)))];
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
        if isnan(TimeRanges)==1
            continue
        end
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
    
    %     clear figure 1
    %     fnout=[tank,'-',mousename,'-',recorddate,'-VDT'];
    %     eval(['save ',pathout,fnout,'.mat TimeRanges1 TimeRanges2 TimeRanges3 r1 r2 r3 vdt1 vdt2 vdt3 -mat']); % save VDT data
    
    
    
    p = char(date(day));
    
    subplot(7,1,day)
    
    scatter(vdt1,r1,'ob','filled')
    hold on
    scatter(vdt2,r2,'dr','filled')
    scatter(vdt3,r3,'sk','filled')
    grid on
    
    set(gca,'YTickLabel',{'INI','COR','INC'})
    
    axis([0 12 0.5 3.5])
    text(0,4,p);
    
    if day==1 title(mousename); end
 
    if day==size(idx,1)
        set(gca,'XTick',[0:2:12]);
        xlabel('Time [HOURS]');
    else
        set(gca,'XTick',[]);
    end
    
    clear TimeRanges rw r;
    
    invoke(TTX,'CloseTank');
    
end

orient tall
saveas(gcf,[pathout,mousename,'-VDTactivity'],'pdf')


