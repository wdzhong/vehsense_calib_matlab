function [ caliberated_lin_acc ] = Calibrate_Lin_Acc( calibration_para_comp,smoo_lin_acc_comp )
%UNTITLED22 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_cali_para,num_cols_cali_para] = size(calibration_para_comp);
[num_row_raw_lin_acc,num_cols_raw_lin_acc] = size(smoo_lin_acc_comp);
for i=1:num_rows_cali_para
    
    x_vec = [calibration_para_comp(i,10),calibration_para_comp(i,11),calibration_para_comp(i,12)]';
    y_vec = [calibration_para_comp(i,7),calibration_para_comp(i,8),calibration_para_comp(i,9)]';
    z_vec = [calibration_para_comp(i,1),calibration_para_comp(i,2),calibration_para_comp(i,3)]';

    rot_mat = horzcat(x_vec,y_vec,z_vec);
    
    strt_ind = calibration_para_comp(i,13);
    end_ind = calibration_para_comp(i,14);
    
    %Caliberating lin_acc values
    
    if(end_ind>num_row_raw_lin_acc)
        end_ind = num_row_raw_lin_acc;  % num of entries in gyro data can be different.
    end
    
    for j=strt_ind:end_ind
        caliberated_lin_acc(j,:) = (smoo_lin_acc_comp(j,:)*rot_mat);
        
    end
    
end


end

