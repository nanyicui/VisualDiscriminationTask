pathout='D:\Batch6\';
pathin='F:\TDTtanks\';
pathout=[pathout,'output\'];
maxret = 1000000;
recorddate='10062014';%day month year
tankName='Batch6';
block='Russell_Hugh_10062014';
for mouse=1:2

if mouse == 1
    mousename='Russell';
    event = 'WHE1';
elseif mouse == 2
        mousename='Hugh';
    event = 'WHE2';
end
TTX = actxcontrol('TTank.X');
% Then connect to a server.
invoke(TTX,'ConnectServer', 'Local', 'Me');

tank=tankName;

% Now open a tank for reading.
invoke(TTX,'OpenTank', [pathin tankName], 'R')

% Select the block to access
invoke(TTX,'SelectBlock', block);
TTX.CreateEpocIndexing;

TimeRanges=TTX.GetEpocsV(event,0,0,maxret);
rw=TimeRanges(2,:);rw=rw/(60*60);rw=rw(rw>0); r=ones(1,length(rw));
% plot(2,1,1,'position',[0.2 0.25 0.3 0.03])
% bar(rw,r)
% axis([0 24 0 1])
% title('Running Wheel Activity')

fnout=[tank,'-',mousename,'-',recorddate,'-',event];
eval(['save ',pathout,fnout,'.mat TimeRanges rw r  -mat']);
end
invoke(TTX,'CloseTank');


