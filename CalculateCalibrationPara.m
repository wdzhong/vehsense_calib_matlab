function [ calibration_para_comp ] = CalculateCalibrationPara( valid_cali_profiles_comp,smoo_raw_acc_comp,smoo_lin_acc_comp )
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here
calibration_para_comp = zeros(1,14);
[num_rows_valid_cali,num_cols_valid_cali] = size(valid_cali_profiles_comp);
[num_row_raw_acc,num_col_raw_acc] = size(smoo_raw_acc_comp);

for i=1:num_rows_valid_cali

    calibration_para = zeros(1,4);
    still_phase_start_ind =  valid_cali_profiles_comp(i,1);
    still_phase_end_ind = valid_cali_profiles_comp(i,3);
    
    still_profile = smoo_raw_acc_comp(still_phase_start_ind:still_phase_end_ind,:);
    
    %calculate gravity vector
    
    x_avg_still = mean(still_profile(:,1));
    y_avg_still = mean(still_profile(:,2));
    z_avg_still = mean(still_profile(:,3));
    
    mag_still = sqrt((x_avg_still^2) + (y_avg_still^2) + (z_avg_still^2));
    
    x_uni_still = x_avg_still/mag_still;
    y_uni_still = y_avg_still/mag_still;
    z_uni_still = z_avg_still/mag_still;
    
    z_vec = [x_uni_still,y_uni_still,z_uni_still];
    
    
    
    %Calculate y vector
    
    mov_start_ind = valid_cali_profiles_comp(i,10);
    mov_end_ind = valid_cali_profiles_comp(i,12);
    
    mov_profile = smoo_lin_acc_comp(mov_start_ind:mov_end_ind,:);
    
    x_avg_mov = mean(mov_profile(:,1));
    y_avg_mov = mean(mov_profile(:,2));
    z_avg_mov = mean(mov_profile(:,3));
    
    mag_mov = sqrt((x_avg_mov^2) + (y_avg_mov^2) + (z_avg_mov^2));
    
    x_uni_mov = x_avg_mov/mag_mov;
    y_uni_mov = y_avg_mov/mag_mov;
    z_uni_mov = z_avg_mov/mag_mov;
    
    calibration_para(1,1) = x_uni_still;
    calibration_para(1,2) = y_uni_still;
    calibration_para(1,3) = z_uni_still;
    
    calibration_para(1,4) = x_avg_still;
    calibration_para(1,5) = y_avg_still;
    calibration_para(1,6) = z_avg_still;
    %calibration_para(1,4) = z_vec;
    
    calibration_para(1,7) = x_uni_mov;
    calibration_para(1,8) = y_uni_mov;
    calibration_para(1,9) = z_uni_mov;
    
    y_vec = [x_uni_mov,y_uni_mov,z_uni_mov];
    
    %calibration_para(1,8) = y_vec;
    %calculate x vector
    
    x_vec = cross(y_vec,z_vec);
    
    %magnitude of x_vec should be one. 
    
    
    calibration_para(1,10) = x_vec(1);
    calibration_para(1,11) = x_vec(2);
    calibration_para(1,12) = x_vec(3);
    
    %calibration_para(1,12) = x_vec;
    
    % These caliberation parameters can be used until the car is
    % stationary. We calucalte these parameters again for next stii-move
    % cycle
    
    if((i==1))
        if(still_phase_start_ind~=1) 
        calibration_para(1,13) = 1;
        else
        calibration_para(1,13) = still_phase_start_ind;
        end
    else
      calibration_para(1,13) = still_phase_start_ind;
    end
    
    if(i+1>num_rows_valid_cali)
        calibration_para(1,14) = num_row_raw_acc;
    else
        calibration_para(1,14) = valid_cali_profiles_comp(i+1,1);
    end
    
    [num_row_cali,num_cols_cali] = size(calibration_para_comp);
    
    
    if(num_row_cali>=2)
        if((abs(calibration_para_comp(i,7) - x_uni_mov)<0.5)&&(abs(calibration_para_comp(i,8) - y_uni_mov)<0.5)&&(abs(calibration_para_comp(i,9) - z_uni_mov)<0.5))
            calibration_para_comp = vertcat(calibration_para_comp,calibration_para);
        else
            calibration_para(1,7) = calibration_para_comp(i,7);
            calibration_para(1,8) = calibration_para_comp(i,8);
            calibration_para(1,9) = calibration_para_comp(i,9);
            
            y_vec = [calibration_para_comp(i,7),calibration_para_comp(i,8),calibration_para_comp(i,9)];
            
            x_vec = cross(y_vec,z_vec);
            %calibration_para_comp(i,14) = calibration_para(1,14);
            
            calibration_para(1,10) = x_vec(1);
            calibration_para(1,11) = x_vec(2);
            calibration_para(1,12) = x_vec(3);
            calibration_para_comp = vertcat(calibration_para_comp,calibration_para);
            
        end
    else
         calibration_para_comp = vertcat(calibration_para_comp,calibration_para);
    end
end


[num_rows_cali_para,num_cols_cali_para] = size(calibration_para_comp);
calibration_para_comp = calibration_para_comp(2:num_rows_cali_para,:);


end

