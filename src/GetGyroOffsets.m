function [ gyro_offsets_comp ] = GetGyroOffsets( non_rot_phase_data_comp,filter_butter_raw_gyro,time_raw_gyro )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
gyro_offsets = zeros(1,7);
gyro_offsets_comp = zeros(1,7);

[num_rows_non_rot,num_cols_non_rot] = size(non_rot_phase_data_comp);
[num_rows_gyro,num_cols_gyro] = size(filter_butter_raw_gyro);

for i=1:num_rows_non_rot
    non_rot_strt_ind = non_rot_phase_data_comp(i,1);
    non_rot_end_ind = non_rot_phase_data_comp(i,2);
    non_rot_strt_time = non_rot_phase_data_comp(i,3);
    non_rot_end_time = non_rot_phase_data_comp(i,4);
    
    non_rot_prof = filter_butter_raw_gyro(non_rot_strt_ind:non_rot_end_ind,:);
    
    x_offset = mean(non_rot_prof(:,1));
    y_offset = mean(non_rot_prof(:,2));
    z_offset = mean(non_rot_prof(:,3));
    
    %gyro_offsets_comp has information about the gyro offsets and the
    %indices where these offsets are valid during calibration
    if(i+1<=num_rows_non_rot)
        gyro_offsets(1,1) = non_rot_strt_ind;
        gyro_offsets(1,2) = non_rot_phase_data_comp(i+1,1);
        gyro_offsets(1,3) = non_rot_end_time;
        gyro_offsets(1,4) = non_rot_phase_data_comp(i+1,3);
        gyro_offsets(1,5) = x_offset;
        gyro_offsets(1,6) = y_offset;
        gyro_offsets(1,7) = z_offset;
        
        gyro_offsets_comp = vertcat(gyro_offsets_comp,gyro_offsets);
    else
        gyro_offsets(1,1) = non_rot_strt_ind;
        gyro_offsets(1,2) = num_rows_gyro;
        gyro_offsets(1,3) = non_rot_end_time;
        gyro_offsets(1,4) = time_raw_gyro(num_rows_gyro,1);
        gyro_offsets(1,5) = x_offset;
        gyro_offsets(1,6) = y_offset;
        gyro_offsets(1,7) = z_offset;
        
        gyro_offsets_comp = vertcat(gyro_offsets_comp,gyro_offsets);
    end
  
    
end
[num_rows_gyr_off,num_cols_gyr_off] = size(gyro_offsets_comp);
gyro_offsets_comp = gyro_offsets_comp(2:num_rows_gyr_off,:);
end

