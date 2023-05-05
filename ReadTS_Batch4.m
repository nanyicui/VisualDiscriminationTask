clear all;
close all;
durs=3600;
ba=1;
maxs=300;
zermat=zeros(1,durs);
pathin='D:\Dropbox\Batch4\Batch4rawdata\';
%pathinBSL='D:\Dropbox\Batch2\Grating&CircleBSL\';
int=0;
FS=10;
num2cri=5;
numanim=8;
progr=5;
insta=3;
latencycriteria=2;
VarsCO=[]; VarsCOc=[]; VarsCOi=[];

% variables in M1:
% 1. session length
% 2. total beam crossing
% 3. n trial s/ min
% 4. mean latency initiate-touch
% 5. median latency initiate-touch
% 6. mean duration of shortest lat
% 7. mean duration of longes lat
% 8. mean intertrial interval
% 9. median intertrial interval
% 10. std intertrial interval
% 11. improvement progress
% 12. ratio correct / incorrect trials
% 13. mean duration successful bouts / unsuccessful bouts
% % 14. number of attempts to nose poke per trial
% % 15. number of attempts to nose poke per second
% % 16. turning asymmetry index
% % 17. accuracy index based on visual scoring abs
% % 18. accuracy index based on visual scoring rel
% % 19. accuracy index based on visual scoring rel L
% % 20. accuracy index based on visual scoring rel R
% % 21. total correct nose pokes per number of trials
% % 22. total correct nose pokes per number of all nose pokes
% % 23. total nose pokes / trial
% % 24. percent correct choices when the mouse turns left and the correct image is on the right side (Easy)
% % 25. percent correct choices when the mouse turns left and the correct image is on the left side (Hard)
% % 26. percent correct choices when the mouse turns right and the correct image is on the right side (Hard)
% % 27. percent correct choices when the mouse turns right and the correct image is on the left side (Easy)
% % 28. accuracy index based on visual scoring considering only trials with one nosepoke
% 29. number of trials need to have 5 consecutive correct trials

% variables in M2-5:
% 1. total number of corr or incorrect trials
% 2. relative number of corr or incorrect trials as % of all trials
% 3. number of corr or incorrect trials per minute
% 4. mean latency between initiate and touch
% 5. median latency between initiate and touch
% 6. std of latency between initiate and touch
% 7. shortest 10 % latencies
% 8. longest 10 % latencies
% 9. number of success or unsuccess bouts
% 10. success or unsuccess bouts per minute
% 11. success or unsuccess bouts per number of trials
% 12. duration of success or unsuccess bouts
% 13. std of success or unsuccess bouts
% 14. maximal duration of success or unsuccess bouts
% 15. mean duration of success or unsuccess bouts in the first 1/3 of trials
% 16. mean duration of success or unsuccess bouts in the last 1/3 of trials
% 17. ratio between 16/15


% CO
for m=1:numanim

    
    mname=['mouse',num2str(m),'CO'];
    filecheck=fopen([pathin,mname,'.mat'],'r');if filecheck<0 continue; else fclose(filecheck); end
    eval(['load ',pathin,mname,'.mat birbeam firbeam beamcross TS turncol imagecol nosepokecol -mat']);
    
    % Looking at only the first 20 trials
    
    % TS=TS(1:10,:);
    % turncol=turncol(1:10);
    % imagecol=imagecol(1:10);
    % nosepokecol=nosepokecol(1:10,:);
    
    %%%%% analysing only lat< 2 seconds
    
