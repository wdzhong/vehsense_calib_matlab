function [ time_obd,obd_speed ] = getOBDData( data_file_obd )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
time_obd = data_file_obd(:,1);
obd_speed = data_file_obd(:,3);

[num_rows_obd, num_cols_obd] = size(time_obd);

% time_initial = time_obd(1,1);

% for i=1:num_rows_obd
%     time_obd(i,1) = (time_obd(i,1) - time_initial)/1000;
% end



end

