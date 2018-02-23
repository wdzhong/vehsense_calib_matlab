function [ calibrated_raw_acc ] = Calibrate_Raw_Acc( calibration_para_comp,smoo_raw_acc_comp )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_cali_para,num_cols_cali_para] = size(calibration_para_comp);
[num_row_raw_acc,num_col_raw_acc] = size(smoo_raw_acc_comp);

calibrated_raw_acc = zeros(num_row_raw_acc,3);

for i=1:num_rows_cali_para
    
    x_vec = [calibration_para_comp(i,10),calibration_para_comp(i,11),calibration_para_comp(i,12)]';
    y_vec = [calibration_para_comp(i,7),calibration_para_comp(i,8),calibration_para_comp(i,9)]';
    z_vec = [calibration_para_comp(i,1),calibration_para_comp(i,2),calibration_para_comp(i,3)]';

    offset_x = calibration_para_comp(i,4);
    offset_y = calibration_para_comp(i,5);
    offset_z = calibration_para_comp(i,6);
    
    offset_mat = [offset_x,offset_y,offset_z]
    
    rot_mat = horzcat(x_vec,y_vec,z_vec);
    
    strt_ind = calibration_para_comp(i,13);
    end_ind = calibration_para_comp(i,14);
    
    for j=strt_ind:end_ind
        uncal_acc = smoo_raw_acc_comp(j,:)-offset_mat;
        calibrated_raw_acc(j,:) = (uncal_acc*rot_mat);
    end
    
end

end

