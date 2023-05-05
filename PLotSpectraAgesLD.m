% ReadSpectraVSmouses
clear all
close all

exte='.txt'
path='c:\miceMUA\';
pathin=[path,'outputVS\']
pathout=[path,'aveSpectra\']; mkdir(pathout)
pathfig=[pathout,'spectraAve\']; mkdir(pathfig)

ders=strvcat('fro','occ');
L_D=strvcat('light','dark');
state=strvcat('NREM sleep','REM sleep','Wake')

f=0:0.25:20;
maxep=10800;
zermat=zeros(1,maxep);
cols='br'
vsnames=strvcat('Wake','NREM','REM')

%old_L
filenames_oldL=['Ma_270914_L';'Fe_101114_L';'Ar_171114_L';'Ex_121114_L';'Bu_131114_L';'Pa_061214_L';'Wi_071214_L';'Hu_071214_L'];
%young_L
filenames_youngL=['It_240914_L';'Mo_280914_L';'Ro_181014_L';'Du_061114_L';'Ol_061114_L';'An_150114_L';'Ge_150114_L';'He_180115_L'];
%old_D
filenames_oldD=['Ma_270914_D';'Fe_091114_D';'Ar_161114_D';'Ex_171114_D';'Bu_131114_D';'Pa_051214_D';'Hu_061214_D';];
%young_D
filenames_youngD=['It_240914_D';'Mo_270914_D';'Ro_181014_D';'Du_051114_D';'Ol_051114_D';'An_150115_D';'Ge_150115_D';'He_180115_D'];


for ld=1:2
    for der=1:2
        
        SPn=[];
        SPw=[];
        SPr=[];
        for age=1:2
            if age==1
                if ld==1
                    filenames=filenames_youngL;
                elseif ld==2
                    filenames=filenames_youngD;
                end
            else
                if ld==1
                    filenames=filenames_oldL;
                else ld==2
                    filenames=filenames_oldD;
                end
            end
            
            spN=[];
            spR=[];
            spW=[];
            
            for n=1:size(filenames)
                
                fnout=[filenames(n,:),'_',ders(der,:),'_VSspec'];
                eval(['load ',pathin,fnout,'.mat spectr nr nr2 r r3 w w1 mt ma -mat']);
                
                spN=[spN;mean(spectr(nr,:))];
                spN(:,1:2)=NaN; % to not plot lowest two bins
                spW=[spW;mean(spectr(w,:))];
                spW(:,1:2)=NaN; % to not plot lowest two bins
                spR=[spR;mean(spectr(r,:))];
                spR(:,1:2)=NaN; % to not plot lowest two bins
                
            end
            SPn=[SPn;mean(spN)];
            SPw=[SPw;mean(spW)];
            SPr=[SPr;mean(spR)];
        end
        %pause
        figure(der)
        for vs=1:3
            if vs==1 SP=SPn; elseif vs==2 SP=SPr; else SP=SPw; end
            
            subplot(1,3,vs)
            semilogy(f,SP,'.-','LineWidth',3)
            grid on
            set(gca,'FontSize',28)
            
            
            xlabel('Frequency (Hz)','FontSize',34);
            
            if vs==1
                title('NREM sleep','FontSize',34);
                            legend('early adulthood','late adulthood'); legend('boxoff')
            ylabel('log \mu V_{2}/0.25 Hz','FontSize',34);

            elseif vs==2
                title('REM sleep','FontSize',34);
            else
                title('Wake','FontSize',34);
            end
            
            
            
            
            
        end
        pause
        saveas(gcf,[pathfig,'\spectra_',ders(der,:),'_',L_D(ld,:)],'tiff')
        saveas(gcf,[pathfig,'\spectra_',ders(der,:),'_',L_D(ld,:)],'m')
        
    end
end

