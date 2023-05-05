close all
clear all

pathin='i:\ExtendedVDT\OutputVDTtrials\';

recorddates=strvcat('160714','150714','220814','220814','150714'); %day month year
mousenames=strvcat('Alan','Watson','Sherlock','Charles','Steve');

cols='rbmckg';

numanim=size(mousenames,1);
wind1=4;
wind2=12;
fs=256;
pa=16;
sec=6;
pers=pa*sec;
x=-1+0.01:1/pa:sec-1;

epochl=4;

p1=6; p2=9; s1=5; s2=10;Wp=[p1 p2]/(fs/2); Ws=[s1 s2]/(fs/2); Rp=3; Rs=20; [n, Wn]=cheb2ord(Wp,Ws,Rp,Rs);
[bb,aa]=cheby2(n,Rs,Wn);

MMf=[]; MMo=[];
for mouse=1:numanim

    Mf=[]; Mo=[];
    for ci=1:3

        mousename=mousenames(mouse,:); mousename(isspace(mousename))=[];

        fnout1=[mousename,'-',recorddates(mouse,:), '-NumTrials'];
        eval(['load ',pathin,fnout1,'.mat T numtr -mat']); % to get the number of trials

        fnin=[mousename,'-',recorddates(mouse,:), '-VDTtrials'];
        eval(['load ',pathin,fnin,'.mat INI VDTtr -mat']); % to get the number of trials
        %pause
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
        else
            lat(1:size(VDTtr,1))=5;
        end

        lat=ceil(lat*fs);

        Tf=[]; To=[];

        for st=1:numtr

            stl=lat(st); if stl>fs*8 continue; end

            fnout=[mousename,'-',recorddates(mouse,:), '-Trial',num2str(trials(st))];
            eval(['load ',pathin,fnout,'.mat event f o e t1 VDT -mat']); % save VDT data ind

            theta1=filtfilt(bb,aa,f);instAmp1 = abs(hilbert(theta1));
            theta2=filtfilt(bb,aa,o);instAmp2 = abs(hilbert(theta2));

            instAmp1=instAmp1/mean(instAmp1(65:4032))*100;
            instAmp2=instAmp2/mean(instAmp2(65:4032))*100;

            instAmp1(1:wind1*fs)=[];instAmp2(1:wind1*fs)=[];
           
            if stl-fs+1<1 continue; end
            if stl+fs*5>length(instAmp1) continue; end
            
            instAmp1=instAmp1(stl-fs+1:stl+fs*5);
            instAmp2=instAmp2(stl-fs+1:stl+fs*5);
            
            i1=median(reshape(instAmp1,fs/pa,pa*sec));
            i2=median(reshape(instAmp2,fs/pa,pa*sec));

            Tf=[Tf;i1]; To=[To;i2];
        end

        mf=nanmedian(Tf); mo=nanmedian(To);
        if mouse==3 mo(1:pers)=NaN; end

        Mf=[Mf mf]; Mo=[Mo mo];

    end

    MMf=[MMf;Mf]; MMo=[MMo;Mo];

end

mf=nanmean(MMf); mo=nanmean(MMo);
sf=nanstd(MMf)/sqrt(size(MMf,1)); so=nanstd(MMo)/sqrt(size(MMo,1));

mf=reshape(mf,pers,3);mo=reshape(mo,pers,3);
sf=reshape(sf,pers,3);so=reshape(so,pers,3);

for v=1:3
    subplot(1,3,v)
    m1=mf(:,v);m2=mo(:,v);
    s1=sf(:,v);s2=so(:,v);

    errorbar(x,m1,s1,['o-',cols(v*2-1)],'LineWidth',2)
    hold on
    errorbar(x,m2,s2,['s-',cols(v*2)],'LineWidth',2)
    plot([-1 100],[100 100],'-k')
    plot([0 0],[0 200],'-k')
    axis([-1 5 60 140])
end
