clear all;
close all;
outp=[];nums=[];

epochl=4;
path='d:';
pathSignals='d:\OutputSignals\';
pathRW='d:\OutputRW\';
pathSpikes='d:\OutputSpikes\';
pathVDT='d:\OutputVDTtrials\';

recorddates=strvcat('271114_L1');%day month year

tank='November2014';

maxep=10800; epochl=4;
fs=256;
fsh12=fs*epochl*maxep;

pathoutEDF=['d:\outputEDFs\']; 

notchfilter=50;Qfactor=100;Wo = notchfilter/(fs/2); BW = Wo/Qfactor; [bb2,aa2] = iirnotch(Wo,BW);

numanim=4;
numch=4;
channames=strvcat('lfp','fro','occ','foc','emg');
mousenames=strvcat('Fe','Ar','Ex','Bu');

chan1=[10 12]; % channels with good neurons
chan2=[17 32];
chan3=[33 38];
chan4=[49 58];

for day=1:1
    
    recorddate=[recorddates(day,:)];
    
   for mouse=1:4
        %if mouse==3 continue; end
        if mouse==1
            chans=chan1; mousename=mousenames(1,:); rwevent='RW';
        elseif mouse==2
            chans=chan2; mousename=mousenames(2,:); rwevent='RW';
        elseif mouse==3
            chans=chan3; mousename=mousenames(3,:); rwevent='RW';
            elseif mouse==4
            chans=chan4; mousename=mousenames(4,:); rwevent='RW';
        end
         mousename(isspace(mousename))=[];
        
        output=zeros(fsh12,9);
        
        % LFP, EEG
        for s=1:4
            signame=channames(s,:);
            
            fnout=[tank,'-',mousename,'-',recorddate,'-',signame];
            
            eval(['load ',pathSignals,fnout,'.mat resampled_sig -mat']);
            
            if length(resampled_sig)>fsh12
                signal=resampled_sig(1:fsh12);
            else
                signal=zeros(1,fsh12);
                signal(1:length(resampled_sig))=resampled_sig;
            end
            
            output(:,s)=signal';
            clear resampled_sig signal;
            
        end
        
        % Spikes
        fnout=[mousename,'-',recorddate,'-ch',num2str(chans(1)),'-spikes'];
        eval(['load ',pathSpikes,fnout,'.mat AmplitudeSP -mat']);
        output(:,5)=AmplitudeSP;
        clear AmplitudeSP;
        
        fnout=[mousename,'-',recorddate,'-ch',num2str(chans(2)),'-spikes'];
        eval(['load ',pathSpikes,fnout,'.mat AmplitudeSP -mat']);
        output(:,6)=AmplitudeSP;
        clear AmplitudeSP;
        
        % EMG
        s=5; signame=channames(s,:);
        fnout=[tank,'-',mousename,'-',recorddate,'-',signame];
        eval(['load ',pathSignals,fnout,'.mat resampled_sig -mat']);
        
        if length(resampled_sig)>fsh12
            signal=resampled_sig(1:fsh12);
        else
            signal=zeros(1,fsh12);
            signal(1:length(resampled_sig))=resampled_sig;
        end
        
        output(:,7)=signal';
        clear resampled_sig signal;
       
        % RW-activity
        fnrw=[mousename,'-',recorddate,'-',rwevent];
        eval(['load ',pathRW,fnrw,'.mat TimeRanges rw r  -mat']); % save RW data
        
        if size(TimeRanges,1)>1
            rw=round(TimeRanges(2,:)*fs);rw(rw==0)=[];
            numrw=length(rw);
            
            for n=1:numrw
                st=rw(n)-3; en=rw(n)+3;
                output(st:en,9)=1;
            end
            
        else
            output(1,9)=1;
            
        end
         % VDT
        fnvdt=[mousename,'-',recorddate,'-VDTtrials'];
        eval(['load ',pathVDT,fnvdt,'.mat VDTtr -mat']); % save vdt data
        
        if size(VDTtr,1)>1
            vdt1=round(VDTtr(:,1)*fs);vdt1(vdt1==0)=[];
            numvdt1=length(vdt1);
            vdt2=round(VDTtr(:,2)*fs);vdt2(vdt2==0)=[];
            numvdt2=length(vdt2);
            vdt3=round(VDTtr(:,3)*fs);vdt3(vdt3==0)=[];
            numvdt3=length(vdt3);
            
            for n=1:numvdt1
                st=vdt1(n)-3; en=vdt1(n)+3;
                output(st:en,9)=1;%Initiation
            end
            for n=1:numvdt2
                st=vdt2(n)-3; en=vdt2(n)+3;
                output(st:en,9)=2;%Correct
            end
            for n=1:numvdt3
                st=vdt3(n)-3; en=vdt3(n)+3;
                output(st:en,9)=3;%Incorrect
            end
            
        else
            output(1,9)=1;
            
        end
        
        fnoutTXT=[mousename,'-LFP-EEG-Spikes-EMG-VDT-RW-',recorddate];
        
        eval(['save ',pathoutEDF,fnoutTXT,'.txt output -ascii']);
        
        
    end
end

