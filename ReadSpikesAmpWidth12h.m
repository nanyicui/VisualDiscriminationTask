clear all;
close all;

pathout='d:\OutputSpikes\'; mkdir(pathout)
path='d:\';

maxret = 1000000;
recorddates=strvcat('271114_L1');%day month year

tank='November2014';
maxep=10800;

numanim=4;
numdates=size(recorddates,1);

fs=256;
maxep=10800;
epochl=4;
zermat1=zeros(1,fs*epochl);
zermat2=zeros(2,fs*epochl);

chan1=[10 12]; % channels with good neurons
chan2=[17 32];
chan3=[33 38];
chan4=[49 58];

maxret = 1000000;

TTX = actxcontrol('TTank.X')
% Then connect to a server.
invoke(TTX,'ConnectServer', 'Local', 'Me')

spAnan(1:1024)=NaN;
spN0(1:1024)=0;

% Now open a tank for reading.
invoke(TTX,'OpenTank', tank, 'R')

mousenames=strvcat('Fe','Ar','Ex','Bu');

for anim=1:4
    
    if anim==1
        chans=chan1; mousename=mousenames(1,:);
    elseif anim==2
        chans=chan2; mousename=mousenames(2,:);
    elseif anim==3
        chans=chan3; mousename=mousenames(3,:);
    elseif anim==4
        chans=chan4; mousename=mousenames(4,:);
    end
    
     mousename(isspace(mousename))=[];
    
    for rec=1:numdates
        
        recorddate=recorddates(rec,:)
        
        block=['Fe_Ar_Ex_Bu_',recorddate]
        
        % Select the block to access
        invoke(TTX,'SelectBlock', block)
        invoke(TTX, 'ResetGlobals')
        invoke(TTX, 'SetGlobalV', 'MaxReturn', maxret)
        
        for ch=1:length(chans)
            
            chan=chans(ch);
            
            AmplitudeSP=zeros(maxep*fs*epochl,1); NumberSP=zeros(maxep*fs*epochl,1); %sap=zermat;
            %maxep=50
            IndSpikes=[];
            for i=1:maxep
                
                st=fs*epochl*i-fs*epochl+1; en=fs*epochl*i;
                
                if rem(i,100)==0
                    i
                    mousename
                    recorddate
                end
                
                t1=(i-1)*epochl;
                t2=i*epochl;
                
                invoke(TTX, 'SetGlobalV', 'Channel', chan);
                
                spcount2 = invoke(TTX, 'ReadEventsV', maxret, 'eNeu', chan, 0, t1, t2, 'ALL');
                TimeStamps=[]; TimeStamps=invoke(TTX,'ParseEvInfoV',0,spcount2,6);
                Spikes=[]; Spikes=invoke(TTX,'ParseEvV',0,spcount2)*10^6;
                
               % pause
                
                %out=find(max(Spikes,[],1)>1000); Spikes()
                
                nsp=size(Spikes,2);
                if nsp<2
                    AmplitudeSP(st:en)=spAnan';
                    NumberSP(st:en)=spN0';
                else
                    stend=[];
                    for sp=1:nsp
                        actp=Spikes(:,sp);
                        if max(actp(1:10))<=0 actp(1)=1; end;
                        if max(actp(11:end))<=0 actp(end)=1; end
                        
                        ac1=find(flipud(actp(1:10))>0); 
                        acst=10-ac1(1)+1;
                        ac2=find(actp(10:end)>0); acen=10+ac2(1)-1;
                        peak=find(diff(actp(acen:end))<0);
                        if length(peak)==0 peak=46; else peak=acen+peak(1)-1; end
                        
                        stend=[stend;acst acen peak min(actp(acst:acen)) actp(peak)];
                        
                     end
                    
                    stend=[TimeStamps' stend];
                    
                    IndSpikes=[IndSpikes;stend];
                    
                    [ma1,ma2]=max(Spikes,[],1);[mi1,mi2]=min(Spikes,[],1);
                    amp=ma1-mi1;
                    
                    inde=t1:1/fs:t2; inde1=t1:1/2048:t2-1/2048;
                    
                    if length(TimeStamps)==0
                        spikesNum=zermat1;spikesAmp=zermat1;
                    else
                        [spN,s2]=histc(TimeStamps,inde);
                        spN=spN(1:fs*epochl);
                        [a1,a2]=histc(TimeStamps,inde1);
                        amp(a2==0)=[]; a2(a2==0)=[];
                        a1(a2)=amp;
                        a1(a1==0)=NaN;
                        spA=nanmean(reshape(a1,8,fs*epochl));
                    end;
                    
                    st=fs*epochl*i-fs*epochl+1; en=fs*epochl*i;
                    
                    AmplitudeSP(st:en)=spA';
                    NumberSP(st:en)=spN';
                end
            end;
            
            AmplitudeSP(find(isnan(AmplitudeSP)==1))=0;
            
            fnout=[mousename,'-',recorddate,'-ch',num2str(chan),'-spikes'];
            eval(['save ',pathout,fnout,'.mat IndSpikes AmplitudeSP NumberSP -mat']);
            clear AmplitudeSP NumberSP;
        end
    end;
end