function [smoo_data] = SmoothDataApp( data,alpha )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

[num_row,num_col] = size(data);

smoo = zeros(1,num_col);
smoo = data(1,:);

smoo_data = zeros(num_row,num_col);


%Testing changing from 0.008 to 0.0015

for i=1:num_row
    
    for j=1:num_col
        smoo(1,j) = smoo(1,j) + alpha*(data(i,j)-smoo(1,j));
    end
   
    
    
    smoo_data(i,:) = smoo;
    
    
end






% figure
% plot(time_raw_gyro,smoo_raw_gyro_comp(:,1))
% 
% figure
% plot(time_raw_gyro,smoo_raw_gyro_comp(:,2))
% 
% figure
% plot(time_raw_gyro,smoo_raw_gyro_comp(:,3))
end

