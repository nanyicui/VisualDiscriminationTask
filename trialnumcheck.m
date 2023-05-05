clear
trialnum=[];
path1='D:\Dropbox\Batch4\Batch4rawdata\';

for animalID=1:8
    for condition=1:2
        if condition == 1
            cond='CO';
        elseif condition == 2
            cond='SD';
        end
        if animalID==5 && condition==2
            filename=[path1,'mouse',num2str(animalID),cond,'r.mat'];
        else filename = [path1,'mouse' num2str(animalID) cond '.mat'];end
        
        fileID = fopen(filename,'r');
        
        load(filename)
        trialnum=[trialnum length(TS)];
        if animalID==5 && condition==2
            filename_=[path1,'mouse',num2str(animalID),cond,'rvideo','.mat'];
        else filename_=[path1,'mouse',num2str(animalID),cond,'video','.mat'];end
        
        load(filename_)
        trialnum=[trialnum length(turncol) length(imagecol) length(nosepokecol)];
    end
end

trialnum=reshape(trialnum,4,16);
inconsistrial=find(var(trialnum)~=0);
%%
clear
path1='D:\Dropbox\Batch4\Batch4rawdata\';
animalID=5;
condition=2;
if condition == 1
    cond='CO';else cond='SD';end

filename = [path1,'mouse' num2str(animalID) cond '.mat'];
if mousenum==5 && condition==2
    filename=[path1,'mouse',num2str(mousenum),cond,'r.txt']; end
fileID = fopen(filename,'r');

load(filename)
filename_=[path1,'mouse',num2str(animalID),cond,'video','.mat'];
load(filename_)

[I,J]=find(diff(~isnan(nosepokecol),1,2)==-1);
ind=[I J];
ind=sortrows(ind);
for n=1:length(ind)
    lasttouch(n)=nosepokecol(ind(n,1),ind(n,2));
end
lasttouch=lasttouch';
correctornot=(lasttouch-imagecol)==0;

touchsensitivity=TS(:,3)-correctornot(1:length(TS));
%%
% if sum(touchsensitivity)==0
%     turncol(end)=[];imagecol(end)=[];nosepokecol(end,:)=[];end
clear I J ans correctornot ind lasttouch n touchsensitivity

save([path1,'mouse',num2str(animalID),cond,'video','.mat'],'turncol','imagecol','nosepokecol');

