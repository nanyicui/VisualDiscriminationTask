f1=figure(1);
%% Exp I 1(1)CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp I 1(1) CO.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
I11CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(I11CO)
    
    birbeamI11CO(n)=strcmp(I11CO{n,4},'BIRBeam #1');  
    firbeamI11CO(n)=strcmp(I11CO{n,4},'FIRBeam #1');
    corrI11CO(n)=strcmp(I11CO{n,4},'Correct');
    incorrI11CO(n)=strcmp(I11CO{n,4},'Incorrect');
    trstartI11CO(n)=strcmp(I11CO{n,4},'Start Trial');
    crtntrstartI11CO(n)=strcmp(I11CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossI11CO=sum(sum(birbeamI11CO)+sum(firbeamI11CO));
corrETI11CO=str2double(I11CO(corrI11CO,1));
incorrETI11CO=str2double(I11CO(incorrI11CO,1));
trstartETI11CO=str2double(I11CO(trstartI11CO,1));
crtntrstartETI11CO=str2double(I11CO(crtntrstartI11CO,1));


subplot(10,2,1),
hold on
plot(corrETI11CO,2,'b.');plot(incorrETI11CO,1,'r.');
plot(trstartETI11CO,1.5,'bo');plot(crtntrstartETI11CO,1.5,'ro')
axis([0 3600 0 3])
hold off
%% Exp I 2(1)CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp I 2(1) CO.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
I21CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(I21CO)
    
    birbeamI21CO(n)=strcmp(I21CO{n,4},'BIRBeam #1');  
    firbeamI21CO(n)=strcmp(I21CO{n,4},'FIRBeam #1');
    corrI21CO(n)=strcmp(I21CO{n,4},'Correct');
    incorrI21CO(n)=strcmp(I21CO{n,4},'Incorrect');
    trstartI21CO(n)=strcmp(I21CO{n,4},'Start Trial');
    crtntrstartI21CO(n)=strcmp(I21CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossI21CO=sum(sum(birbeamI21CO)+sum(firbeamI21CO));
corrETI21CO=str2double(I21CO(corrI21CO,1));
incorrETI21CO=str2double(I21CO(incorrI21CO,1));
trstartETI21CO=str2double(I21CO(trstartI21CO,1));
crtntrstartETI21CO=str2double(I21CO(crtntrstartI21CO,1));


subplot(10,2,3),
hold on
plot(corrETI21CO,2,'b.');plot(incorrETI21CO,1,'r.');
plot(trstartETI21CO,1.5,'bo');plot(crtntrstartETI21CO,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp I 4(3)SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp I 4(3) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
I43SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(I43SD)
    
    birbeamI43SD(n)=strcmp(I43SD{n,4},'BIRBeam #1');  
    firbeamI43SD(n)=strcmp(I43SD{n,4},'FIRBeam #1');
    corrI43SD(n)=strcmp(I43SD{n,4},'Correct');
    incorrI43SD(n)=strcmp(I43SD{n,4},'Incorrect');
    trstartI43SD(n)=strcmp(I43SD{n,4},'Start Trial');
    crtntrstartI43SD(n)=strcmp(I43SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossI43SD=sum(sum(birbeamI43SD)+sum(firbeamI43SD));
corrETI43SD=str2double(I43SD(corrI43SD,1));
incorrETI43SD=str2double(I43SD(incorrI43SD,1));
trstartETI43SD=str2double(I43SD(trstartI43SD,1));
crtntrstartETI43SD=str2double(I43SD(crtntrstartI43SD,1));


subplot(10,2,16),
hold on
plot(corrETI43SD,2,'b.');plot(incorrETI43SD,1,'r.');
plot(trstartETI43SD,1.5,'bo');plot(crtntrstartETI43SD,1.5,'ro')
axis([0 3600 0 3])
hold off
%% Exp I 5(1) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp I 5(1) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
I51SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(I51SD)
    
    birbeamI51SD(n)=strcmp(I51SD{n,4},'BIRBeam #1');  
    firbeamI51SD(n)=strcmp(I51SD{n,4},'FIRBeam #1');
    corrI51SD(n)=strcmp(I51SD{n,4},'Correct');
    incorrI51SD(n)=strcmp(I51SD{n,4},'Incorrect');
    trstartI51SD(n)=strcmp(I51SD{n,4},'Start Trial');
    crtntrstartI51SD(n)=strcmp(I51SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossI51SD=sum(sum(birbeamI51SD)+sum(firbeamI51SD));
corrETI51SD=str2double(I51SD(corrI51SD,1));
incorrETI51SD=str2double(I51SD(incorrI51SD,1));
trstartETI51SD=str2double(I51SD(trstartI51SD,1));
crtntrstartETI51SD=str2double(I51SD(crtntrstartI51SD,1));


subplot(10,2,6),
hold on
plot(corrETI51SD,2,'b.');plot(incorrETI51SD,1,'r.');
plot(trstartETI51SD,1.5,'bo');plot(crtntrstartETI51SD,1.5,'ro')
axis([0 3600 0 3])
hold off
%% Exp II 1(3) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp II 1(3) CO.csv';
delimiter = ',';

formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
II13CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(II13CO)
    
    birbeamII13CO(n)=strcmp(II13CO{n,4},'BIRBeam #1');  
    firbeamII13CO(n)=strcmp(II13CO{n,4},'FIRBeam #1');
    corrII13CO(n)=strcmp(II13CO{n,4},'Correct');
    incorrII13CO(n)=strcmp(II13CO{n,4},'Incorrect');
    trstartII13CO(n)=strcmp(II13CO{n,4},'Start Trial');
    crtntrstartII13CO(n)=strcmp(II13CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossII13CO=sum(sum(birbeamII13CO)+sum(firbeamII13CO));
corrETII13CO=str2double(II13CO(corrII13CO,1));
incorrETII13CO=str2double(II13CO(incorrII13CO,1));
trstartETII13CO=str2double(II13CO(trstartII13CO,1));
crtntrstartETII13CO=str2double(II13CO(crtntrstartII13CO,1));


subplot(10,2,9),
hold on
plot(corrETII13CO,2,'b.');plot(incorrETII13CO,1,'r.');
plot(trstartETII13CO,1.5,'bo');plot(crtntrstartETII13CO,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp II 2(3) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp II 2(3) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
II23SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(II23SD)
    
    birbeamII23SD(n)=strcmp(II23SD{n,4},'BIRBeam #1');  
    firbeamII23SD(n)=strcmp(II23SD{n,4},'FIRBeam #1');
    corrII23SD(n)=strcmp(II23SD{n,4},'Correct');
    incorrII23SD(n)=strcmp(II23SD{n,4},'Incorrect');
    trstartII23SD(n)=strcmp(II23SD{n,4},'Start Trial');
    crtntrstartII23SD(n)=strcmp(II23SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossII23SD=sum(sum(birbeamII23SD)+sum(firbeamII23SD));
corrETII23SD=str2double(II23SD(corrII23SD,1));
incorrETII23SD=str2double(II23SD(incorrII23SD,1));
trstartETII23SD=str2double(II23SD(trstartII23SD,1));
crtntrstartETII23SD=str2double(II23SD(crtntrstartII23SD,1));


subplot(10,2,12),
hold on
plot(corrETII23SD,2,'b.');plot(incorrETII23SD,1,'r.');
plot(trstartETII23SD,1.5,'bo');plot(crtntrstartETII23SD,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp III 1(1) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp III 1(1) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
III11SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(III11SD)
    
    birbeamIII11SD(n)=strcmp(III11SD{n,4},'BIRBeam #1');  
    firbeamIII11SD(n)=strcmp(III11SD{n,4},'FIRBeam #1');
    corrIII11SD(n)=strcmp(III11SD{n,4},'Correct');
    incorrIII11SD(n)=strcmp(III11SD{n,4},'Incorrect');
    trstartIII11SD(n)=strcmp(III11SD{n,4},'Start Trial');
    crtntrstartIII11SD(n)=strcmp(III11SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIII11SD=sum(sum(birbeamIII11SD)+sum(firbeamIII11SD));
corrETIII11SD=str2double(III11SD(corrIII11SD,1));
incorrETIII11SD=str2double(III11SD(incorrIII11SD,1));
trstartETIII11SD=str2double(III11SD(trstartIII11SD,1));
crtntrstartETIII11SD=str2double(III11SD(crtntrstartIII11SD,1));


subplot(10,2,2),
hold on
plot(corrETIII11SD,2,'b.');plot(incorrETIII11SD,1,'r.');
plot(trstartETIII11SD,1.5,'bo');plot(crtntrstartETIII11SD,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp III 2(1) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp III 2(1) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
III21SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(III21SD)
    
    birbeamIII21SD(n)=strcmp(III21SD{n,4},'BIRBeam #1');  
    firbeamIII21SD(n)=strcmp(III21SD{n,4},'FIRBeam #1');
    corrIII21SD(n)=strcmp(III21SD{n,4},'Correct');
    incorrIII21SD(n)=strcmp(III21SD{n,4},'Incorrect');
    trstartIII21SD(n)=strcmp(III21SD{n,4},'Start Trial');
    crtntrstartIII21SD(n)=strcmp(III21SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIII21SD=sum(sum(birbeamIII21SD)+sum(firbeamIII21SD));
corrETIII21SD=str2double(III21SD(corrIII21SD,1));
incorrETIII21SD=str2double(III21SD(incorrIII21SD,1));
trstartETIII21SD=str2double(III21SD(trstartIII21SD,1));trstartETIII21SD(end)=[];
crtntrstartETIII21SD=str2double(III21SD(crtntrstartIII21SD,1));


subplot(10,2,4),
hold on
plot(corrETIII21SD,2,'b.');plot(incorrETIII21SD,1,'r.');
plot(trstartETIII21SD,1.5,'bo');plot(crtntrstartETIII21SD,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp III 4(3) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp III 4(3) CO.csv';
delimiter = ',';

formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
III43CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(III43CO)
    
    birbeamIII43CO(n)=strcmp(III43CO{n,4},'BIRBeam #1');  
    firbeamIII43CO(n)=strcmp(III43CO{n,4},'FIRBeam #1');
    corrIII43CO(n)=strcmp(III43CO{n,4},'Correct');
    incorrIII43CO(n)=strcmp(III43CO{n,4},'Incorrect');
    trstartIII43CO(n)=strcmp(III43CO{n,4},'Start Trial');
    crtntrstartIII43CO(n)=strcmp(III43CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIII43CO=sum(sum(birbeamIII43CO)+sum(firbeamIII43CO));
corrETIII43CO=str2double(III43CO(corrIII43CO,1));
incorrETIII43CO=str2double(III43CO(incorrIII43CO,1));
trstartETIII43CO=str2double(III43CO(trstartIII43CO,1));
crtntrstartETIII43CO=str2double(III43CO(crtntrstartIII43CO,1));


subplot(10,2,15),
hold on
plot(corrETIII43CO,2,'b.');plot(incorrETIII43CO,1,'r.');
plot(trstartETIII43CO,1.5,'bo');plot(crtntrstartETIII43CO,1.5,'ro')
axis([0 3600 0 3])
hold off
%% Exp III 5(1) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp III 5(1) CO.csv';
delimiter = ',';

formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
III51CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(III51CO)
    
    birbeamIII51CO(n)=strcmp(III51CO{n,4},'BIRBeam #1');  
    firbeamIII51CO(n)=strcmp(III51CO{n,4},'FIRBeam #1');
    corrIII51CO(n)=strcmp(III51CO{n,4},'Correct');
    incorrIII51CO(n)=strcmp(III51CO{n,4},'Incorrect');
    trstartIII51CO(n)=strcmp(III51CO{n,4},'Start Trial');
    crtntrstartIII51CO(n)=strcmp(III51CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIII51CO=sum(sum(birbeamIII51CO)+sum(firbeamIII51CO));
corrETIII51CO=str2double(III51CO(corrIII51CO,1));
incorrETIII51CO=str2double(III51CO(incorrIII51CO,1));
trstartETIII51CO=str2double(III51CO(trstartIII51CO,1));
crtntrstartETIII51CO=str2double(III51CO(crtntrstartIII51CO,1));


subplot(10,2,5),
hold on
plot(corrETIII51CO,2,'b.');plot(incorrETIII51CO,1,'r.');
plot(trstartETIII51CO,1.5,'bo');plot(crtntrstartETIII51CO,1.5,'ro')
axis([0 3600 0 3])
hold off
%% Exp III 6(1) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp III 6(1) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
III61SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(III61SD)
    
    birbeamIII61SD(n)=strcmp(III61SD{n,4},'BIRBeam #1');  
    firbeamIII61SD(n)=strcmp(III61SD{n,4},'FIRBeam #1');
    corrIII61SD(n)=strcmp(III61SD{n,4},'Correct');
    incorrIII61SD(n)=strcmp(III61SD{n,4},'Incorrect');
    trstartIII61SD(n)=strcmp(III61SD{n,4},'Start Trial');
    crtntrstartIII61SD(n)=strcmp(III61SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIII61SD=sum(sum(birbeamIII61SD)+sum(firbeamIII61SD));
corrETIII61SD=str2double(III61SD(corrIII61SD,1));
incorrETIII61SD=str2double(III61SD(incorrIII61SD,1));
trstartETIII61SD=str2double(III61SD(trstartIII61SD,1));
crtntrstartETIII61SD=str2double(III61SD(crtntrstartIII61SD,1));


subplot(10,2,8),
hold on
plot(corrETIII61SD,2,'b.');plot(incorrETIII61SD,1,'r.');
plot(trstartETIII61SD,1.5,'bo');plot(crtntrstartETIII61SD,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp IV 1(3) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp IV 1(3) SD.csv';
delimiter = ',';

formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
IV13SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(IV13SD)
    
    birbeamIV13SD(n)=strcmp(IV13SD{n,4},'BIRBeam #1');  
    firbeamIV13SD(n)=strcmp(IV13SD{n,4},'FIRBeam #1');
    corrIV13SD(n)=strcmp(IV13SD{n,4},'Correct');
    incorrIV13SD(n)=strcmp(IV13SD{n,4},'Incorrect');
    trstartIV13SD(n)=strcmp(IV13SD{n,4},'Start Trial');
    crtntrstartIV13SD(n)=strcmp(IV13SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIV13SD=sum(sum(birbeamIV13SD)+sum(firbeamIV13SD));
corrETIV13SD=str2double(IV13SD(corrIV13SD,1));
incorrETIV13SD=str2double(IV13SD(incorrIV13SD,1));
trstartETIV13SD=str2double(IV13SD(trstartIV13SD,1));
crtntrstartETIV13SD=str2double(IV13SD(crtntrstartIV13SD,1));


subplot(10,2,10),
hold on
plot(corrETIV13SD,2,'b.');plot(incorrETIV13SD,1,'r.');
plot(trstartETIV13SD,1.5,'bo');plot(crtntrstartETIV13SD,1.5,'ro')
axis([0 3600 0 3])
hold off
%% Exp IV 2(3) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp IV 2(3) CO.csv';
delimiter = ',';

formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
IV23CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(IV23CO)
    
    birbeamIV23CO(n)=strcmp(IV23CO{n,4},'BIRBeam #1');  
    firbeamIV23CO(n)=strcmp(IV23CO{n,4},'FIRBeam #1');
    corrIV23CO(n)=strcmp(IV23CO{n,4},'Correct');
    incorrIV23CO(n)=strcmp(IV23CO{n,4},'Incorrect');
    trstartIV23CO(n)=strcmp(IV23CO{n,4},'Start Trial');
    crtntrstartIV23CO(n)=strcmp(IV23CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIV23CO=sum(sum(birbeamIV23CO)+sum(firbeamIV23CO));
corrETIV23CO=str2double(IV23CO(corrIV23CO,1));
incorrETIV23CO=str2double(IV23CO(incorrIV23CO,1));
trstartETIV23CO=str2double(IV23CO(trstartIV23CO,1));
crtntrstartETIV23CO=str2double(IV23CO(crtntrstartIV23CO,1));


subplot(10,2,11),
hold on
plot(corrETIV23CO,2,'b.');plot(incorrETIV23CO,1,'r.');
plot(trstartETIV23CO,1.5,'bo');plot(crtntrstartETIV23CO,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp IV 3(3) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp IV 3(3) CO.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
IV33CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(IV33CO)
    
    birbeamIV33CO(n)=strcmp(IV33CO{n,4},'BIRBeam #1');  
    firbeamIV33CO(n)=strcmp(IV33CO{n,4},'FIRBeam #1');
    corrIV33CO(n)=strcmp(IV33CO{n,4},'Correct');
    incorrIV33CO(n)=strcmp(IV33CO{n,4},'Incorrect');
    trstartIV33CO(n)=strcmp(IV33CO{n,4},'Start Trial');
    crtntrstartIV33CO(n)=strcmp(IV33CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossIV33CO=sum(sum(birbeamIV33CO)+sum(firbeamIV33CO));
corrETIV33CO=str2double(IV33CO(corrIV33CO,1));
incorrETIV33CO=str2double(IV33CO(incorrIV33CO,1));
trstartETIV33CO=str2double(IV33CO(trstartIV33CO,1));
crtntrstartETIV33CO=str2double(IV33CO(crtntrstartIV33CO,1));


subplot(10,2,13),
hold on
plot(corrETIV33CO,2,'b.');plot(incorrETIV33CO,1,'r.');
plot(trstartETIV33CO,1.5,'bo');plot(crtntrstartETIV33CO,1.5,'ro')
axis([0 3600 0 3])
hold off

%% Exp V 3(2) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp V 3(2) CO.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
V32CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(V32CO)
    
    birbeamV32CO(n)=strcmp(V32CO{n,4},'BIRBeam #1');  
    firbeamV32CO(n)=strcmp(V32CO{n,4},'FIRBeam #1');
    corrV32CO(n)=strcmp(V32CO{n,4},'Correct');
    incorrV32CO(n)=strcmp(V32CO{n,4},'Incorrect');
    trstartV32CO(n)=strcmp(V32CO{n,4},'Start Trial');
    crtntrstartV32CO(n)=strcmp(V32CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossV32CO=sum(sum(birbeamV32CO)+sum(firbeamV32CO));
corrETV32CO=str2double(V32CO(corrV32CO,1));
incorrETV32CO=str2double(V32CO(incorrV32CO,1));
trstartETV32CO=str2double(V32CO(trstartV32CO,1));
crtntrstartETV32CO=str2double(V32CO(crtntrstartV32CO,1));


subplot(10,2,17),
hold on
plot(corrETV32CO,2,'b.');plot(incorrETV32CO,1,'r.');
plot(trstartETV32CO,1.5,'bo');plot(crtntrstartETV32CO,1.5,'ro')
axis([0 3600 0 3])
hold off


set=4;
cond='CO';
TS=TSinitiation(trstartETV32CO,crtntrstartETV32CO,corrETV32CO,incorrETV32CO);

beamcross=hist(sort([str2double(V32CO(birbeamV32CO)'); str2double(V32CO(firbeamV32CO)')]),[0.5:1:3599.5]);

save('S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\TSinitiation\m09CO.mat','beamcross','TS','set','cond')


%% Exp V 3(2) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp V 3(2) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
V32SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(V32SD)
    
    birbeamV32SD(n)=strcmp(V32SD{n,4},'BIRBeam #1');  
    firbeamV32SD(n)=strcmp(V32SD{n,4},'FIRBeam #1');
    corrV32SD(n)=strcmp(V32SD{n,4},'Correct');
    incorrV32SD(n)=strcmp(V32SD{n,4},'Incorrect');
    trstartV32SD(n)=strcmp(V32SD{n,4},'Start Trial');
    crtntrstartV32SD(n)=strcmp(V32SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossV32SD=sum(sum(birbeamV32SD)+sum(firbeamV32SD));
corrETV32SD=str2double(V32SD(corrV32SD,1));
incorrETV32SD=str2double(V32SD(incorrV32SD,1));
trstartETV32SD=str2double(V32SD(trstartV32SD,1));
crtntrstartETV32SD=str2double(V32SD(crtntrstartV32SD,1));


subplot(10,2,18),
hold on
plot(corrETV32SD,2,'b.');plot(incorrETV32SD,1,'r.');
plot(trstartETV32SD,1.5,'bo');plot(crtntrstartETV32SD,1.5,'ro')
axis([0 3600 0 3])
hold off


set=4;
cond='SD';
TS=TSinitiation(trstartETV32SD,crtntrstartETV32SD,corrETV32SD,incorrETV32SD);

beamcross=hist(sort([str2double(V32SD(birbeamV32SD)'); str2double(V32SD(firbeamV32SD)')]),[0.5:1:3599.5]);

save('S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\TSinitiation\m09SD.mat','beamcross','TS','set','cond')

%% Exp V 3(3) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp V 3(3) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
V33SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(V33SD)
    
    birbeamV33SD(n)=strcmp(V33SD{n,4},'BIRBeam #1');  
    firbeamV33SD(n)=strcmp(V33SD{n,4},'FIRBeam #1');
    corrV33SD(n)=strcmp(V33SD{n,4},'Correct');
    incorrV33SD(n)=strcmp(V33SD{n,4},'Incorrect');
    trstartV33SD(n)=strcmp(V33SD{n,4},'Start Trial');
    crtntrstartV33SD(n)=strcmp(V33SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossV33SD=sum(sum(birbeamV33SD)+sum(firbeamV33SD));
corrETV33SD=str2double(V33SD(corrV33SD,1));
incorrETV33SD=str2double(V33SD(incorrV33SD,1));
trstartETV33SD=str2double(V33SD(trstartV33SD,1));
crtntrstartETV33SD=str2double(V33SD(crtntrstartV33SD,1));


subplot(10,2,14),
hold on
plot(corrETV33SD,2,'b.');plot(incorrETV33SD,1,'r.');
plot(trstartETV33SD,1.5,'bo');plot(crtntrstartETV33SD,1.5,'ro')
axis([0 3600 0 3])
hold off


set=4;
cond='SD';
TS=TSinitiation(trstartETV33SD,crtntrstartETV33SD,corrETV33SD,incorrETV33SD);

beamcross=hist(sort([str2double(V33SD(birbeamV33SD)'); str2double(V33SD(firbeamV33SD)')]),[0.5:1:3599.5]);

save('S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\TSinitiation\m07SD.mat','beamcross','TS','set','cond')

%% Exp V 4(2) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp V 4(2) CO.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
V42CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(V42CO)
    
    birbeamV42CO(n)=strcmp(V42CO{n,4},'BIRBeam #1');  
    firbeamV42CO(n)=strcmp(V42CO{n,4},'FIRBeam #1');
    corrV42CO(n)=strcmp(V42CO{n,4},'Correct');
    incorrV42CO(n)=strcmp(V42CO{n,4},'Incorrect');
    trstartV42CO(n)=strcmp(V42CO{n,4},'Start Trial');
    crtntrstartV42CO(n)=strcmp(V42CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossV42CO=sum(sum(birbeamV42CO)+sum(firbeamV42CO));
corrETV42CO=str2double(V42CO(corrV42CO,1));
incorrETV42CO=str2double(V42CO(incorrV42CO,1));
trstartETV42CO=str2double(V42CO(trstartV42CO,1));
crtntrstartETV42CO=str2double(V42CO(crtntrstartV42CO,1));


subplot(10,2,19),
hold on
plot(corrETV42CO,2,'b.');plot(incorrETV42CO,1,'r.');
plot(trstartETV42CO,1.5,'bo');plot(crtntrstartETV42CO,1.5,'ro')
axis([0 3600 0 3])
hold off


set=4;
cond='CO';
TS=TSinitiation(trstartETV42CO,crtntrstartETV42CO,corrETV42CO,incorrETV42CO);

beamcross=hist(sort([str2double(V42CO(birbeamV42CO)'); str2double(V42CO(firbeamV42CO)')]),[0.5:1:3599.5]);

save('S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\TSinitiation\m10CO.mat','beamcross','TS','set','cond')

%% Exp V 4(2) SD
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp V 4(2) SD.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
V42SD = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(V42SD)
    
    birbeamV42SD(n)=strcmp(V42SD{n,4},'BIRBeam #1');  
    firbeamV42SD(n)=strcmp(V42SD{n,4},'FIRBeam #1');
    corrV42SD(n)=strcmp(V42SD{n,4},'Correct');
    incorrV42SD(n)=strcmp(V42SD{n,4},'Incorrect');
    trstartV42SD(n)=strcmp(V42SD{n,4},'Start Trial');
    crtntrstartV42SD(n)=strcmp(V42SD{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossV42SD=sum(sum(birbeamV42SD)+sum(firbeamV42SD));
corrETV42SD=str2double(V42SD(corrV42SD,1));
incorrETV42SD=str2double(V42SD(incorrV42SD,1));
trstartETV42SD=str2double(V42SD(trstartV42SD,1));
crtntrstartETV42SD=str2double(V42SD(crtntrstartV42SD,1));


subplot(10,2,20),
hold on
plot(corrETV42SD,2,'b.');plot(incorrETV42SD,1,'r.');
plot(trstartETV42SD,1.5,'bo');plot(crtntrstartETV42SD,1.5,'ro')
axis([0 3600 0 3])
hold off


set=4;
cond='SD';
TS=TSinitiation(trstartETV42SD,crtntrstartETV42SD,corrETV42SD,incorrETV42SD);

beamcross=hist(sort([str2double(V42SD(birbeamV42SD)'); str2double(V42SD(firbeamV42SD)')]),[0.5:1:3599.5]);

save('S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\TSinitiation\m10SD.mat','beamcross','TS','set','cond')

%% Exp V 6(1) CO
filename = 'S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\Exp V 6(1) CO.csv';
delimiter = ',';


formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
V61CO = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;

for n=1:length(V61CO)
    
    birbeamV61CO(n)=strcmp(V61CO{n,4},'BIRBeam #1');  
    firbeamV61CO(n)=strcmp(V61CO{n,4},'FIRBeam #1');
    corrV61CO(n)=strcmp(V61CO{n,4},'Correct');
    incorrV61CO(n)=strcmp(V61CO{n,4},'Incorrect');
    trstartV61CO(n)=strcmp(V61CO{n,4},'Start Trial');
    crtntrstartV61CO(n)=strcmp(V61CO{n,4},'Tray Exit Starts Correction Trial');
end

totalbeamcrossV61CO=sum(sum(birbeamV61CO)+sum(firbeamV61CO));
corrETV61CO=str2double(V61CO(corrV61CO,1));
incorrETV61CO=str2double(V61CO(incorrV61CO,1));
trstartETV61CO=str2double(V61CO(trstartV61CO,1));
crtntrstartETV61CO=str2double(V61CO(crtntrstartV61CO,1));


subplot(10,2,20),
hold on
plot(corrETV61CO,2,'b.');plot(incorrETV61CO,1,'r.');
plot(trstartETV61CO,1.5,'bo');plot(crtntrstartETV61CO,1.5,'ro')
axis([0 3600 0 3])
hold off


set=4;
cond='CO';
TS=TSinitiation(trstartETV61CO,crtntrstartETV61CO,corrETV61CO,incorrETV61CO);

beamcross=hist(sort([str2double(V61CO(birbeamV61CO)'); str2double(V61CO(firbeamV61CO)')]),[0.5:1:3599.5]);

save('S:\Shared_Projects\BC00_VVLAB\VDT\EXPrawdata\TSinitiation\m04CO.mat','beamcross','TS','set','cond')


%%
f2=figure(2);
totalbeamcrossCO=[totalbeamcrossI11CO totalbeamcrossI21CO totalbeamcrossII13CO totalbeamcrossIII43CO totalbeamcrossIII51CO totalbeamcrossIV23CO totalbeamcrossIV33CO totalbeamcrossV32CO totalbeamcrossV42CO totalbeamcrossV61CO];
totalbeamcrossSD=[totalbeamcrossI43SD totalbeamcrossI51SD totalbeamcrossII23SD totalbeamcrossIII11SD totalbeamcrossIII21SD totalbeamcrossIII61SD totalbeamcrossIV13SD totalbeamcrossV32SD totalbeamcrossV33SD totalbeamcrossV42SD];
subplot(2,2,1),bar(totalbeamcrossCO);axis([0 8 0 3000]);
subplot(2,2,2),bar(totalbeamcrossSD);axis([0 8 0 3000]);

subplot(2,2,3),hold on
errorbar([mean(totalbeamcrossCO) mean(totalbeamcrossSD)],[std(totalbeamcrossCO)/sqrt(length(totalbeamcrossCO)) std(totalbeamcrossSD)/sqrt(length(totalbeamcrossSD))],'xr');
bar([mean(totalbeamcrossCO) mean(totalbeamcrossSD)]);
axis([0 3 0 3000])
hold off

