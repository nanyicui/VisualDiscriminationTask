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

    %         subplot(2,2,mouse)
    %         bar(VDTtr(:,1),ones(1,size(VDTtr,1)))
    %         axis([0 12*60*60 0 1])


    cor=find(VDTtr(:,2)>0);
    inc=find(VDTtr(:,3)>0);
    omi=find(VDTtr(:,2)+VDTtr(:,3)==0);
    
    VDTc=VDTtr; 
    %VDTc=VDTtr(inc,:); 
    
    stt=ceil(VDTc(:,1));
    TCcor=zermat;TCcor(stt)=1;
    TCcor=reshape(TCcor,int*60,nums/(int*60));
    NtrC=sum(TCcor)/int;
    
    x=1:1:length(NtrC); 
    x=(x*int-int/2)/60;
    
    subplot(2,2,mouse)
    plot(x,NtrC,'.-','LineWidth',2)
    axis([0 12 0 4])
    title(['mouse ',num2str(mouse)]);
    xlabel('Time [hours]')
    ylabel('Number of trials')
    grid on
    set(gca,'XTick',[0:2:12])
    
end


