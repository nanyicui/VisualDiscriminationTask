%%% Test for linearity within session %%%

%% All Latencies
clear all;close all;
pathname1 = 'D:\Dropbox\Batch4\Batch4rawdata\';
latencyallanim=[];
for animID=1:8
    %figure(animID)
    for cond=1:2
        
        if cond==1
            condition='CO';
        else condition='SD';
        end
        fileID = fopen([pathname1,'mouse',num2str(animID),condition,'.mat'],'r');
        if fileID<0
            continue
        end
        
        load([pathname1,'mouse',num2str(animID),condition,'.mat'])
        latencyallanim=[latencyallanim;[[TS(:,2)-TS(:,1)],TS(:,2:4)]];
        
    end
end
figure;
hist(latencyallanim(:,1),2000);title('Histogram of latencies (initiate-touch) of all animals in both CO & SD condition')
xlabel('latency /second');h=findobj(gca,'Type','patch');
set(gca,'Xscale','log');set(h,'FaceColor',[0,0,0],'EdgeColor',[0,0,0]);

latencyallanim_15=latencyallanim(latencyallanim(:,2)<900,1);
latencyallanim_30=latencyallanim(latencyallanim(:,2)<1800,1);
latencyallanim_45=latencyallanim(latencyallanim(:,2)<2700,1);
latencyallanim_60=latencyallanim(latencyallanim(:,2)<3600,1);

