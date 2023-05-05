% ReadSpectraVSmouses
clear all
close all
w=[];nr=[];r=[];mt=[];w1=[];r3=[];nr2=[];
exte='.txt';
path='D:\';

mousenames=strvcat('Bdr1');
days=['141214_L';];
ders='f';

f=0:0.25:30;
maxep=21600;
zermat=zeros(1,maxep);

pathin=[path,'OutputSpectraText\'];
pathout=[path,'OutputVS\']; mkdir(pathout)

numanim=size(mousenames,1);

for n=1:numanim
    mouse=mousenames(n,:); mouse(isspace(mouse))=[];
    day=days(n,:);
    figure
    for dr=1:1
        der=ders(dr);
        
        fname=[mouse,'-',day,'_',der]
        
        fnameFFT=[pathin,fname,exte];
        
        data=importdata(fnameFFT);
        
        for nn=20:length(data.textdata)
            if data.textdata{nn,2}=='W'
                w=[w, (nn-19)]; 
            elseif strcmp(data.textdata{nn,2},'NR')
                nr=[nr, (nn-19)];
            elseif data.textdata{nn,2}=='R'
                r=[r, (nn-19)]; 
            elseif data.textdata{nn,2}=='M'
                mt=[mt, (nn-19)];
            elseif strcmp(data.textdata{nn,2},'W1') || strcmp(data.textdata{nn,2},'Wa')
                w1=[w1, (nn-19)];
            elseif strcmp(data.textdata{nn,2},'R1') || strcmp(data.textdata{nn,2},'Ra')
                r3=[r3, (nn-19)];
            elseif strcmp(data.textdata{nn,2},'N1') || strcmp(data.textdata{nn,2},'Na')
                nr2=[nr2, (nn-19)];
            end
        end
        
        spectr=data.data;
        
        nr(nr>maxep)=[];nr2(nr2>maxep)=[];r(r>maxep)=[];r3(r3>maxep)=[];w(w>maxep)=[];w1(w1>maxep)=[];mt(mt>maxep)=[];
        
        ww1mt=sort([w w1 mt]);wake=zermat; wake(ww1mt)=1;[bastend, badur]=BriefAwakenings(wake,maxep);
        ba=zermat; for b=1:length(badur) ba(bastend(b,1):bastend(b,2))=1; end; mt=find(ba);
        [x,y]=intersect(w,mt); w(y)=[];[x1,y1]=intersect(w1,mt); w1(y1)=[]; mt=mt';

        
        fn=[mouse,'-',day,'-',der,'-VSspec'];
        
        eval(['save ',pathout,fn,'.mat spectr w nr r w1 nr2 r3 mt bastend -mat']);
        
        spN=mean(spectr(nr,:));
        spW=mean(spectr(w,:));
        spR=mean(spectr(r,:));
        
        sp=[spW;spN;spR];
        
        
        subplot(1,2,dr),
        semilogy(f,sp,'LineWidth',2)
        axis([0 30 0 10000])
        grid on
        legend('W','N','R')
        title(fname)
        xlabel('Frquency [Hz]')
        ylabel('EEG Spectral Power [\muV^2 / 0.25Hz]')
        w=[];nr=[];r=[];mt=[];w1=[];r3=[];nr2=[];
    end
    saveas(gcf,[path,'Figures\',mouse,'-',day],'jpg')
end
