close all
clear all

pathin='D:\Dropbox\VDT_EEG\ExtendedVDT\OutputVDTtrials\';

recorddates=strvcat('160714','150714','220814','220814','150714'); %day month year
mousenames=strvcat('Alan','Watson','Charles','Steve');

cols='rbmckg';

numanim=size(mousenames,1);
wind1=4;
wind2=12;
fs=256;
pers=10;
x=1:1:pers;

epochl=4;

p1=6; p2=9; s1=5; s2=10;Wp=[p1 p2]/(fs/2); Ws=[s1 s2]/(fs/2); Rp=3; Rs=20; [n, Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[bb,aa]=cheby2(n,Rs,Wn);

MMf=[]; MMo=[]; SSf=[]; SSo=[];
    for ti=1:2

    
    Mf=[]; Mo=[];
for mouse=1:3;

        mousename=mousenames(mouse,:); mousename(isspace(mousename))=[];

        fnout1=[mousename,'-',recorddates(mouse,:), '-NumTrials'];
        eval(['load ',pathin,fnout1,'.mat T numtr -mat']); % to get the number of trials

        fnin=[mousename,'-',recorddates(mouse,:), '-VDTtrials'];
        eval(['load ',pathin,fnin,'.mat INI VDTtr -mat']); % to get the number of trials

        out1=find(T(:,3)+T(:,4)>0);
        out2=find(VDTtr(:,2)+VDTtr(:,2)==0);

        out=unique([out1;out2]);

        trials=1:length(INI); trials(out)=[];
        numtr=length(trials);
        VDTtr(out,:)=[];

        VDTtr=[VDTtr(:,1) VDTtr(:,2)+VDTtr(:,3)];

        lat=VDTtr(:,2)-VDTtr(:,1);

        lat=ceil(lat*fs);

        Tf=[]; To=[];

        if ti==1 sTR=1; eTR=50; else sTR=numtr-50+1; eTR=numtr; end


        for st=sTR:eTR

            stl=lat(st);

            fnout=[mousename,'-',recorddates(mouse,:), '-Trial',num2str(trials(st))];
            eval(['load ',pathin,fnout,'.mat event f o e t1 VDT -mat']); % save VDT data ind

            theta1=filtfilt(bb,aa,f);instAmp1 = abs(hilbert(theta1));
            theta2=filtfilt(bb,aa,o);instAmp2 = abs(hilbert(theta2));

            %         instAmp1=instAmp1/mean(instAmp1(64:4032))*100;
            %         instAmp2=instAmp2/mean(instAmp2(64:4032))*100;

            %             instAmp1=instAmp1/mean(instAmp1(64:fs*4))*100;
            %             instAmp2=instAmp2/mean(instAmp2(64:fs*4))*100;


                                instAmp1=instAmp1/mean(instAmp1(1:fs*4))*100;
                                instAmp2=instAmp2/mean(instAmp2(1:fs*4))*100;


            instAmp1(1:wind1*fs)=[];instAmp2(1:wind1*fs)=[];
            instAmp1=instAmp1';instAmp2=instAmp2';
            re=rem(stl,pers);
%pause
            instAmp1=instAmp1(1:stl-re);i1=mean(reshape(instAmp1,(stl-re)/pers,pers));
            instAmp2=instAmp2(1:stl-re);i2=mean(reshape(instAmp2,(stl-re)/pers,pers));
            
            i1(end)=NaN; i2(end)=NaN;

            Tf=[Tf;i1]; To=[To;i2];

        end

        mf=nanmean(Tf); mo=nanmean(To);
        Mf=[Mf; mf]; Mo=[Mo; mo];

    end

     MMf=[MMf;nanmean(Mf)]; MMo=[MMo;nanmean(Mo)];
     SSf=[SSf;nanstd(Mf)/sqrt(3)]; SSo=[SSo;nanstd(Mo)/sqrt(3)];
%     subplot(1,2,1)
% 
%     errorbar(x,Mf(1,:),Sf(1,:),['o-b'],'LineWidth',2)
%     hold on
%     errorbar(x,Mf(2,:),Sf(2,:),['o-r'],'LineWidth',2)
%     axis([0.5 pers+0.5 20 50])
%     grid on
%     ylabel('Theta amplitude (uV)')
%     legend('first 50 trials','last 50 trials'); legend('boxoff')
%     xlabel('Time [Initiation - Touch]')
% 
%     subplot(1,2,2)
% 
%     errorbar(x,Mo(1,:),So(1,:),['o-b'],'LineWidth',2)
%     hold on
%     errorbar(x,Mo(2,:),So(2,:),['o-r'],'LineWidth',2)
%     grid on
%     %    plot([0 100],[0 0],'-k')
%     axis([0.5 pers+0.5 20 50])
%     xlabel('Time [Initiation - Touch]')
% 
end


    subplot(1,2,1)

    errorbar(x,MMf(1,:),SSf(1,:),['o-b'],'LineWidth',2)
    hold on
    errorbar(x,MMf(2,:),SSf(2,:),['o-r'],'LineWidth',2)
    axis([0.5 pers+0.5 80 160])
    plot([0 100],[0 0],'-k')
    grid on
    ylabel('Theta amplitude (% of before initiation)')
    legend('first 50 trials','last 50 trials'); legend('boxoff')
    xlabel('Time [Initiation - Touch]')

    subplot(1,2,2)

    errorbar(x,MMo(1,:),SSo(1,:),['o-b'],'LineWidth',2)
    hold on
    errorbar(x,MMo(2,:),SSo(2,:),['o-r'],'LineWidth',2)
    grid on
    plot([0 100],[0 0],'-k')
    axis([0.5 pers+0.5 80 160])
    xlabel('Time [Initiation - Touch]')
