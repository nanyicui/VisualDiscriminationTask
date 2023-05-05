pathname1 = 'D:\Dropbox\Batch5\ExtendedVDT\';
delimiter = ',';
startRow = 19;

formatSpec = '%s%s%s%s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

for cage=1:5
    for animID=1:2
        for daynum=1:6
            fileID = fopen([pathname1,'cage',num2str(cage),'_',num2str(animID),'day',num2str(daynum),'.csv'],'r');
            if fileID<0
                continue
            end
            
            dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
            fclose(fileID);
            
            EvntTime = dataArray{:, 1};
            EvntID = dataArray{:, 2};
            EvntName = dataArray{:, 3};
            ItemName = dataArray{:, 4};
            
            EventTime=str2double(EvntTime{:});
            
        end
    end
end