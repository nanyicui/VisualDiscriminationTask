%%
clear all;
close all;
path='D:\RunningWheelData\';
pathin='D:\RunningWheelData\';
pathout=[path,'output\'];
maxret = 1000000;

tankName='RunningWheelData';


TTX = actxcontrol('TTank.X');
% Then connect to a server.
invoke(TTX,'ConnectServer', 'Local', 'Me');

tank=tankName;

% Now open a tank for reading.
invoke(TTX,'OpenTank',[path,tank], 'R')

% Select the block to access
for block=1:1
    
invoke(TTX,'SelectBlock', ['RW-',num2str(block)]);
TTX.CreateEpocIndexing;

TimeRanges=TTX.GetEpocsV('WHEu',0,0,maxret);
rw=TimeRanges(2,:);rw=rw/(60*60);rw=rw(rw>0); r=ones(1,length(rw));
rwu{block}=rw;
ru{block}=r;


TimeRanges=TTX.GetEpocsV('WHEd',0,0,maxret);
rw=TimeRanges(2,:);rw=rw/(60*60);rw=rw(rw>0); r=ones(1,length(rw));
rwd{block}=rw;
rd{block}=r;

end

invoke(TTX,'CloseTank');
invoke(TTX,'ReleaseServer')
%% Ploting
RWu=rwu{:};RWd=rwd{:};
RWu1=RWu(RWu>5 & RWu<=29);
RWd1=RWd(RWd>5 & RWd<=29);    
RWu2=RWu(RWu>29 & RWu<=53);
RWd2=RWd(RWd>29 & RWd<=53);    
RWu3=RWu(RWu>53 & RWu<=77);
RWd3=RWd(RWd>53 & RWd<=77); 
RWu4=RWu(RWu>77 & RWu<=101);
RWd4=RWd(RWd>77 & RWd<=101);
RWu5=RWu(RWu>101 & RWu<=125);
RWd5=RWd(RWd>101 & RWd<=125);    
ru1=ones(1,length(RWu1));rd1=ones(1,length(RWd1));
ru2=ones(1,length(RWu2));rd2=ones(1,length(RWd2));
ru3=ones(1,length(RWu3));rd3=ones(1,length(RWd3));
ru4=ones(1,length(RWu4));rd4=ones(1,length(RWd4));
ru5=ones(1,length(RWu5));rd5=ones(1,length(RWd5));
dn=(1:(24*60))/60;daynight=[ones(1,12*60) zeros(1,12*60)];
figure(1)

subplot(6,1,1),bar(dn,daynight,'k'),axis([0 24 0 1])
title('5-day Running Wheel Activity of Upper Cabinet')
subplot(6,1,2),bar(RWu1,ru1),axis([5 29 0 1])
subplot(6,1,3),bar(RWu2,ru2),axis([29 53 0 1])
subplot(6,1,4),bar(RWu3,ru3),axis([53 77 0 1])
subplot(6,1,5),bar(RWu4,ru4),axis([77 101 0 1])
subplot(6,1,6),bar(RWu5,ru5),axis([101 125 0 1])

figure(2)

subplot(6,1,1),bar(dn,daynight,'k'),axis([0 24 0 1])
title('5-day Running Wheel Activity of Lower Cabinet')
subplot(6,1,2),bar(RWd1,rd1),axis([5 29 0 1])
subplot(6,1,3),bar(RWd2,rd2),axis([29 53 0 1])
subplot(6,1,4),bar(RWd3,rd3),axis([53 77 0 1])
subplot(6,1,5),bar(RWd4,rd4),axis([77 101 0 1])
subplot(6,1,6),bar(RWd5,rd5),axis([101 125 0 1])