clear all;
close all;
outp=[];nums=[];


path='D:\';
pathout='D:\OutputSignals\'; 
recorddates=strvcat('230215_L');%day month year
tank='BDRtanks';

maxep=21600; samp=257; epochl=4;
f1=2.569901428222656e+002;
f2=256;

f12=f1-f2;
sam=1/f12;
num_chunks=4;
tail_length=20000;
visualize=0;
fs=256;
fs1=f1;
fsh12=fs*epochl*maxep;

p1=0.5; p2=100; s1=0.1; s2=120;
Wp=[p1 p2]/(fs/2); Ws=[s1 s2]/(fs/2); Rp=3; Rs=20; [n, Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[bb1,aa1]=cheby2(n,Rs,Wn);

notchfilter=50;Qfactor=100;Wo = notchfilter/(fs/2); BW = Wo/Qfactor; [bb2,aa2] = iirnotch(Wo,BW);

numanim=4;
numch=4;
channames=strvcat('fro','occ','foc','emg');
mousenames=strvcat('Li8','Bdr2','Opto2','Bdr3');

for day=1
    for ld=1:1
        
        recorddate=recorddates(day,:);
        block=['Li8_Bdr2_OPTO2_Bdr3_',recorddate]
        
        for mouse=[2 3 4]
            
            outp=[];
            
            if mouse==1
                mousename=mousenames(1,:);events123=['Anm1'];chan=17;
            elseif mouse==2
                mousename=mousenames(2,:);events123=['Anm2'];chan=97;
            elseif mouse==3
                mousename=mousenames(3,:);events123=['Anm3'];chan=113;
            elseif mouse==4
                mousename=mousenames(4,:);events123=['Anm4'];chan=49;
            end
            mousename(isspace(mousename))=[];
            
            maxfreq=25000000; maxret = 1000000; maxevents = 1000000;step=10000;
            TTX = actxcontrol('TTank.X');
            % Then connect to a server.
            invoke(TTX,'ConnectServer', 'Local', 'Me')
            invoke(TTX,'OpenTank', [path tank], 'R')
            
            % Select the block to access
            invoke(TTX,'SelectBlock', block)
            invoke(TTX, 'ResetGlobals')
            invoke(TTX, 'SetGlobalV', 'MaxReturn', maxret)
            TTX.CreateEpocIndexing;
            % pause
            ts = [];
            
            i=1;
            events=1;
            while events>0     % reads events in steps
                events = invoke(TTX, 'ReadEventsV', maxevents, events123(1,:), 0, 0, ((i-1)*step), (i*step), 'ALL');
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
            
            %LFP
%             event='LFPs';
%             sig=[];count=1;
%             for i=1:length(Tstamps)
%                 i
%                 if count<length(Tstamps)
%                     t1=Tstamps(i); t2 = Tstamps(i+1)-0.0001;
%                 else
%                     t1=Tstamps(end); t2 = 0;
%                 end;
%                 
%                 invoke(TTX, 'SetGlobalV', 'T1', t1);
%                 invoke(TTX, 'SetGlobalV', 'T2', t2);
%                 invoke(TTX, 'SetGlobalV', 'Channel', chan);
%                 L = invoke(TTX, 'ReadEventsV', maxret, event, chan, 0, t1, t2, 'ALL');
%                 y = invoke(TTX,'ReadWavesV',event);
%                 
%                 sig=[sig y'];
%                 count=count+1;
%                 
%             end;
%             
%             sig=sig*10^6;
%             
%             resampled_sig=resampling(sig,f1,f2,num_chunks,tail_length,visualize); clear sig_or;
%             if length(resampled_sig)<fsh12
%                 sig=resampled_sig(1:end);
%             else
%                 sig=resampled_sig(1:fsh12);
%             end
%             
%             sig(find(abs(sig)>5000))=0;
%             lfp=filtfilt(bb1,aa1,sig);
%             
%             fnout=[tank,'-',mousename,'-',recorddate,'-lfp'];
%             
%             eval(['save ',pathout,fnout,'.mat sig resampled_sig -mat']);
%             
%             lfp=sig;
%             
%             clear sig;
            
            % EEGs, EMG
            event = events123;
            
            for chan = 1:numch
                %if chan==3 continue; end
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
                if length(resampled_sig)<fsh12
                    signal=resampled_sig(1:end);
                    
                else
                    signal=resampled_sig(1:fsh12);
                end
                nums=[nums length(signal)];
                
                signal(find(abs(signal)>5000))=0;
                
                if chan<4
                    signal=filtfilt(bb1,aa1,signal);
                else
                    signal=filtfilt(bb2,aa2,signal);
                end
                
                fnout=[tank,'-',mousename,'-',recorddate,'-',channames(chan,:)];
                
                eval(['save ',pathout,fnout,'.mat resampled_sig -mat']);
                
                clear sig;
                
            end;
            
        end;
    end
end
