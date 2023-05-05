% ReadSpectraVSmouses
clear all
close all

path='L:\VVyazovskiy\Collaborators\Archives\';
pathfig=[path,'\Figures']; mkdir(pathfig)
%mousename='Russell';
mousenames=strvcat('Alan','Charles','Claude','Crick','Hugh','Russell','Sherlock','Steve','Watson');
days=['190714';'030814';'260614';'260614';'140614';'140614';'030814';'190714';'170714';];
ders='fo';
f=0:0.25:20;
x=1:1:21600;
zermat=zeros(1,21600);
x=x/900;
cols='br'
dernames=strvcat('Frontal','Occipital')

h=0.5:1:24;
numanim=size(mousenames,1);
pathin=[path,'\outputVS\'];
for n=1:numanim
    mouse=mousenames(n,:); mouse(isspace(mouse))=[];
    day=days(n,:);
    figure
    
    for d=1:2
        der=ders(d)
        fn=[mouse,'-',day,'-',der,'-VSspec'];
        eval(['load ',pathin,fn,'.mat spectr w nr r w1 nr2 r3 mt -mat']);
        
        W=zermat; W([w w1])=1;N=zermat; N([nr nr2])=1; R=zermat; R([r r3])=1;
        
        art=[w1 nr2 r3 mt'];
        
        swa=mean(spectr(:,3:17),2);
        swa(art)=NaN;
        
        subplot('position',[0.1 0.95-0.28*d 0.8 0.2]);
        while length(swa)<21600
            swa=[swa;0];
        end
        if length(swa)>21600
            swa=swa(1:21600);
        end
        bar(x,swa);
        set(gca,'XTick',[0:2:24])
        hold on
        plot([12 12],[0 300],'-k')
        %     if d==2
        %         barh(max(max(swa))*1.05,24,5,'k'); barh(max(max(swa))*1.05,12,5,'w');
        %     else
        %         barh(max(max(swa))*1.05,24,10,'k'); barh(max(max(swa))*1.05,12,10,'w');
        %     end
        
        ylabel('SWA [\muV^2/0.25 Hz]')
        axis([0 24 0 max(max(swa))*1.1])
        title([mouse,day,dernames(d,:)],'Fontsize',20)
        
    end
    
    for vs=1:3
        if vs==1 v=W; elseif vs==2 v=N; else v=R; end;
        subplot('position',[0.1 0.3-0.011*(vs-1) 0.8 0.011]);
        bar(x,v,1); axis ([0 24 0 1]);
        set(gca, 'YTick', []); set(gca, 'XTick', []);
        if vs==3 set(gca, 'XTick', [0:2:max(x)]); xlabel('Time [Hours]'); end
    end;
    
    saveas(gcf,[pathfig,'\',mouse,'-',day,'-SWAhypno'],'jpg')
    
    figure
    
    SWA=[];
    for d=1:2
        der=ders(d)
        fn=[mouse,'-',day,'-',der,'-VSspec'];
        eval(['load ',pathin,fn,'.mat spectr w nr r w1 nr2 r3 mt -mat']);
        nonr=[w w1 nr2 r r3 mt'];
        
        swa=mean(spectr(:,3:17),2);
        swa(nonr)=NaN;
        while length(swa)<21600
            swa=[swa;0];
        end
        if length(swa)>21600
            swa=swa(1:21600);
        end
        swaint=nanmean(reshape(swa,900,24));
        swaint=swaint/nanmean(swaint(1:12))*100;
        
        SWA=[SWA;swaint];
    end
    
    plot(h,SWA,['o-'],'LineWidth',2);title([mouse,day],'Fontsize',26)
    hold on
    plot([0 24],[100 100],'-k');
    plot([12 12],[0 300],'-k')
    %barh(252,24,5,'k'); barh(252,12,5,'w');
    axis([0 24 50 255])
    set(gca,'XTick',[0:2:24])
    xlabel('Time [Hours]')
    ylabel('SWA [% of 24-h mean]')
    legend('F','O'); legend('boxoff')
    saveas(gcf,[pathfig,'\',mouse,'-',day,'-meanSWA'],'jpg')
end



