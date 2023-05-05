function [latlong,mean_latlong,rms_latlong]=longestxlat(input_data,FS)

input_data_sort=sort(input_data(:,1));latlong=input_data_sort(end-ceil(length(input_data)/FS):end);

mean_latlong=mean(latlong);

rms_latlong=std(latlong)/sqrt(length(latlong));


end