%     TS=TS((TS(:,2)-TS(:,1))<latencycriteria,:);
%     nosepokecol=nosepokecol((TS(:,2)-TS(:,1))<2,:);
%     turncol=turncol((TS(:,2)-TS(:,1))<2,:);
%     imagecol=imagecol((TS(:,2)-TS(:,1))<2,:);
    
    %%%%%
    if floor(TS(1,1))==0
        BC=beamcross(1:ceil(TS(end,1)));
    else BC=beamcross(floor(TS(1,1)):ceil(TS(end,1)));
    end
    dur=length(BC)/60;
   
    numtr=size(TS,1);lat=TS(:,2)-TS(:,1);
    latsort=sort(lat); nv=length(lat); pp=nv/FS; latFS=[mean(latsort(1:ceil(pp))) mean(latsort(nv-ceil(pp)+1:nv))];
    
    su=TS(:,3);cc=sum(su(1:floor(numtr/progr))); ii=sum(su(numtr-floor(numtr/progr):end));
    
    vc=find(TS(:,3)==1);
    latvc=lat(vc,1); latvcsort=sort(latvc); nvc=length(vc); pp=nvc/FS; latFSc=[mean(latvcsort(1:ceil(pp))) mean(latvcsort(nvc-ceil(pp)+1:nvc))];
    
    vi=find(TS(:,3)==0);
    latvi=lat(vi,1); latvisort=sort(latvi); nvi=length(vi); pp=nvi/FS; latFSi=[mean(latvisort(1:ceil(pp))) mean(latvisort(nvi-ceil(pp)+1:nvi))];
    
    % computing success clusters
    trials=vc;
    trials=[trials' maxs]; dif=diff(trials); dif1=find(dif>ba); endvs=trials(dif1);
    startvs=dif1+1; startvs=[1 startvs maxs];
    nepivs=diff(startvs); nepi1vs=find(nepivs>int);     % interruption
    epidurvs=nepivs(nepi1vs); startep=trials(startvs(nepi1vs)); numvs=length(startep); startep(numvs)=[];
    nepi1vs(length(nepi1vs))=[]; endep=endvs(nepi1vs); startend=[startep' endep']; epidurc=endep-startep+1;
    numepi=length(epidurc);
    if numepi==0 epic1=NaN; epic2=NaN; else epic1=mean(epidurc(1:floor(numepi/insta))); epic2=mean(epidurc(numepi-floor(numepi/insta):end));end
    
    % computing unsuccess clusters
    trials=vi;
    trials=[trials' maxs]; dif=diff(trials); dif1=find(dif>ba); endvs=trials(dif1);
    startvs=dif1+1; startvs=[1 startvs maxs];
    nepivs=diff(startvs); nepi1vs=find(nepivs>int);     % interruption
    epidurvs=nepivs(nepi1vs); startep=trials(startvs(nepi1vs)); numvs=length(startep); startep(numvs)=[];
    nepi1vs(length(nepi1vs))=[]; endep=endvs(nepi1vs); startend=[startep' endep']; epiduri=endep-startep+1;
    numepi=length(epiduri);
    if numepi==0 epii1=NaN; epii2=NaN; else epii1=mean(epiduri(1:floor(numepi/insta))); epii2=mean(epiduri(numepi-floor(numepi/insta):end));end
    mc=max(epidurc); if length(mc)==0 mc=NaN; end; mi=max(epiduri); if length(mi)==0 mi=NaN; end;
    
    % analysis of nose pokes based on visual scoring
    np1=nosepokecol; np1(isnan(np1)==1)=3; np1(find(np1<3))=1; np1(find(np1==3))=0; np1l=mean(sum(np1,2)./lat); np1=mean(sum(np1,2));
    turnL=find(turncol==0);turnR=find(turncol==1);
    asy=abs(length(turnL)-length(turnR))/length(turncol);
    
    % MANacc is the manual accuracy calculated from manual scoring consifering only the trials with only one nosepoke
%     onenosepoke=isnan(nosepokecol(:,2));
%     onenosepoke1=find(onenosepoke);
%     ons=[nosepokecol(:,1)]; ons2=[onenosepoke]; ons3=ons(ons2); imagecol2=imagecol(onenosepoke);
%     correct=ones(length(imagecol2),1);
%     correct((ons3+imagecol2)==1)=0;
%     MANacc=sum(correct)/length(correct)*100;
    
    
    
    
    
    
    asy=length(turnL)/length(turnR);
    
    ft=nosepokecol(:,1); fL=zeros(numtr,1); fL(ft==0)=1; fR=zeros(numtr,1); fR(ft==1)=1;
    iL=zeros(numtr,1); iL(imagecol==0)=1; iR=zeros(numtr,1); iR(imagecol==1)=1;
    cL=zeros(numtr,1); cL(find(fL+iL==2))=1;cR=zeros(numtr,1); cR(find(fR+iR==2))=1; cLR=cL+cR;
    acuLrel=sum(cL)/numtr*100;acuRrel=sum(cR)/numtr*100;
    acu=sum(cLR); acurel=acu/numtr*100;
    tp=nosepokecol; tp(find(tp==1))=NaN; tp(find(tp==0))=1; tp(isnan(tp)==1)=0; tp(iL==0,:)=0; tcnpL=sum(sum(tp));
    tp=nosepokecol; tp(find(tp==0))=NaN; tp(isnan(tp)==1)=0; tp(iR==0,:)=0;tcnpR=sum(sum(tp));
    tp=nosepokecol;tp(find(tp==0))=1;tp(isnan(tp)==1)=0; tnp=sum(sum(tp)); tnptr=tnp/numtr;
    tcnp=tcnpL+tcnpR; tcnp1=tcnp/numtr;tcnp2=tcnp/tnp;
    
    tuL=find(turncol==0);
    cLtL=cL(tuL); acLtL=length(find(cLtL==1))/length(cLtL)*100;
    cRtL=cR(tuL); acRtL=length(find(cRtL==1))/length(cRtL)*100;
    tuR=find(turncol==1);
    cLtR=cL(tuR); acLtR=length(find(cLtR==1))/length(cLtR)*100;
    cRtR=cR(tuR); acRtR=length(find(cRtR==1))/length(cRtR)*100;
%     
    for nnn=1:(length(TS)-num2cri-1)       
        temacctr(nnn)=sum(TS(nnn:(nnn+num2cri-1),3))>(num2cri-1); end
    tempacctr=find(temacctr==1);acctr=tempacctr(1)-1;
    
%     VarsCO=[VarsCO;dur sum(BC) size(TS,1)/dur mean(lat) median(lat) latFS(1) latFS(2) mean(diff(TS(:,1))) median(diff(TS(:,1))) std(diff(TS(:,1))) ii/cc nvc/nvi mean(epidurc)/mean(epiduri) acctr];
%     VarsCOc=[VarsCOc;length(vc) length(vc)/numtr*100 length(vc)/dur mean(latvc) median(latvc) std(latvc) latFSc(1) latFSc(2) length(epidurc) length(epidurc)/dur length(epidurc)/numtr mean(epidurc) std(epidurc) mc epic1 epic2 epic2/epic1];
%     VarsCOi=[VarsCOi;length(vi) length(vi)/numtr*100 length(vi)/dur mean(latvi) median(latvi) std(latvi) latFSi(1) latFSi(2) length(epiduri) length(epiduri)/dur length(epiduri)/numtr mean(epiduri) std(epiduri) mi epii1 epii2 epii2/epii1];
%     
    VarsCO=[VarsCO;dur sum(BC) size(TS,1)/dur mean(lat) median(lat) latFS(1) latFS(2) mean(diff(TS(:,1))) median(diff(TS(:,1))) std(diff(TS(:,1))) ii/cc nvc/nvi mean(epidurc)/mean(epiduri) np1 np1l asy acu acurel acuLrel acuRrel tcnp1 tcnp2 tnptr acLtL acRtL acLtR acRtR MANacc acctr];
    VarsCOc=[VarsCOc;length(vc) length(vc)/numtr*100 length(vc)/dur mean(latvc) median(latvc) std(latvc) latFSc(1) latFSc(2) length(epidurc) length(epidurc)/dur length(epidurc)/numtr mean(epidurc) std(epidurc) mc epic1 epic2 epic2/epic1];
    VarsCOi=[VarsCOi;length(vi) length(vi)/numtr*100 length(vi)/dur mean(latvi) median(latvi) std(latvi) latFSi(1) latFSi(2) length(epiduri) length(epiduri)/dur length(epiduri)/numtr mean(epiduri) std(epiduri) mi epii1 epii2 epii2/epii1];
%     
end
%pause
M1c=nanmean(VarsCO); S1c=nanstd(VarsCO)/sqrt(size(VarsCO,1));
M2c=nanmean(VarsCOc); S2c=nanstd(VarsCOc)/sqrt(size(VarsCOc,1));
M3c=nanmean(VarsCOi); S3c=nanstd(VarsCOi)/sqrt(size(VarsCOi,1));


% sleep deprivation
VarsSD=[]; VarsSDc=[]; VarsSDi=[];

for m=1:numanim
    mname=['mouse',num2str(m),'SD'];
    filecheck=fopen([pathin,mname,'.mat'],'r');if filecheck<0 continue; else fclose(filecheck); end
    eval(['load ',pathin,mname,'.mat birbeam firbeam beamcross TS turncol imagecol nosepokecol -mat']);
    
    % Looking at only the first 20 trials
    
    % TS=TS(1:10,:);
    % turncol=turncol(1:10);
    % imagecol=imagecol(1:10);
    % nosepokecol=nosepokecol(1:10,:);
    
    %%%%% analysing only lat< 2 seconds
    
%     TS=TS((TS(:,2)-TS(:,1))<latencycriteria,:);
%     nosepokecol=nosepokecol((TS(:,2)-TS(:,1))<2,:);
%     turncol=turncol((TS(:,2)-TS(:,1))<2,:);
%     imagecol=imagecol((TS(:,2)-TS(:,1))<2,:);
    
    %%%%%
    if floor(TS(1,1))==0
        BC=beamcross(1:ceil(TS(end,1)));
    else BC=beamcross(floor(TS(1,1)):ceil(TS(end,1)));
    end
    dur=length(BC)/60;
   
    numtr=size(TS,1);lat=TS(:,2)-TS(:,1);
    latsort=sort(lat); nv=length(lat); pp=nv/FS; latFS=[mean(latsort(1:ceil(pp))) mean(latsort(nv-ceil(pp)+1:nv))];
    
    su=TS(:,3);cc=sum(su(1:floor(numtr/progr))); ii=sum(su(numtr-floor(numtr/progr):end));
    
    vc=find(TS(:,3)==1);
    latvc=lat(vc,1); latvcsort=sort(latvc); nvc=length(vc); pp=nvc/FS; latFSc=[mean(latvcsort(1:ceil(pp))) mean(latvcsort(nvc-ceil(pp)+1:nvc))];
    
    vi=find(TS(:,3)==0);
    latvi=lat(vi,1); latvisort=sort(latvi); nvi=length(vi); pp=nvi/FS; latFSi=[mean(latvisort(1:ceil(pp))) mean(latvisort(nvi-ceil(pp)+1:nvi))];
    
    % computing success clusters
    trials=vc;
    trials=[trials' maxs]; dif=diff(trials); dif1=find(dif>ba); endvs=trials(dif1);
    startvs=dif1+1; startvs=[1 startvs maxs];
    nepivs=diff(startvs); nepi1vs=find(nepivs>int);     % interruption
    epidurvs=nepivs(nepi1vs); startep=trials(startvs(nepi1vs)); numvs=length(startep); startep(numvs)=[];
    nepi1vs(length(nepi1vs))=[]; endep=endvs(nepi1vs); startend=[startep' endep']; epidurc=endep-startep+1;
    numepi=length(epidurc);
    if numepi==0 epic1=NaN; epic2=NaN; else epic1=mean(epidurc(1:floor(numepi/insta))); epic2=mean(epidurc(numepi-floor(numepi/insta):end));end
    
    % computing unsuccess clusters
    trials=vi;
    trials=[trials' maxs]; dif=diff(trials); dif1=find(dif>ba); endvs=trials(dif1);
    startvs=dif1+1; startvs=[1 startvs maxs];
    nepivs=diff(startvs); nepi1vs=find(nepivs>int);     % interruption
    epidurvs=nepivs(nepi1vs); startep=trials(startvs(nepi1vs)); numvs=length(startep); startep(numvs)=[];
    nepi1vs(length(nepi1vs))=[]; endep=endvs(nepi1vs); startend=[startep' endep']; epiduri=endep-startep+1;
    numepi=length(epiduri);
    if numepi==0 epii1=NaN; epii2=NaN; else epii1=mean(epiduri(1:floor(numepi/insta))); epii2=mean(epiduri(numepi-floor(numepi/insta):end));end
    mc=max(epidurc); if length(mc)==0 mc=NaN; end; mi=max(epiduri); if length(mi)==0 mi=NaN; end;
    
    % analysis of nose pokes based on visual scoring
    np1=nosepokecol; np1(isnan(np1)==1)=3; np1(find(np1<3))=1; np1(find(np1==3))=0; np1l=mean(sum(np1,2)./lat); np1=mean(sum(np1,2));
    turnL=find(turncol==0);turnR=find(turncol==1);
    asy=abs(length(turnL)-length(turnR))/length(turncol);
    
    % MANacc is the manual accuracy calculated from manual scoring consifering only the trials with only one nosepoke
%     onenosepoke=isnan(nosepokecol(:,2));
%     onenosepoke1=find(onenosepoke);
%     ons=[nosepokecol(:,1)]; ons2=[onenosepoke]; ons3=ons(ons2); imagecol2=imagecol(onenosepoke);
%     correct=ones(length(imagecol2),1);
%     correct((ons3+imagecol2)==1)=0;
%     MANacc=sum(correct)/length(correct)*100;
    
    
    
    
    
    
    % asy=length(turnL)/length(turnR);
    
%     ft=nosepokecol(:,1); fL=zeros(numtr,1); fL(ft==0)=1; fR=zeros(numtr,1); fR(ft==1)=1;
%     iL=zeros(numtr,1); iL(imagecol==0)=1; iR=zeros(numtr,1); iR(imagecol==1)=1;
%     cL=zeros(numtr,1); cL(find(fL+iL==2))=1;cR=zeros(numtr,1); cR(find(fR+iR==2))=1; cLR=cL+cR;
%     acuLrel=sum(cL)/numtr*100;acuRrel=sum(cR)/numtr*100;
%     acu=sum(cLR); acurel=acu/numtr*100;
%     tp=nosepokecol; tp(find(tp==1))=NaN; tp(find(tp==0))=1; tp(isnan(tp)==1)=0; tp(iL==0,:)=0; tcnpL=sum(sum(tp));
%     tp=nosepokecol; tp(find(tp==0))=NaN; tp(isnan(tp)==1)=0; tp(iR==0,:)=0;tcnpR=sum(sum(tp));
%     tp=nosepokecol;tp(find(tp==0))=1;tp(isnan(tp)==1)=0; tnp=sum(sum(tp)); tnptr=tnp/numtr;
%     tcnp=tcnpL+tcnpR; tcnp1=tcnp/numtr;tcnp2=tcnp/tnp;
%     
%     tuL=find(turncol==0);
%     cLtL=cL(tuL); acLtL=length(find(cLtL==1))/length(cLtL)*100;
%     cRtL=cR(tuL); acRtL=length(find(cRtL==1))/length(cRtL)*100;
%     tuR=find(turncol==1);
%     cLtR=cL(tuR); acLtR=length(find(cLtR==1))/length(cLtR)*100;
%     cRtR=cR(tuR); acRtR=length(find(cRtR==1))/length(cRtR)*100;
%     
    for nnn=1:(length(TS)-num2cri-1)       
        temacctr(nnn)=sum(TS(nnn:(nnn+num2cri-1),3))>(num2cri-1); end
    tempacctr=find(temacctr==1);acctr=tempacctr(1)-1;
%     VarsSD=[VarsSD;dur sum(BC) size(TS,1)/dur mean(lat) median(lat) latFS(1) latFS(2) mean(diff(TS(:,1))) median(diff(TS(:,1))) std(diff(TS(:,1))) ii/cc nvc/nvi mean(epidurc)/mean(epiduri) acctr];
%     VarsSDc=[VarsSDc;length(vc) length(vc)/numtr*100 length(vc)/dur mean(latvc) median(latvc) std(latvc) latFSc(1) latFSc(2) length(epidurc) length(epidurc)/dur length(epidurc)/numtr mean(epidurc) std(epidurc) mc epic1 epic2 epic2/epic1];
%     VarsSDi=[VarsSDi;length(vi) length(vi)/numtr*100 length(vi)/dur mean(latvi) median(latvi) std(latvi) latFSi(1) latFSi(2) length(epiduri) length(epiduri)/dur length(epiduri)/numtr mean(epiduri) std(epiduri) mi epii1 epii2 epii2/epii1];
    
    VarsSD=[VarsSD;dur sum(BC) size(TS,1)/dur mean(lat) median(lat) latFS(1) latFS(2) mean(diff(TS(:,1))) median(diff(TS(:,1))) std(diff(TS(:,1))) ii/cc nvc/nvi mean(epidurc)/mean(epiduri) np1 np1l asy acu acurel acuLrel acuRrel tcnp1 tcnp2 tnptr acLtL acRtL acLtR acRtR MANacc acctr];
    VarsSDc=[VarsSDc;length(vc) length(vc)/numtr*100 length(vc)/dur mean(latvc) median(latvc) std(latvc) latFSc(1) latFSc(2) length(epidurc) length(epidurc)/dur length(epidurc)/numtr mean(epidurc) std(epidurc) mc epic1 epic2 epic2/epic1];
    VarsSDi=[VarsSDi;length(vi) length(vi)/numtr*100 length(vi)/dur mean(latvi) median(latvi) std(latvi) latFSi(1) latFSi(2) length(epiduri) length(epiduri)/dur length(epiduri)/numtr mean(epiduri) std(epiduri) mi epii1 epii2 epii2/epii1];
%     
end
%pause
M1s=nanmean(VarsSD); S1s=nanstd(VarsSD)/sqrt(size(VarsSD,1));
M2s=nanmean(VarsSDc); S2s=nanstd(VarsSDc)/sqrt(size(VarsSDc,1));
M3s=nanmean(VarsSDi); S3s=nanstd(VarsSDi)/sqrt(size(VarsSDi,1));


[t1,p1]=ttest(VarsCO,VarsSD)
M1=[M1c' S1c' M1s' S1s' p1']

[t2,p2]=ttest(VarsCOc,VarsSDc)
M2=[M2c' S2c' M2s' S2s' p2']

[t3,p3]=ttest(VarsCOi,VarsSDi)
M3=[M3c' S3c' M3s' S3s' p3']

[t4,p4]=ttest(VarsCOc,VarsCOi)
M4=[M2c' S2c' M3c' S3c' p4']

[t5,p5]=ttest(VarsSDc,VarsSDi)
M5=[M2s' S2s' M3s' S3s' p5']

% [t6,p6]=ttest(VarsBSL,VarsCO)
% M6=[M1b' S1b' M1c' S1c' p6']
% 
% [t7,p7]=ttest(VarsBSLc,VarsCOc)
% M7=[M2b' S2b' M2c' S2c' p7']
% 
% [t8,p8]=ttest(VarsBSLi,VarsCOi)
% M8=[M3b' S3b' M3c' S3c' p8']
% 
% [t9,p9]=ttest(VarsBSLc,VarsBSLi)
% M9=[M2b' S2b' M3b' S3b' p9']
% 
% [t10,p10]=ttest(VarsBSL,VarsSD)
% M10=[M1b' S1b' M1s' S1s' p10']
% 
% [t11,p11]=ttest(VarsBSLc,VarsSDc)
% M11=[M2b' S2b' M2s' S2s' p11']
% 
% [t12,p12]=ttest(VarsBSLi,VarsSDi)
% M12=[M3b' S3b' M3s' S3s' p12']


%both correct and incorrect
for V=1:14
close all;
H=figure(1);
M=M1;
bar([0.5, 1.5],[M(V,1),M(V,3)],'w'),hold on;errorbar([0.5, 1.5],[M(V,1),M(V,3)],[M(V,2),M(V,4)],'r+');
str=sprintf('Variable %d p=%f',V,M(V,5));
title(str);xlabel('CO vs SD');

saveas(H,['D:\Dropbox\Batch4\graphs\M1V' num2str(V)],'jpg')
end
%correct or incorrect trials only

for V=1:17
close all;
H=figure(1);
M=M2;
h1=subplot(1,2,1);bar([0.5, 1.5],[M(V,1),M(V,3)],'w'),hold on;errorbar([0.5, 1.5],[M(V,1),M(V,3)],[M(V,2),M(V,4)],'r+');
VV1=axis;
str=sprintf('Variable %d p=%f',V,M(V,5));title(str);xlabel('COc vs SDc');
M=M3;
h2=subplot(1,2,2);bar([0.5, 1.5],[M(V,1),M(V,3)],'w'),hold on;errorbar([0.5, 1.5],[M(V,1),M(V,3)],[M(V,2),M(V,4)],'r+');
VV2=axis;
str=sprintf('Variable %d p=%f',V,M(V,5));title(str);xlabel('COi vs SDi');
if VV1(4)<VV2(4)
    axis([h1 h2],VV2);
else axis([h1 h2],VV1)
end
saveas(H,['D:\Dropbox\Batch4\graphs\M2and3V' num2str(V)],'jpg')
%correct vs incorrect trials 

close all;
H=figure(1);
M=M4;
h1=subplot(1,2,1);bar([0.5, 1.5],[M(V,1),M(V,3)],'w'),hold on;errorbar([0.5, 1.5],[M(V,1),M(V,3)],[M(V,2),M(V,4)],'r+');
VV1=axis;
str=sprintf('Variable %d p=%f',V,M(V,5));title(str);xlabel('COc vs COi');
M=M5;
h2=subplot(1,2,2);bar([0.5, 1.5],[M(V,1),M(V,3)],'w'),hold on;errorbar([0.5, 1.5],[M(V,1),M(V,3)],[M(V,2),M(V,4)],'r+');
VV2=axis;
str=sprintf('Variable %d p=%f',V,M(V,5));title(str);xlabel('SDc vs SDi');
if VV1(4)<VV2(4)
    axis([h1 h2],VV2);
else axis([h1 h2],VV1)
end

saveas(H,['D:\Dropbox\Batch4\graphs\M4and5V' num2str(V)],'jpg')
end
