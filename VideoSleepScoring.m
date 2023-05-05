%% Video Analysis - Video Sleep Scoring
fileinfo=VideoReader('D:\Batch5_Alan_EVDT_160714\1-20140716115200.mp4');
allframesdiff=[];

for n=1:324 % 3hours

frames=read(fileinfo,[1000*(n-1)+1 1000*n]);

frames_rgbmean=squeeze(mean(frames,3));

clearvars frames

blackpart=frames_rgbmean<50;

blackpart=frames_rgbmean.*blackpart;

blackpart_resized=blackpart(35:285,300:440,:); % right cage only

clear blackpart frames_rgbmean

blackpart_diff=squeeze(diff(blackpart_resized,1,3));

clearvars blackpart_resized

blackpart_diff_sum=squeeze(sum(sum(blackpart_diff,1),2));

clearvars blackpart_diff

allframesdiff=[allframesdiff;blackpart_diff_sum;];

clearvars blackpart_diff_sum

end

%% frequency analysis
% Fs=30;
% L=length(allframesdiff);
% 
% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
% Y = fft(allframesdiff,NFFT)/L;
% f = Fs/2*linspace(0,1,NFFT/2+1);
% 
% % Plot single-sided amplitude spectrum.
% plot(f,2*abs(Y(1:NFFT/2+1))) 
% title('Single-Sided Amplitude Spectrum of y(t)')
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|')

movement=find(allframesdiff>(mean(allframesdiff)+1.2*std(allframesdiff)) | allframesdiff<(mean(allframesdiff)-1.2*std(allframesdiff)));
sleepscore=length(movement);

