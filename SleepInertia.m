% Sleep inertia analysis in 34 rats
%% Loading Data
clear all
close all
for ratnum=1:34
    
    ratdata(ratnum)=load(['rat' num2str(ratnum)]);
    
end

%% Spectral Analysis

for ratnum=1:34
    
    ratdata(ratnum).spectNR=ratdata(ratnum).spectr((ratdata(ratnum).nr==1),:);
    ratdata(ratnum).ave_spectNR=mean(ratdata(ratnum).spectNR);
    ratdata(ratnum).spectR=ratdata(ratnum).spectr((ratdata(ratnum).r==1),:);
    ratdata(ratnum).ave_spectR=mean(ratdata(ratnum).spectR);
    ratdata(ratnum).spectW=ratdata(ratnum).spectr((ratdata(ratnum).w==1),:);
    ratdata(ratnum).ave_spectW=mean(ratdata(ratnum).spectW);
    
end

%mean spectra across all 34 rats
rat_spectr=reshape([ratdata(:).ave_spectNR],34,81);
mean_spectr=mean(rat_spectr);

%% NREM to REM Transition

h24ind=1:21600;
ColormapValue=colormap(jet(128));
%first find REM episode that fit creteria: 15/15 r epochs
for ratnum=1:34
    
    clear preceedvsnr vscomparenr R NR Rstartep Rnumvs Rdif Rdif1 Rendvs Rstartvs
    clear Rnepivs Repilvs Repidurvs Repidurvs Rendep vscomparer tr
    
    %find artifects
    ratdata(ratnum).nr_art=ratdata(ratnum).nr~=ratdata(ratnum).nr2;
    ratdata(ratnum).r_art=ratdata(ratnum).r~=ratdata(ratnum).r3;
    ratdata(ratnum).w_art=ratdata(ratnum).w~=ratdata(ratnum).w1;
    
    R=h24ind((ratdata(ratnum).r3)==1);
    Rdif=diff(R);
    Rdif1=find(Rdif>1);
    Rendvs=R(Rdif1);
    Rstartvs=R(Rdif1+1);
    Rstartvs=[R(1) Rstartvs];
    Rstartvs(end)=[];
    Rnepivs=Rendvs-Rstartvs;
    Rnepi1vs=find(Rnepivs>15);
    Repidurvs=Rnepivs(Rnepi1vs);
    Rstartep=Rstartvs(Rnepi1vs);
    Rnumvs=length(Rstartep);
    Rendep=Rendvs(Rnepi1vs);
    
    
    %find NREM episodes that fit criteria : 10/15 nr epochs, no r epoch
    NR=h24ind((ratdata(ratnum).nr2)==1);
    
    for cnr=1:Rnumvs
        
        preceedvsnr(:,cnr)=(Rstartep(cnr)-15):(Rstartep(cnr)-1);
        
        for knr=1:15
            
            vscomparenr(knr,cnr)=isequal(ratdata(ratnum).nr(preceedvsnr(knr,cnr)),1);
            vscomparer(knr,cnr) =isequal(ratdata(ratnum).r3(preceedvsnr(knr,cnr)),1);
        end
        
    end
    
    if length(Rstartep)<1
        ratnum=ratnum+1;
        
    else
        ratdata(ratnum).Rstart_tran=Rstartep((sum(vscomparenr,1)>12) & (vscomparenr(15,:)==1) & (sum(vscomparer,1)==0));
        if length(ratdata(ratnum).Rstart_tran)<1
            ratnum=ratnum+1;
        else
            for tr=1:length(ratdata(ratnum).Rstart_tran)
                
                ratdata(ratnum).n_r_spect(:,:,tr)=ratdata(ratnum).spectr((ratdata(ratnum).Rstart_tran(tr)-15):((ratdata(ratnum).Rstart_tran(tr)+14)),:);
                
                %excluding artifects
                for arti=1:1:30
                    
                    if ratdata(ratnum).nr_art((ratdata(ratnum).Rstart_tran(tr)-16)+arti)==1 || ratdata(ratnum).r_art((ratdata(ratnum).Rstart_tran(tr)-16)+arti)==1
                        ratdata(ratnum).n_r_spect(arti,:,tr)=0;
                    end
                end
            end
            
            ratdata(ratnum).ave_n_r_spect=mean(ratdata(ratnum).n_r_spect,3);
            
            all_rat_n_r(:,:,ratnum)=ratdata(ratnum).ave_n_r_spect;
        end
    end
    
end

