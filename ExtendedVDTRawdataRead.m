clear all;close all;
filename = 'D:\Dropbox\Batch5\ExtendedVDT\Batch5_Watson_cage2_2ExtendedVDT24July2014.csv';
delimiter = ',';
startRow = 19;
formatSpec = '%s%*s%*s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
rawData = dataArray{1};
for row=1:size(rawData, 1);
    % Create a regular expression to detect and remove non-numeric prefixes and
    % suffixes.
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData{row}, regexstr, 'names');
        numbers = result.numbers;
        
        % Detected commas in non-thousand locations.
        invalidThousandsSeparator = false;
        if any(numbers==',');
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(thousandsRegExp, ',', 'once'));
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % Convert numeric strings to numbers.
        if ~invalidThousandsSeparator;
            numbers = textscan(strrep(numbers, ',', ''), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch me
    end
end
%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, 1);
rawCellColumns = raw(:, 2);
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells
Evnt_Time = cell2mat(rawNumericColumns(:, 1));
Item_Name = rawCellColumns(:, 1);
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;
%%
for n=1:length(Item_Name)
    
    birbeam(n)=strcmp(Item_Name{n},'"BIRBeam #1"');
    firbeam(n)=strcmp(Item_Name{n},'"FIRBeam #1"');
    corr(n)=strcmp(Item_Name{n},'"Correct"');
    incorr(n)=strcmp(Item_Name{n},'"Incorrect"');
    trstart(n)=strcmp(Item_Name{n},'"Start Trial"');
    omiss(n)=strcmp(Item_Name{n},'"Omission_trials"');
    
end

corrET=Evnt_Time(corr);
incorrET=Evnt_Time(incorr);
trstartET=Evnt_Time(trstart);
omissET=Evnt_Time(omiss);omissET(1)=[];
firbeamET=Evnt_Time(firbeam);
birbeamET=Evnt_Time(birbeam);

TotalTrial=length(trstartET)
CorrectTrial=length(corrET)
Accuracy=CorrectTrial/TotalTrial

RespondTime=sort([corrET; incorrET; omissET;]);
if length(RespondTime)>TotalTrial
    RespondTime(end)=[];
end

TS=[trstartET RespondTime];
latency=diff(TS,1,2);

figure;plot(trstartET,latency,'+');title('Latencies','Fontsize',20)
figure;hist(latency,100);title('Histogram of Latencies','Fontsize',20')


tenminbinnum=round(trstartET(end)/300);
for i=1:tenminbinnum
    
    corrnum5minbin(i)=sum(corrET/300>(i-1) & corrET/300<=i);
    omissnum5minbin(i)=sum(omissET/300>(i-1) & omissET/300<=i);
    incorrnum5minbin(i)=sum(incorrET/300>(i-1) & incorrET/300<=i);
    trialnum5minbin(i)=sum(trstartET/300>(i-1) & trstartET/300<=i);
   
end
% figure;plot(1:tenminbinnum,trialnum10minbin,'c+','MarkerSize',10);title('Completed Trial numbers in 10-minute bins','Fontsize',20)
% figure;plot(1:tenminbinnum,corrnum10minbin,'r+','MarkerSize',10);title('Correct Trial numbers in 10-minute bins','Fontsize',20)
% figure;plot(1:tenminbinnum,omissnum10minbin,'k+','MarkerSize',10);title('Omission Trial numbers in 10-minute bins','Fontsize',20)
% figure;plot(1:tenminbinnum,incorrnum10minbin,'m+','MarkerSize',10);title('Incorrect Trial numbers in 10-minute bins','Fontsize',20)
% figure;plot(1:tenminbinnum,corrnum10minbin./trialnum10minbin,'b+','MarkerSize',10);title('Accuracies in 10-minute bins','Fontsize',20)
% save('D:\Dropbox\Batch5\ExtendedVDT\cage4_1ExtendedVDT.mat','corrET','incorrET','trstartET','omissET','TS','latency','corrnum10minbin','incorrnum10minbin','omissnum10minbin')

BeamCrossET=sort([firbeamET; birbeamET]);
N=histc(BeamCrossET,0:300:max(Evnt_Time));bar(0:1:max(Evnt_Time)/300,N,'histc');axis([0 max(Evnt_Time)/300 0 max(N)])
title('Watson - ExtendedVDT 24/07/2014','Fontsize',28)
xlabel('Number of 5-minute bins/5-minute bins','Fontsize',28)
ylabel('Total Beam Cross','Fontsize',28)
set(gca,'Fontsize',28)