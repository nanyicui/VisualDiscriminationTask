% ReadSpectraVSmouses
clear all
close all

exte='.txt'
path='d:\MultiUnit\';
mousename='mouse002';

pathin=[path,mousename,'\sleep\fft\']
pathout=[path,mousename,'\outputVS\'];
blocks=[9]
fname1='mouse002-block';
outpF=strvcat('BSL1')


for ff=1:length(blocks)
    %for ff=1:length(blocks)

    day=outpF(ff,:); day(isspace(day))=[];

    fname=[fname1,num2str(blocks(ff))]

    fnameFFT=[pathin,fname,exte]

    numline=1;
    fidfft=fopen(fnameFFT,'r');
    str=fgets(fidfft)
    while str(1:2)~='Ep'
        str=fgets(fidfft);
        numline=numline+1;
    end;

    fl=textread(fnameFFT,'%s%*[^\n]');
    fl1=char(fl);
    ep=find(fl1=='E');
    epdif=diff(ep);
    numrow=epdif(1)-2;

    c=1;
    numskip=numline+(c-1)*(numrow+3);

    [epoch,state,dateexp,time,a1]= textread(fnameFFT,'%d%s%s%s%f',numrow,'headerlines',numskip);

    statestr=char(state);

    nr=find((statestr(:,1)=='N' & statestr(:,2)=='R')); r=find((statestr(:,1)=='R' & statestr(:,2)~='a'));
    w=find(statestr(:,1)=='W' & statestr(:,2)~='a');
    nr2=find((statestr(:,1)=='N' & statestr(:,2)=='a')); r3=find((statestr(:,1)=='R' & statestr(:,2)=='a'));
    w1=find(statestr(:,1)=='W' & statestr(:,2)=='a');
    mt=find(statestr(:,1)=='M');

    fn=[mousename,'-',day,'-VS'];

    eval(['save ',pathout,fn,'.mat w nr r w1 nr2 r3 mt -mat']);

    %clear statestr nr nr2 w w1 r r3 mt;
end;
