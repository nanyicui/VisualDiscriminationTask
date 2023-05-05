close all
clear all

pathout='L:\VVyazovskiy\Collaborators\VDT_EEG\ExtendedVDT\OutputVDTtrials\';

recorddates=strvcat('160714','150714','160714','220814','220814','150714'); %day month year
mousenames=strvcat('Alan','Watson','Watson','Sherlock','Charles','Steve');

fs=256;

p1=1; p2=20; s1=0.5; s2=25;Wp=[p1 p2]/(fs/2); Ws=[s1 s2]/(fs/2); Rp=3; Rs=20; [n, Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[bb,aa]=cheby2(n,Rs,Wn);

p1=6; p2=9; s1=5; s2=10;Wp=[p1 p2]/(fs/2); Ws=[s1 s2]/(fs/2); Rp=3; Rs=20; [n, Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[bb1,aa1]=cheby2(n,Rs,Wn);

numanim=7;
cols='rmb';
wind1=4;
wind2=12;

for mouse=6:6
    
    mousename=mousenames(mouse,:); mousename(isspace(mousename))=[];
    
    fnin=[mousename,'-',recorddates(mouse,:), '-VDTtrials'];
    eval(['load ',pathout,fnin,'.mat x INI -mat']); % to get the number of trials
    
    numtr=length(INI);
    T=[];
    
    for st=248:numtr
        
        myFig = figure; set(myFig, 'Position',[100 200 700 900]);
        
        fnout=[mousename,'-',recorddates(mouse,:), '-Trial',num2str(st)];
        eval(['load ',pathout,fnout,'.mat event x f o e t1 VDT -mat']); % save VDT data ind
        
        vv=find(VDT);
        
        theta1=filtfilt(bb1,aa1,f);
         theta2=filtfilt(bb1,aa1,o);
         
        f=filtfilt(bb,aa,f);
        o=filtfilt(bb,aa,o);
        
        subplot(3,1,1)
        plot(x,f,'-r');
        hold on
        plot(x,theta1,'-k');
        hold on
        axis([-wind1 wind2 -500 500])
        grid on
        ylabel('EEG frontal (uV)')
        title([mousename,', ',recorddates(mouse,:), ', Trial: ',num2str(st),', second: ',num2str(t1), ', epoch: ',num2str(ceil(t1/4))])
        
        subplot(3,1,2)
        plot(x,o,'-b');
        hold on
        plot(x,theta2,'-k');
        hold on
        plot([0 0],[-1000 1000],'-k','LineWidth',4)
        axis([-wind1 wind2 -500 500])
        grid on
        ylabel('EEG occipital (uV)')
        
        subplot(3,1,3)
        plot(x,e,'-k');
        hold on
        plot([0 0],[-1000 1000],'-k','LineWidth',2)
        axis([-wind1 wind2 -500 500])
        grid on
        xlabel('Time [seconds]')
        ylabel('EMG (uV)')
        
        for p=1:3
            subplot(3,1,p); for v=1:length(vv) pv=VDT(vv(v))-t1-wind1; plot([pv pv],[-1000 1000],['-',cols(vv(v))],'LineWidth',4); end
        end
       
        before = waitinput('Before INI : ',1000);
        after = waitinput('After INI  ',1000);
        T=[T;mouse st before after];
        
        close (myFig)
               
    end
   fnout1=[mousename,'-',recorddates(mouse,:), '-NumTrials'];
    eval(['save ',pathout,fnout1,'.mat T numtr -mat']); % to get the number of trials
    
end

