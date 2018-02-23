function [ time_stamp_gps,latLon,speed,bearing ] = getGPSData( gps_dat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
time_stamp_gps = gps_dat(:,2);
latLon = gps_dat(:,3:4);
speed = gps_dat(:,5);
bearing = gps_dat(:,6);

[num_rows_gps, num_cols_gps] = size(time_stamp_gps);

time_initial = time_stamp_gps(1,1);
for i=1:num_rows_gps
    time_stamp_gps(i,1) = (time_stamp_gps(i,1) - time_initial)/1000;
end

 figure
 plot(time_stamp_gps,speed)
% 
figure
plot(time_stamp_gps,bearing)

end

