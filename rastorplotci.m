clear all;
close all;
pathin='D:\Dropbox\Batch2\Grating&CircleTestConcat\';
pathinBSL='D:\Dropbox\Batch2\Grating&CircleBSL\';
numanim=8;
S=0;

if S==1 sn='g'; else sn='c'; end

figure1=figure(1);
title('CO mice')
axis off
for m=1:numanim
    
    mname=['mouse',num2str(m),'-CO','-',sn];
    filecheck=fopen([pathin,mname,'.mat'],'r');if filecheck<0 continue; else fclose(filecheck); end
    eval(['load ',pathin,mname,'.mat TS turncol -mat']);
    
    COc{m}=TS(:,3);COi{m}=~TS(:,3);
    createfigureci(COc{m},COi{m},m/20,figure1)
    
end

figure2=figure(2);
title('SD mice')
axis off
for m=1:numanim

    mname=['mouse',num2str(m),'-SD','-',sn];
    filecheck=fopen([pathin,mname,'.mat'],'r');if filecheck<0 continue; else fclose(filecheck); end
    eval(['load ',pathin,mname,'.mat TS turncol -mat']);
    
    SDc{m}=TS(:,3);SDi{m}=~TS(:,3);
    createfigureci(SDc{m},SDi{m},m/20,figure2)
    
end

figure3=figure(3);
title('BSL mice')
axis off
for m=1:numanim
  
    mname=['mouse',num2str(m),'-BSL','-',sn];
    filecheck=fopen([pathinBSL,mname,'.mat'],'r');if filecheck<0 continue; else fclose(filecheck); end
    eval(['load ',pathinBSL,mname,'.mat TS turncol -mat']);
    
    BSLc{m}=TS(:,3);BSLi{m}=~TS(:,3);
    createfigureci(BSLc{m},BSLi{m},m/20,figure3)
    
end