path1='D:\Dropbox\Batch4\Batch4rawdata\';

for mousenum=1:8
    for condition=1:2
        if condition==1
            cond='CO';
        else cond='SD';
        end
        
       
        filename=[path1,'mouse',num2str(mousenum),cond,'.txt'];
         if mousenum==5 && condition==2
            filename=[path1,'mouse',num2str(mousenum),cond,'r.txt']; end
        [time,behav]=readnosepoketxt(filename);

        time(1)=[];time(end)=[];
        behav(1)=[];behav(end)=[];
        
        for n=1:length(behav)
            turnR(n)=strcmp(behav{n},'Eating');
            turnL(n)=strcmp(behav{n},'Face');
            imageR(n)=strcmp(behav{n},'Drinking');
            imageL(n)=strcmp(behav{n},'Sniffing');
            nosepokeR(n)=strcmp(behav{n},'Ano-genital');
            nosepokeL(n)=strcmp(behav{n},'Rearing');
        end
        turnRseq=find(turnR==1);
        turnLseq=find(turnL==1);
        turnseq=sort([turnRseq turnLseq]);
        turn=behav(turnseq);
        imageRseq=find(imageR==1);
        imageLseq=find(imageL==1);
        imageseq=sort([imageRseq imageLseq]);
        image=behav(imageseq);
        
        for n=1:length(image)
            if n<length(image)
                nosepoke{n}=behav(time>time(imageseq(n)) & time<time(turnseq(n+1)));
            else nosepoke{n}=behav(time>time(imageseq(n)));
            end
        end
        nosepoke=nosepoke';
        
        turncol=zeros(size(turn));imagecol=zeros(size(image));
        turncol(strcmp(turn,'Eating'))=1;imagecol(strcmp(image,'Drinking'))=1;
        nosepokecol=NaN(size(nosepoke,1),10);
        for k=1:length(nosepoke)
            nosepokecol(k,1:length(strcmp(nosepoke{k},'Ano-genital')'))=strcmp(nosepoke{k},'Ano-genital')';
        end
        if isnan(nosepokecol(end,1))
            nosepokecol(end,:)=[];turncol(end)=[];imagecol(end)=[];
        end
        save([path1,'mouse',num2str(mousenum),cond,'video','.mat'],'turncol','imagecol','nosepokecol');
        clearvars time behav turnR turnL imageR imageL nosepokeR nosepokeL turnRseq turnLseq...
            turnseq turn imageRseq imageLseq imageseq image nosepoke turncol imagecol nosepokecol
    end
end
