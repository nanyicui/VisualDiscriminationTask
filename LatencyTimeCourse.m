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
    
    VDTc=VDTtr(cor,:); Lcor=VDTc(:,2)-VDTc(:,1);
    
    stt=ceil(VDTc(:,1));
    TCcor=zermat;TCcor(stt)=1;
    RCorL=zermat; RCorL(stt)=Lcor; RCorL(RCorL==0)=NaN;
    
    TCcor=reshape(TCcor,int*60,nums/(int*60));
    NtrC=sum(TCcor)/int;
    
    RCorL=reshape(RCorL,int*60,nums/(int*60));
    LtrC=nanmedian(RCorL);
    
    out=find(sum(TCcor)<3); LtrC(out)=NaN;
    
    
    
    subplot(2,2,mouse)
    plot(NtrC,'.-','LineWidth',2)
    %bar(LtrC)
%bar(VDTc(2:end,1),diff(VDTc(:,1)))
% bar(VDTc(:,1),Lcor)
% axis([0 12*60*60 0 ])
    
end


