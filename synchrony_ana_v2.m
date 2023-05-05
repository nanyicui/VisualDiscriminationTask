% synchrony_ana_v2

latcriteria=150;
for ratnum=[170 172 173 174 176 177 178 187 196 197]
    for bsl=1:20
        exper=['BSL',num2str(bsl)];
        
        for epi=1:20
            %%
            fname=[num2str(ratnum),'-',exper,'\episode',num2str(epi),'\winsize9\matlab'];
            
            ff=fopen(['D:\Dropbox\SfN2013\rw',fname,'.mat'],'r'); if ff<0 continue; else fclose(ff); end
            
            load(['D:\Dropbox\SfN2013\rw' num2str(ratnum) '-' exper '\episode' num2str(epi) '\winsize9\matlab.mat'])
            
            
            %%
            UnitsS1=allVSUnits(:,1:VSlength(1));
            UnitsW=allVSUnits(:,VSlength(1)+1:VSlength(1)+VSlength(2));
            UnitsS2=allVSUnits(:,VSlength(1)+VSlength(2)+1:end);
            
            epochsS1=allVSepochs(1:VSlength(1)/2000);
            epochsW=allVSepochs(VSlength(1)/2000+1:(VSlength(1)+VSlength(2))/2000);
            epochsS2=allVSepochs((VSlength(1)+VSlength(2))/2000+1:end);
            
            % remove off periods that are shorter than 10 ms
            offstart=offstart-4;offend=offend+4;
           
            offstart_=offstart(diff(offperiods,1,2)>5);
            offend_=offend(diff(offperiods,1,2)>5);
            
            offstartS1=offstart_(offend_<=VSlength(1));
            offendS1=offend_(offend_<=VSlength(1));
            
            offstartW=offstart_(offstart_>=VSlength(1) & offend_<=(VSlength(1)+VSlength(2)))-VSlength(1);
            offendW=offend_(offend_>=VSlength(1) & offend_<=(VSlength(1)+VSlength(2)) & offend_>(offstartW(1)+VSlength(1)))-VSlength(1);
            
            offstartS2=offstart_(offend_>(VSlength(1)-VSlength(2)))-VSlength(1)-VSlength(2);
            offendS2=offend_(offend_>(VSlength(1)-VSlength(2)) & offend_>(offstartS2(1)+VSlength(1)+VSlength(2)))-VSlength(1)-VSlength(2);
            
            %% last/first spike latency
            % S1
            [latstdstartS1,latstdendS1,latmeanstartS1,latmeanendS1,latmedianstartS1,latmedianendS1,numneuronstartS1,numneuronendS1]=latency_offperiods_lastspike(UnitsS1,offstartS1,offstartS1,latcriteria);
            % W
            [latstdstartW,latstdendW,latmeanstartW,latmeanendW,latmedianstartW,latmedianendW,numneuronstartW,numneuronendW]=latency_offperiods_lastspike(UnitsW,offstartW,offstartW,latcriteria);
            % S2
            [latstdstartS2,latstdendS2,latmeanstartS2,latmeanendS2,latmedianstartS2,latmedianendS2,numneuronstartS2,numneuronendS2]=latency_offperiods_lastspike(UnitsS2,offstartS2,offstartS2,latcriteria);
            
            %% centre of mass latency
            % S1 
            % [lat_pre_offstartS1,lat_post_offendS1]=latency_offperiods_centerofmass(offstartS1,offendS1,UnitsS1,latcriteria);
            % W
            % [lat_pre_offstartW,lat_post_offendW]=latency_offperiods_centerofmass(offstartW,offendW,UnitsW,latcriteria);
            % S2
            % [lat_pre_offstartS2,lat_post_offendS2]=latency_offperiods_centerofmass(offstartS2,offendS2,UnitsS2,latcriteria);

            %%
            
            offstartS1=epochidentify(epochsS1,offstartS1);
            offstartS1=[offstartS1 latmeanstartS1 latmedianstartS1 latstdstartS1 numneuronstartS1];
            
            offstartW=epochidentify(epochsW,offstartW);
            offstartW=[offstartW latmeanstartW latmedianstartW latstdstartW numneuronstartW];
            
            offstartS2=epochidentify(epochsS2,offstartS2);
            offstartS2=[offstartS2 latmeanstartS2 latmedianstartS2 latstdstartS2 numneuronstartS2];
            
            offendS1=epochidentify(epochsS1,offendS1);
            offendS1=[offendS1 latmeanendS1 latmedianendS1 latstdendS1 numneuronendS1];
            
            offendW=epochidentify(epochsW,offendW);
            offendW=[offendW latmeanendW latmedianendW latstdendW numneuronendW];
            
            offendS2=epochidentify(epochsS2,offendS2);
            offendS2=[offendS2 latmeanendS2 latmedianendS2 latstdendS2 numneuronendS2];
            

            save(['D:\Dropbox\SfN2013\offperiods_latency\rw' num2str(ratnum) '-' exper '-epi' num2str(episode) '.mat'],...
                'UnitsS1','UnitsW','UnitsS2','epochsS1','epochsW','epochsS2',...
                'offstartS1','offstartW','offstartS2','offendS1','offendW','offendS2')
            
            clearvars offendS2 offendW offendS1 offstartS2 offstartW offstartS1 ...
                latstdstartS2 latstdendS2 latmeanstartS2 latmeanendS2 latmedianstartS2 latmedianendS2 numneuronstartS2 numneuronendS2...
                latstdstartW latstdendW latmeanstartW latmeanendW latmedianstartW latmedianendW numneuronstartW numneuronendW...
                latstdstartS1 latstdendS1 latmeanstartS1 latmeanendS1 latmedianstartS1 latmedianendS1 numneuronstartS1 numneuronendS1...
                UnitsS1 UnitsW UnitsS2 epochsS1 epochsW epochsS2
                
                
            
        end
    end
end









