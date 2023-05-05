close all
clear all

pathin='o:\ExtendedVDT\OutputVDTtrials\';

recorddates=strvcat('160714','150714','220814','150714'); %day month year
mousenames=strvcat('Alan','Watson','Charles','Steve');

cols='rbmckg';

numanim=4;

nums=12*60*60
zermat=zeros(1,nums);

int=5;

for mouse=1:numanim

    figure
    
    mousename=mousenames(mouse,:); mousename(isspace(mousename))=[];

    fnin=[mousename,'-',recorddates(mouse,:), '-VDTtrials'];
    eval(['load ',pathin,fnin,'.mat x INI VDTtr -mat']); % to get the number of trials

    do=find(VDTtr(:,2)>0 & VDTtr(:,3)>0);
    di=[];
    for d=1:length(do);
        di=[di;VDTtr(do(d),2)-VDTtr(do(d),3)];
    end
    po=find(di<0); VDTtr(do(po),3)=0;
    ne=find(di>0); VDTtr(do(ne),2)=0;

    %if mouse==1 out=find(VDTtr(:,1)>2.8*10^4); VDTtr(out,:)=[]; end

    cor=find(VDTtr(:,2)>0);
    inc=find(VDTtr(:,3)>0);
    omi=find(VDTtr(:,2)+VDTtr(:,3)==0);
    
    VDTc=VDTtr; VDTc(omi,:)=[];
    
    stt=ceil(VDTc(:,1));
    TCcor=zermat;TCcor(stt)=1;
    TCcor=reshape(TCcor,int*60,nums/(int*60));
    NtrC=sum(TCcor)/int;
    
    VDTc=[VDTc(:,1) VDTc(:,2)+VDTc(:,3)];
    
    Lcor=VDTc(:,2)-VDTc(:,1);
    RCorL=zermat; RCorL(stt)=Lcor; RCorL(RCorL==0)=NaN;
    RCorL=reshape(RCorL,int*60,nums/(int*60));
    LtrC=nanmean(RCorL);
    
    out=find(sum(TCcor)<2); LtrC(out)=NaN;
    
    x=1:1:length(NtrC); 
    x=(x*int-int/2)/60;
    
    subplot(2,1,1)
    plot(x,NtrC,'.-','LineWidth',2)
    axis([0 6 0 4])
    title(['mouse ',num2str(mouse)]);
    xlabel('Time [hours]')
    ylabel('Number of trials')
    grid on
    set(gca,'XTick',[0:2:12])
    
     subplot(2,1,2)
    bar(x,LtrC,1)
    axis([0 6 0 4])
    xlabel('Time [hours]')
    ylabel('Latency [Initiation - Touch]')
    grid on
    set(gca,'XTick',[0:1:12])
    
end


