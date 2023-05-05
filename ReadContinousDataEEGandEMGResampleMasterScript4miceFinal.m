clear all;
close all;
outp=[];nums=[];

recorddates=strvcat('030814');%day month year


mousenames=strvcat('Sherlock','Charles','Freud');
%mousenames=strvcat('Alan','Watson','Steve');

events1234=[1 2 3];

tank='Batch6';
epochl=4;
path='L:\VVyazovskiy\Collaborators\';
pathout='D:\Batch6\';
pathRW='D:\Batch6\RW\';

maxep=21600; epochl=4;

f1=2.569901428222656e+002;
f2=256;

num_chunks=4;
tail_length=20000;
visualize=0;
fs=256;
fsh24=fs*epochl*maxep;

fsh24=fs*epochl*maxep;
pathoutMAT=[pathout,''];mkdir(pathoutMAT)
pathoutEDF=[pathout,'outputEDFs\']; mkdir(pathoutEDF)

numanim=size(mousenames,1);
numdays=size(recorddates,1);
numch=3;

channames=strvcat('fro','occ','emg');

notchfilter=50;Qfactor=100;Wo = notchfilter/(fs/2); BW = Wo/Qfactor; [b,a] = iirnotch(Wo,BW); % notch filter

for mouse=1:numanim
    
    event=['Anm',num2str(events1234(mouse))]
    
    mousename=mousenames(mouse,:); mousename(isspace(mousename))=[]
    rwevent = ['WHE',num2str(events1234(mouse))]
    
    for day=1:numdays
        
        recorddate=recorddates(day,:);
        block=['Sh_Ch_Fr_',recorddate];
        
        maxfreq=25000000; maxret = 1000000; maxevents = 1000000;step=10000;
        TTX = actxcontrol('TTank.X');
        % Then connect to a server.
        invoke(TTX,'ConnectServer', 'Local', 'Me')
        invoke(TTX,'OpenTank', [path tank], 'R')
        
        fourthcol=zeros(24*60*60*256,1);
        % Select the block to access
        invoke(TTX,'SelectBlock', block);
        invoke(TTX, 'ResetGlobals');
        invoke(TTX, 'SetGlobalV', 'MaxReturn', maxret)
        TTX.CreateEpocIndexing;
        % TimeRanges=TTX.GetEpocsV(rwevent,0,0,maxret);
        
        ts = [];
        
        i=1;
        events=1;
        while events>0     % reads events in steps
            events = invoke(TTX, 'ReadEventsV', maxevents, event, 0, 0, ((i-1)*step), (i*step), 'ALL');
            if (events > 0)
                % if events were found, the timestamps are collected
                timestamps = invoke(TTX, 'ParseEvInfoV', 0, events, 6);
                ts = cat(2, ts, timestamps(1,end));
            end
            length(ts);
            %pause
            i=i+1;
        end
        Tstamps=[0 ts]; clear ts;
        
        t1=0; t2=0;
        
        for chan = 1:numch
            sig=[];
            count=1;
            for i=1:length(Tstamps)
                i
                if count<length(Tstamps)
                    t1=Tstamps(i); t2 = Tstamps(i+1)-0.0001;
                else
                    t1=Tstamps(end); t2 = 0;
                end;
                
                invoke(TTX, 'SetGlobalV', 'T1', t1);
                invoke(TTX, 'SetGlobalV', 'T2', t2);
                invoke(TTX, 'SetGlobalV', 'Channel', chan);
                L = invoke(TTX, 'ReadEventsV', maxret, event, chan, 0, t1, t2, 'ALL');
                y = invoke(TTX,'ReadWavesV',event);
                
                sig=[sig y'];
                count=count+1;
                
            end;
            
            sig=sig*10^6;
            resampled_sig=resampling(sig,f1,f2,num_chunks,tail_length,visualize); clear sig_or;
            
            resampled_sig=filtfilt(b,a,resampled_sig); % notch filter
            
            lsig=length(resampled_sig);
            if lsig<fsh24
                out=rem(lsig,fs*epochl);
                resampled_sig(lsig-out+1:end)=[];
                signal=resampled_sig;
                fourthcol=fourthcol(1:length(resampled_sig));
            else
                signal=resampled_sig(1:fsh24);
            end
            signal(abs(signal)>1000)=0;
            
            
            outp=[outp signal']; clear signal;
            
            fnout=[tank,'-',mousename,'-',recorddate,'-',channames(chan,:)];
            
            eval(['save ',pathoutMAT,fnout,'.mat sig resampled_sig -mat']);
            
            clear sig;
            
        end;
        
        fnoutTXT=[tank,'-',mousename,'-EEG-EMG-RW-',recorddate];
        % load running wheel data and then add it to the fourth col of
        % outp
        load([pathRW tank '-' mousename '-' recorddate '-' rwevent '.mat'])
        
        
        fourthcol(round(TimeRanges(2,:))*256)=1;
        
        if size(fourthcol,1)>size(outp,1)
            fourthcol=fourthcol(1:size(outp,1),:);
        end
        
        outp=[outp fourthcol];
        
        eval(['save ',pathoutEDF,fnoutTXT,'.txt outp -ascii']);
        
        clear Tstamps;
        outp=[];
        
    end;
end