ave_all_rat_n_r=mean(all_rat_n_r,3);
HMO=HeatMap(log(ave_all_rat_n_r'),'Colormap',ColormapValue,'Symmetric','false');

addXLabel(HMO,'Time (Seconds)','FontSize',12)
addYLabel(HMO,'log EEG power (\muV^2 / 0.25 Hz)','FontSize',12)
addTitle(HMO,'NREM to REM Transitions')
%% NREM to Waking Transition

h24ind=1:21600;
ColormapValue=colormap(jet(128));
%first find Waking episode that fit creteria: 15/15 w epochs
for ratnum=[1:34]
    
    clear preceedvsnw vscomparenw W NR Wstartep Wnumvs Wdif Wdif1 Wendvs Wstartvs
    clear Wnepivs Wepilvs Wepidurvs Wepidurvs Wendep vscomparew tw
    
    %find artifects
    ratdata(ratnum).nr_art=ratdata(ratnum).nr~=ratdata(ratnum).nr2;
    ratdata(ratnum).r_art=ratdata(ratnum).r~=ratdata(ratnum).r3;
    ratdata(ratnum).w_art=ratdata(ratnum).w~=ratdata(ratnum).w1;
    
    W=h24ind((ratdata(ratnum).w1)==1);
    Wdif=diff(W);
    Wdif1=find(Wdif>1);
    Wendvs=W(Wdif1);
    Wstartvs=W(Wdif1+1);
    Wstartvs=[W(1) Wstartvs];
    Wstartvs(end)=[];
    Wnepivs=Wendvs-Wstartvs;
    Wnepi1vs=find(Wnepivs>15);
    Wepidurvs=Wnepivs(Wnepi1vs);
    Wstartep=Wstartvs(Wnepi1vs);
    Wstartep(1)=[];
    Wnumvs=length(Wstartep);
    Wendep=Wendvs(Wnepi1vs);
    
    %find NREM episodes that fit criteria : 10/15 nr epochs, no r epoch
    NR=h24ind((ratdata(ratnum).nr2)==1);
    
    for cnw=1:Wnumvs
        
        preceedvsnw(:,cnw)=(Wstartep(cnw)-15):(Wstartep(cnw)-1);
        
        for knw=1:15
            
            vscomparenw(knw,cnw)=isequal(ratdata(ratnum).nr(preceedvsnw(knw,cnw)),1);
            vscomparew(knw,cnw) =isequal(ratdata(ratnum).r3(preceedvsnw(knw,cnw)),1);
        end
        
    end
    
    if length(Wstartep)<1
        ratnum=ratnum+1;
        
    else
        ratdata(ratnum).Wstart_tran=Wstartep((sum(vscomparenw,1)>12) & (vscomparenw(15,:)==1) & (sum(vscomparew,1)==0));
        
        if length(ratdata(ratnum).Wstart_tran)<1
            ratnum=ratnum+1;
            
        else    
            for tr=1:length(ratdata(ratnum).Wstart_tran)
                
                ratdata(ratnum).n_w_spect(:,:,tr)=ratdata(ratnum).spectr((ratdata(ratnum).Wstart_tran(tr)-15):((ratdata(ratnum).Wstart_tran(tr)+14)),:);
                
                %excluding artifects
                for arti=1:1:30
                    
                    if ratdata(ratnum).nr_art((ratdata(ratnum).Wstart_tran(tr)-16)+arti)==1 || ratdata(ratnum).r_art((ratdata(ratnum).Wstart_tran(tr)-16)+arti)==1
                        ratdata(ratnum).n_w_spect(arti,:,tr)=0;
                    end
                end
            end
            
            ratdata(ratnum).ave_n_w_spect=mean(ratdata(ratnum).n_w_spect,3);
            
            all_rat_n_w(:,:,ratnum)=ratdata(ratnum).ave_n_w_spect;
        end
    end
end

ave_all_rat_n_w=mean(all_rat_n_w,3);
HMO=HeatMap(log(ave_all_rat_n_w'),'Colormap',ColormapValue,'Symmetric','false');

addXLabel(HMO,'Time (Seconds)','FontSize',12)
addYLabel(HMO,'log EEG power (\muV^2 / 0.25 Hz)','FontSize',12)
addTitle(HMO,'NREM to Waking Transitions')
%% Sleep Inertia in NREM to REM transition

for ratnum=1:34
    
    clear srt_inert_nr
    %First calculate SWA (0.5~4 Hz)
    ratdata(ratnum).SWA=nanmean(ratdata(ratnum).spectr(:,3:17),2);
    %SWA of artifect epochs are NaN
    ratdata(ratnum).SWA(ratdata(ratnum).nr_art==1 | ratdata(ratnum).r_art==1 | ratdata(ratnum).w_art==1)=NaN;
    
    if length(ratdata(ratnum).Rstart_tran)<5
        ratnum=ratnum+1;
    else
        for tr=1:length(ratdata(ratnum).Rstart_tran)
            
            ratdata(ratnum).n_r_inertia(:,tr) = [nanmean(ratdata(ratnum).SWA((ratdata(ratnum).Rstart_tran(tr)-15):(ratdata(ratnum).Rstart_tran(tr)-1))) nanmean(ratdata(ratnum).SWA((ratdata(ratnum).Rstart_tran(tr)):(ratdata(ratnum).Rstart_tran(tr)+14)))];
            
        end
        
        srt_inert_nr=sortrows(ratdata(ratnum).n_r_inertia');
        
        if size(srt_inert_nr,1)==5
            ratdata(ratnum).SWApre_n_r_tran=srt_inert_nr(1:end,1);
            ratdata(ratnum).SWApost_n_r_tran=srt_inert_nr(1:end,2);
        else
            ratdata(ratnum).SWApre_n_r_tran=nanmean(reshape(srt_inert_nr(1:(end-(rem(size(srt_inert_nr,1),5))),1),(size(srt_inert_nr,1)-(rem(size(srt_inert_nr,1),5)))/5,5));
            ratdata(ratnum).SWApost_n_r_tran=nanmean(reshape(srt_inert_nr(1:(end-(rem(size(srt_inert_nr,1),5))),2),(size(srt_inert_nr,1)-(rem(size(srt_inert_nr,1),5)))/5,5));
        end
        
        all_rat_SWApre_n_r_tran(:,ratnum)=ratdata(ratnum).SWApre_n_r_tran;
        all_rat_SWApost_n_r_tran(:,ratnum)=ratdata(ratnum).SWApost_n_r_tran;
    end
end

nozerosprenr=all_rat_SWApre_n_r_tran(all_rat_SWApre_n_r_tran>0);
nozerosprenr=reshape(nozerosprenr,5,length(nozerosprenr)/5);
nozerospostnr=all_rat_SWApost_n_r_tran(all_rat_SWApost_n_r_tran>0);
nozerospostnr=reshape(nozerospostnr,5,length(nozerospostnr)/5);

ave_all_rat_SWApre_n_r_tran=mean(nozerosprenr,2);
ave_all_rat_SWApost_n_r_tran=mean(nozerospostnr,2);

figure(1)
bar(log([ave_all_rat_SWApre_n_r_tran ave_all_rat_SWApost_n_r_tran]))

%% Sleep Inertia in NREM to Waking transition

for ratnum=1:34
    
    clear srt_inert_nw
    %First calculate SWA (0.5~4 Hz)
    ratdata(ratnum).SWA=nanmean(ratdata(ratnum).spectr(:,3:17),2);
    %SWA of artifect epochs are NaN
    ratdata(ratnum).SWA(ratdata(ratnum).nr_art==1 | ratdata(ratnum).r_art==1 | ratdata(ratnum).w_art==1)=NaN;
    
    if length(ratdata(ratnum).Wstart_tran)<5
        ratnum=ratnum+1;
    else
        for tr=1:length(ratdata(ratnum).Wstart_tran)
            
            ratdata(ratnum).n_w_inertia(:,tr) = [nanmean(ratdata(ratnum).SWA((ratdata(ratnum).Wstart_tran(tr)-15):(ratdata(ratnum).Wstart_tran(tr)-1))) nanmean(ratdata(ratnum).SWA((ratdata(ratnum).Wstart_tran(tr)):(ratdata(ratnum).Wstart_tran(tr)+14)))];
            
        end
        
        srt_inert_nw=sortrows(ratdata(ratnum).n_w_inertia');
        
        if size(srt_inert_nw,1)==5
            ratdata(ratnum).SWApre_n_w_tran=srt_inert_nw(1:end,1);
            ratdata(ratnum).SWApost_n_w_tran=srt_inert_nw(1:end,2);
        else
            ratdata(ratnum).SWApre_n_w_tran=nanmean(reshape(srt_inert_nw(1:(end-(rem(size(srt_inert_nw,1),5))),1),(size(srt_inert_nw,1)-(rem(size(srt_inert_nw,1),5)))/5,5));
            ratdata(ratnum).SWApost_n_w_tran=nanmean(reshape(srt_inert_nw(1:(end-(rem(size(srt_inert_nw,1),5))),2),(size(srt_inert_nw,1)-(rem(size(srt_inert_nw,1),5)))/5,5));
        end
        
        all_rat_SWApre_n_w_tran(:,ratnum)=ratdata(ratnum).SWApre_n_w_tran;
        all_rat_SWApost_n_w_tran(:,ratnum)=ratdata(ratnum).SWApost_n_w_tran;
    end
end

nozerosprenw=all_rat_SWApre_n_w_tran(all_rat_SWApre_n_w_tran~=0);
nozerosprenw=reshape(nozerosprenw,5,length(nozerosprenw)/5);
nozerospostnw=all_rat_SWApost_n_w_tran(all_rat_SWApost_n_w_tran~=0);
nozerospostnw=reshape(nozerospostnw,5,length(nozerospostnw)/5);

ave_all_rat_SWApre_n_w_tran=nanmean(nozerosprenw,2);
ave_all_rat_SWApost_n_w_tran=nanmean(nozerospostnw,2);


figure(2)

bar(log([ave_all_rat_SWApre_n_w_tran ave_all_rat_SWApost_n_w_tran]))
