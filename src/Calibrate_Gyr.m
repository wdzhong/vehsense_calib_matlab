function [ caliberated_mean_gyr ] = Calibrate_Gyr( calibration_para_comp,mean_raw_gyro_comp)
%UNTITLED21 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_cali_para,num_cols_cali_para] = size(calibration_para_comp);
[num_row_raw_gyro,num_col_raw_gyro] = size(mean_raw_gyro_comp);

for i=1:num_rows_cali_para
    
    x_vec = [calibration_para_comp(i,10),calibration_para_comp(i,11),calibration_para_comp(i,12)]';
    y_vec = [calibration_para_comp(i,7),calibration_para_comp(i,8),calibration_para_comp(i,9)]';
    z_vec = [calibration_para_comp(i,1),calibration_para_comp(i,2),calibration_para_comp(i,3)]';

    rot_mat = horzcat(x_vec,y_vec,z_vec);
    
    strt_ind = calibration_para_comp(i,13);
    end_ind = calibration_para_comp(i,14);
    
    % Attempt to calibrate gyroscope values
    
    if(end_ind>num_row_raw_gyro)
        end_ind = num_row_raw_gyro;  % num of entries in gyro data can be different.
    end
    
    for j=strt_ind:end_ind
        caliberated_mean_gyr(j,:) = (mean_raw_gyro_comp(j,:)*rot_mat);
    end
    
    
end

end

