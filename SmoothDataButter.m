function [smoo_data] = SmoothDataButter(data,order,alpha,type)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
[num_row,num_col] = size(data);

smoo_data = zeros(num_row,num_col);

[b,a] = butter(order,alpha,type);
smoo_data =  filter(b,a,data);


% figure
% plot(time_raw_gyro,filter_butter_raw_gyro(:,1))
end

