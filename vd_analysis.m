%% Scrpit for touch screen analysis
clear all
close all
path=['Dropbox/VVLab/'];

for animalID=[1 2 5 6]
    
    rawdata=importdata([path 'Pilot study - must touch raw data #' num2str(animalID) '.txt']);
    
    Display_Image=[];
    Image_Touched=[];
    Reward_Collected=[];
    Blank_Image_Touched=[];
    
    for event=1:(length(rawdata.textdata)-1)
        
        try
            if rawdata.textdata{event,4}=='Display Image' % 20 sec after Reward Collection
                Display_Image=[Display_Image str2num(rawdata.textdata{event,1})];
            end
        catch ME
            continue
        end
    end
    for event=1:(length(rawdata.textdata)-1)
        try
            if rawdata.textdata{event,4}=='Image Touched'
                Image_Touched=[Image_Touched str2num(rawdata.textdata{event,1})];
            end
        catch ME
            continue
        end
    end
    for event=1:(length(rawdata.textdata)-1)
        try
            if rawdata.textdata{event,4}=='Reward Collected Start ITI'
                Reward_Collected=[Reward_Collected str2num(rawdata.textdata{event,1})];
            end
        catch ME
            continue
        end
    end
    for event=1:(length(rawdata.textdata)-1)
        try
            if rawdata.textdata{event,4}=='Blank Image Touched'
                Blank_Image_Touched=[Blank_Image_Touched str2num(rawdata.textdata{event,1})];
            end
        catch ME
            continue
        end
    end
    
    %% Plotting
    
    figure
    hold on
    
    scatter(Display_Image,zeros(length(Display_Image),1),10,'r','filled');
    scatter(Blank_Image_Touched,repmat(0.2,length(Blank_Image_Touched),1),10,'g','filled');
    scatter(Image_Touched,repmat(0.4,length(Image_Touched),1),10,'b','filled');
    scatter(Reward_Collected,repmat(0.6,length(Reward_Collected),1),10,'k','filled');
    
    hold off
    xlabel('Time / Second')
    ylabel('Events')
    legend('Display Image','Blank Image Touched','Image Touched','Reward Collected','Location','SouthEast')
    axis([0 3600 -5 5])
    title('Animal num2str(AnimalID)')
end
