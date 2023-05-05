        pathname1 = 'D:\Dropbox\Batch4\Batch4rawdata\';
        delimiter = ',';
        startRow = 2;
        
        formatSpec = '%f%f%s%s%s%f%f%s%f%s%s%s%s%s%s%s%s%[^\n\r]';


for animID=1:8
    for cond=1:2

        if cond==1
            condition='CO';
        else condition='SD';
        end
        fileID = fopen([pathname1,'mouse',num2str(animID),condition,'.csv'],'r');
        if fileID<0
            continue
        end
        
        dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
        
        fclose(fileID);
        
        EvntTime = dataArray{:, 1};
        EvntID = dataArray{:, 2};
        EvntName = dataArray{:, 3};
        ItemName = dataArray{:, 4};
        AliasName = dataArray{:, 5};
        GroupID = dataArray{:, 6};
        NumArgs = dataArray{:, 7};
        Arg1Name = dataArray{:, 8};
        Arg1Value = dataArray{:, 9};
        Arg2Name = dataArray{:, 10};
        Arg2Value = dataArray{:, 11};
        Arg3Name = dataArray{:, 12};
        Arg3Value = dataArray{:, 13};
        Arg4Name = dataArray{:, 14};
        Arg4Value = dataArray{:, 15};
        Arg5Name = dataArray{:, 16};
        Arg5Value = dataArray{:, 17};
        
        %% Clear temporary variables
        clearvars fileID ans;
        
        for n=1:length(ItemName)
            Imaesn1(n)=strcmp(ItemName{n},'Correct_Images_Index');    
            birbeam(n)=strcmp(ItemName{n},'BIRBeam #1');
            firbeam(n)=strcmp(ItemName{n},'FIRBeam #1');
            corr(n)=strcmp(ItemName{n},'Correct');
            incorr(n)=strcmp(ItemName{n},'Incorrect');
            trstart(n)=strcmp(ItemName{n},'Start Trial');
            crtntrstart(n)=strcmp(ItemName{n},'Tray Exit Starts Correction Trial');
            
        end
        corrET=EvntTime(corr);
        incorrET=EvntTime(incorr);
        trstartET=EvntTime(trstart);
        crtntrstartET=EvntTime(crtntrstart);
        TS=TSinitiation(trstartET,crtntrstartET,corrET,incorrET);
        beamcross=hist(sort([EvntTime(birbeam)', EvntTime(firbeam)']),[0.5:1:3599.5]);
            
        T=EvntTime(Imaesn1);T(1:5)=[];
        
        for n=2:length(T)
            for m=1:(length(TS)-1)
                trialind(n,m)=TS(m,2)<T(n) && TS(m+1,1)>T(n);
            end
        end
        
        trialind=[zeros(size(trialind,1),1) trialind];trialind(1,1)=1;
        imageind=Arg2Value(Imaesn1);imageind=str2double(imageind);imageind(1:5)=[];
        im_trialind=imageind'*trialind;
        TS=[TS im_trialind'];
        for n=1:length(TS)
            if TS(n,4)==0
                TS(n,4)=TS(n-1,4);
            end
        end
        
        accu_0=TS((TS(:,4)==1),3);accu_0=sum(accu_0)/length(accu_0);
        accu_10=TS((TS(:,4)==3),3);accu_10=sum(accu_10)/length(accu_10);
        accu_20=TS((TS(:,4)==5),3);accu_20=sum(accu_20)/length(accu_20);
        accu_30=TS((TS(:,4)==7),3);accu_30=sum(accu_30)/length(accu_30);
        accu_60=TS((TS(:,4)==9),3);accu_60=sum(accu_60)/length(accu_60);
        accu_70=TS((TS(:,4)==11),3);accu_70=sum(accu_70)/length(accu_70);
        accu_80=TS((TS(:,4)==13),3);accu_80=sum(accu_80)/length(accu_80);
        accu_90=TS((TS(:,4)==15),3);accu_90=sum(accu_90)/length(accu_90);
        accu_all=TS((TS(:,4)>0),3);accu_all=sum(accu_all)/length(accu_all);
        
        save([pathname1,'mouse',num2str(animID),condition,'.mat'],'TS','birbeam','firbeam','beamcross','accu_0','accu_10','accu_20','accu_30','accu_60','accu_70','accu_80','accu_90','accu_all')
        clearvars Imaesn1 birbeam firbeam corr incorr trstart crtntrstart corrET  incorrET trstartET crtntrstartET TS T trialind imageind
    end
end
