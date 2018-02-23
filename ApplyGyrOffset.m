function [ filter_butter_raw_gyro_fin ] = ApplyGyrOffset( filter_butter_raw_gyro_ini,gyro_offsets )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[num_rows_gyr_offset,num_cols_gyr_offset] = size(gyro_offsets);


for i=1:num_rows_gyr_offset
    strt_ind = gyro_offsets(i,1);
    end_ind =  gyro_offsets(i,2);
    x_off = gyro_offsets(i,5);
    y_off = gyro_offsets(i,6);
    z_off = gyro_offsets(i,7);
    
    for j=strt_ind:end_ind
        filter_butter_raw_gyro_ini(j,1) = filter_butter_raw_gyro_ini(j,1) - x_off;
        filter_butter_raw_gyro_ini(j,2) = filter_butter_raw_gyro_ini(j,2) - y_off;
        filter_butter_raw_gyro_ini(j,3) = filter_butter_raw_gyro_ini(j,3) - z_off;
    end
end
filter_butter_raw_gyro_fin = filter_butter_raw_gyro_ini;

end

