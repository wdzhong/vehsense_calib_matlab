function [ time_stamp_gyro,sys_time_gyro,gyro ] = getGyro( gyro_data )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
time_stamp_gyro = gyro_data(:,1);
sys_time_gyro = gyro_data(:,2);
gyro = gyro_data(:,4:6);
[num_row_raw_gyro,num_col_raw_gyro] = size(gyro);

% figure
% plot(time_raw_gyro,raw_gyro(:,1))

% making num of rows multiple of 10 for ease of calculation
num_row_raw_gyro = num_row_raw_gyro - mod(num_row_raw_gyro,10);
time_stamp_gyro = time_stamp_gyro(1:num_row_raw_gyro,:);
sys_time_gyro = sys_time_gyro(1:num_row_raw_gyro,:);
gyro = gyro(1:num_row_raw_gyro,:);

end

