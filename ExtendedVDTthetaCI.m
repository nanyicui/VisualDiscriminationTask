close all
clear all

pathin='L:\VVyazovskiy\Collaborators\VDT_EEG\ExtendedVDT\OutputVDTtrials\';

recorddates=strvcat('160714','150714','220814','220814','150714'); %day month year
mousenames=strvcat('Alan','Watson','Sherlock','Charles','Steve');

cols='rbmckg';

numanim=5;
wind1=4;
wind2=12;
fs=256;

epochl=4;

p1=6; p2=9; s1=5; s2=10;Wp=[p1 p2]/(fs/2); Ws=[s1 s2]/(fs/2); Rp=3; Rs=20; [n, Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[bb,aa]=cheby2(n,Rs,Wn);

for mouse=1:numanim
    figure
    for ci=1:3

        mousename=mousenames(mouse,:); mousename(isspace(mousename))=[];

        fnout1=[mousename,'-',recorddates(mouse,:), '-NumTrials'];
        eval(['load ',pathin,fnout1,'.mat T numtr -mat']); % to get the number of trials

        fnin=[mousename,'-',recorddates(mouse,:), '-VDTtrials'];
        eval(['load ',pathin,fnin,'.mat x INI VDTtr -mat']); % to get the number of trials
    
        out1=find(T(:,3)+T(:,4)>0);

        if ci==1
            out2=find(VDTtr(:,2)==0);
        elseif ci==2
            out2=find(VDTtr(:,3)==0);
        else
            out2=find(VDTtr(:,2)+VDTtr(:,3)>0);
        end
       
        out=unique([out1;out2]);
        trials=1:length(INI); trials(out)=[];
        numtr=length(trials);
        VDTtr(out,:)=[];
        if ci==1 
            lat=VDTtr(:,2)-VDTtr(:,1); 
        elseif ci==2
            lat=VDTtr(:,3)-VDTtr(:,1);
        else lat(1:size(VDTtr,1))=4;
        end

        Tf=[]; To=[];

        for st=1:numtr

            fnout=[mousename,'-',recorddates(mouse,:), '-Trial',num2str(trials(st))];
            eval(['load ',pathin,fnout,'.mat event x f o e t1 VDT -mat']); % save VDT data ind

            theta1=filtfilt(bb,aa,f);instAmp1 = abs(hilbert(theta1));
            theta2=filtfilt(bb,aa,o);instAmp2 = abs(hilbert(theta2));
            
            instAmp1=instAmp1/mean(instAmp1(64:4032))*100;
            instAmp2=instAmp2/mean(instAmp2(64:4032))*100;

            Tf=[Tf;instAmp1']; To=[To;instAmp2'];

        end

        mf=nanmean(Tf); mo=nanmean(To);
        if mouse==3 mo(1:fs*12)=NaN; end
        
        subplot(1,3,ci)

        plot(x,mf,['.-',cols(ci*2-1)],'LineWidth',ci)
        % pause
        hold on
        plot(x,mo,['.-',cols(ci*2)],'LineWidth',ci)
        axis([-2 6 0 200])
        hold on
        plot([0 0],[-100 200],'-k')
        %bar([0:0.25:6],histc(lat,[0:0.25:6]))
        
        %pause

    end
end


