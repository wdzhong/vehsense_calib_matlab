function [ valid_cali_profiles_comp ] = GetValidCalibrationProfiles( move_phase_data_mean_lin_acc_comp,time_lin_acc,rot_phase_data_comp,mean_lin_res_acc_comp )
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here
valid_cali_profiles_comp = zeros(1,14);

[num_rows_mov_phase,num_cols_mov_phase] = size(move_phase_data_mean_lin_acc_comp);
[num_rows_rot_phase,num_cols_rot_phase] = size(rot_phase_data_comp);


for i=1:num_rows_mov_phase
    move_phase_start_ind = move_phase_data_mean_lin_acc_comp(i,1);
    move_phase_end_ind =  move_phase_data_mean_lin_acc_comp(i,2);
    valid_cali_profile = zeros(1,14);
    valid_mov_prof = false;
    
    
    %movement for greater than 10 seconds
    valid_cali_profile(1,5) = move_phase_start_ind;
    valid_cali_profile(1,6) = time_lin_acc(move_phase_start_ind,:);
    valid_cali_profile(1,7) = move_phase_end_ind;
    valid_cali_profile(1,8) = time_lin_acc(move_phase_end_ind,:);
    lin_acc_mov_profile = mean_lin_res_acc_comp(move_phase_start_ind:move_phase_end_ind,:);
    
    [pks,locs] = findpeaks(lin_acc_mov_profile);
    
    if(pks(1,1)>=0.1)%local maxima greater than 0.1m/sec^2
        %valid movement data
        max_ind = move_phase_start_ind + locs(1,1);
        
        %check if there is any rotation sensed during this period
        
        for k=1:num_rows_rot_phase
            rot_phase_start = rot_phase_data_comp(k,1);
            rot_phase_end = rot_phase_data_comp(k,2);
            if(max_ind<=rot_phase_start)
                valid_cali_profile(1,7) = max_ind;
                valid_cali_profile(1,8) = time_lin_acc(max_ind,:);
                valid_mov_prof = true;
                break;
                
            else
                if((move_phase_start_ind<=rot_phase_start)&&(max_ind<=rot_phase_start)||((move_phase_start_ind>=rot_phase_end)&&(max_ind>=rot_phase_end)))
                    valid_mov_prof = true;
                    valid_cali_profile(1,7) = max_ind;
                    valid_cali_profile(1,8) = time_lin_acc(max_ind,:);
                else
                    valid_mov_prof = false;
                    break;
                    
                end
            end
        end
        
    else
        valid_mov_prof=false;
    end
    
    if(valid_mov_prof)
        %Calculate the caliberation parameters
        valid_cali_profile(1,9) = 1;
        valid_cali_profiles_comp = vertcat(valid_cali_profiles_comp,valid_cali_profile);
    end
    
    if(~valid_mov_prof)
        %Calculate the caliberation parameters
        valid_cali_profile(1,9) = 0;
        valid_cali_profiles_comp = vertcat(valid_cali_profiles_comp,valid_cali_profile);
    end
end
[num_rows_valid_cali,num_cols_valid_cali] = size(valid_cali_profiles_comp);
valid_cali_profiles_comp = valid_cali_profiles_comp(2:num_rows_valid_cali,:);
end

