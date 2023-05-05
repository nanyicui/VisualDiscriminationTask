% ReadSpectraVSrats
clear all
close all
%-------------------------------------------------------------------------
maxep=21600; % number of 4-s epochs in 24 h
minh=60;
numeh=900; % number of 4-s epochs in 1 h
zermat=zeros(1,maxep);
xt=0:24/maxep:24-0.00001; x=1:1:maxep; x=x./numeh;
path=['f:\downscaling\sleep\output\'];
rat=46;
figure
    rr=['rw0',num2str(rat)]
    eval(['load F:\slowwavesSDc\OutputFFT\BL24\',rr,'spectrVS.mat spectr nr nr2 -mat']);
    SWA=mean(spectr(:,3:17),2); SWA(nr==0)=NaN;

    SWA=SWA/nanmean(SWA)*100;

    subplot('position',[0.13 1-0.25 0.693 0.2]);
    bar(x,SWA);
    axis([0 24 0 700]); set(gca, 'XTick', [0:4:24]);
    ylabel('% of mean SWA in NREM')
    %set(gca, 'XTick', []);
    %set(gca, 'YTick', []);
    %title(num2str(rats(rat)))

    rr=['rw0',num2str(rat)]
    eval(['load F:\Downscaling\Hypnograms\',rr,'.mat w1 n2 r3 -mat']);
    % vigilance states
    for vs=1:3
        if vs==1 v=w1; elseif vs==2 v=n2; else v=r3; end;
        subplot('position',[0.13 1-0.3-0.011*(vs-1) 0.693 0.011]);
        bar(xt,v,0.1); axis ([0 24 0 1]);
        %if vs==1 title(['rw0',num2str(rats(rat))]); end;
        set(gca, 'YTick', []); set(gca, 'XTick', []);
        if vs==3 set(gca, 'XTick', [0:4:24]); xlabel('Hours');
        end;
    end;
     orient tall
%     saveas(gcf,['SWA-Hypnogram-rat',num2str(rats(rat)),'a'],'pdf')
%     close all
