% ReadSpectraVSmouses
clear all
close all

exte='.txt'
path='o:\mice\Archives';
mousenames=strvcat('Russell','Hugh');
day='140614'
ders='fo';
f=0:0.25:20;
pathout=[path,'\outputVS\'];
dernames=strvcat('Frontal','Occipital')


for mo=1:2
    mousename=mousenames(mo,:); mousename(isspace(mousename))=[];
    figure
    for d=1:2
        fn=[mousename,'-',day,'-',ders(d),'-VSspec'];
        
        eval(['load ',pathout,fn,'.mat spectr w nr r w1 nr2 r3 mt -mat']);
        
        %nr(nr>10801)=[];w(w>10801)=[];r(r>10801)=[];
        
        spN=mean(spectr(nr,:));
        spW=mean(spectr(w,:));
        spR=mean(spectr(r,:));
        
        sp=[spW;spN;spR];
        subplot(1,2,d)
        semilogy(f,sp,'LineWidth',2)
        grid on
        if d==2 legend('W','N','R'); end
        xlabel('Frequency [Hz]')
        if d==1 ylabel('EEG power density [uV^2/0.25 Hz]');end
        title(dernames(d,:))
    end
end


