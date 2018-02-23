function [ calib_para ] = CalculateCalibPara( strt_time,target_time,sys_time_acc,smoo_lin )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    
    calib_para = zeros(1,3);
    [c index_start] = min(abs(sys_time_acc-strt_time));
    [c index_end] = min(abs(sys_time_acc-target_time));

    mov_profile = smoo_lin(index_start:index_end,:);
    
%      figure
%      plot(mov_profile(:,1))
%      hold on
%      plot(mov_profile(:,2))
%      hold on
%      plot(mov_profile(:,3))
    
    
    
    x_avg_mov = mean(mov_profile(:,1));
    y_avg_mov = mean(mov_profile(:,2));
    z_avg_mov = mean(mov_profile(:,3));
    
    mag_mov = sqrt((x_avg_mov^2) + (y_avg_mov^2) + (z_avg_mov^2));
    
    x_uni_mov = x_avg_mov/mag_mov;
    y_uni_mov = y_avg_mov/mag_mov;
    z_uni_mov = z_avg_mov/mag_mov;
    
    calib_para(1,1) = x_uni_mov;
    calib_para(1,2) = y_uni_mov;
    calib_para(1,3) = z_uni_mov;
    


end

