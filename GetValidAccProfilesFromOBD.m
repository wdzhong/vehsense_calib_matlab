function [ valid_cali_profiles_obd ] = GetValidAccProfilesFromOBD( acc_profiles_obd,rot_phase_data_comp,sys_time_gyro,time_raw_gyro )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
valid_cali_profiles_obd = zeros(1,4);


[num_rows_acc_prof_obd,num_cols_acc_prof_obd] = size(acc_profiles_obd);
[num_rows_rot_phase,num_cols_rot_phase] = size(rot_phase_data_comp);

for i=1:num_rows_acc_prof_obd
    valid_cali_profile = zeros(1,4);
    valid_acc = 0;
    acc_strt_ind = acc_profiles_obd(i,1);
    acc_end_ind = acc_profiles_obd(i,2);
    
    acc_strt_time = acc_profiles_obd(i,3);
    acc_end_time = acc_profiles_obd(i,4);
    
    [c1 start_ind_gyr] = min(abs(sys_time_gyro-acc_strt_time));
    [c2 end_ind_gyr] = min(abs(sys_time_gyro-acc_end_time));
    
    valid_cali_profile(1,1) = start_ind_gyr;
    valid_cali_profile(1,2) = end_ind_gyr;
    valid_cali_profile(1,3) = time_raw_gyro(start_ind_gyr,1);
    valid_cali_profile(1,4) = time_raw_gyro(end_ind_gyr,1);
    
    
    
    for k=1:num_rows_rot_phase
            rot_phase_start = rot_phase_data_comp(k,1);
            rot_phase_end = rot_phase_data_comp(k,2);
            if(end_ind_gyr<=rot_phase_start)
                valid_acc = 1;
                break;
            else
                if((start_ind_gyr<=rot_phase_start)&&(end_ind_gyr<=rot_phase_start)||((start_ind_gyr>=rot_phase_end)&&(end_ind_gyr>=rot_phase_end)))
                    valid_acc = 1;
                    %break;
                else
                    valid_acc = 0;
                    if((start_ind_gyr<rot_phase_start)&&(rot_phase_start<end_ind_gyr))
                        if((rot_phase_start-start_ind_gyr)>=1000) %5sec
                            valid_acc = 1;
                            valid_cali_profile(1,2) = rot_phase_start;
                            valid_cali_profile(1,4) = time_raw_gyro(rot_phase_start,1);
                        end
                        
                    end
                    
                    if((rot_phase_start<start_ind_gyr)&&(rot_phase_end<end_ind_gyr))
                        if((end_ind_gyr-rot_phase_end)>=1000)
                            valid_acc = 1;
                            valid_cali_profile(1,1) = rot_phase_end;
                            valid_cali_profile(1,3) = time_raw_gyro(rot_phase_end,1);
                        end
                    end
                    
                    if((rot_phase_start>start_ind_gyr)&&(rot_phase_end<end_ind_gyr))
                        if((rot_phase_start-start_ind_gyr)>=1000)
                            valid_acc = 1;
                            valid_cali_profile(1,2) = rot_phase_start;
                            valid_cali_profile(1,4) = time_raw_gyro(rot_phase_start,1);
                        else
                            if((end_ind_gyr-rot_phase_end)>=1000)
                                valid_acc = 1;
                                valid_cali_profile(1,1) = rot_phase_end;
                                valid_cali_profile(1,3) = time_raw_gyro(rot_phase_end,1);
                            end
                        end
                    end
                    
                    break;
                end
            end
    end
    
    if(valid_acc==1)
        valid_cali_profiles_obd = vertcat(valid_cali_profiles_obd,valid_cali_profile);
    end
   
    
end
[num_rows_valid_cali,num_cols_valid_cali] = size(valid_cali_profiles_obd);
valid_cali_profiles_obd = valid_cali_profiles_obd(2:num_rows_valid_cali,:); 
end

