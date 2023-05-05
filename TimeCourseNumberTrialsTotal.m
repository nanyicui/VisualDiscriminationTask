close all
clear all

pathin='D:\Dropbox\VDT_EEG\ExtendedVDT\OutputVDTtrials\';

recorddates=strvcat('160714','150714','220814','150714'); %day month year
mousenames=strvcat('Alan','Watson','Charles','Steve');

cols='brk';

nums=12*60*60
zermat=zeros(1,nums);
mouse=3
int=5;
figure
for vvv=1:3
    
    mousename=mousenames(mouse,:); mousename(isspace(mousename))=[];

    fnin=[mousename,'-',recorddates(mouse,:), '-VDTtrials'];
    eval(['load ',pathin,fnin,'.mat x INI VDTtr -mat']); % to get the number of trials

%     do=find(VDTtr(:,2)>0 & VDTtr(:,3)>0);
%     di=[];
%     for d=1:length(do);
%         di=[di;VDTtr(do(d),2)-VDTtr(do(d),3)];
%     end
%     po=find(di<0); VDTtr(do(po),3)=0;
%     ne=find(di>0); VDTtr(do(ne),2)=0;

    %if mouse==1 out=find(VDTtr(:,1)>2.8*10^4); VDTtr(out,:)=[]; end

    cor=find(VDTtr(:,2)>0);
    inc=find(VDTtr(:,3)>0);
    omi=find(VDTtr(:,2)+VDTtr(:,3)==0);

    if vvv==1
        VDTc=VDTtr(cor,:);
    elseif vvv==2
        VDTc=VDTtr(inc,:);
    else
        VDTc=VDTtr(omi,:);
    end
%pause
    stt=ceil(VDTc(:,1));
    TCcor=zermat;TCcor(stt)=1;
    TCcor=reshape(TCcor,int*60,nums/(int*60));
    NtrC=sum(TCcor);

    x=1:1:length(NtrC);
    x=(x*int-int/2)/60;

    %subplot(2,1,1)
    plot(x,NtrC,['.-',cols(vvv)],'LineWidth',2)
    axis([0 6 0 20])
    title(['mouse ',num2str(mouse)]);
    xlabel('Time [hours]')
    ylabel('Number of trials')
    grid on
    set(gca,'XTick',[0:1:12])
    hold on
end

legend('Correct','Incorrect','Omissions')
