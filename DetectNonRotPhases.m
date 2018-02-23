function [ non_rot_phase_data_comp ] = DetectNonRotPhases( rot_phase_data_comp,time_raw_gyro )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rot_phase_num_rows,rot_phase_num_cols] = size(rot_phase_data_comp);
[num_rows_gyro,num_cols_gyro] = size(time_raw_gyro);

non_rot_phase_data = zeros(1,4);
non_rot_phase_data_comp = zeros(1,4);

for i=1:rot_phase_num_rows
    rot_strt_ind = rot_phase_data_comp(i,1);
    rot_strt_time = rot_phase_data_comp(i,3);
    rot_end_ind = rot_phase_data_comp(i,2);
    rot_end_time = rot_phase_data_comp(i,4);
    if(i==1)
        if(rot_strt_ind>1)
            non_rot_phase_data(1,1) = 1;
            non_rot_phase_data(1,2) = rot_strt_ind-1;
            non_rot_phase_data(1,3) = 0;
            non_rot_phase_data(1,4) = rot_strt_time;
            if((non_rot_phase_data(1,2)-non_rot_phase_data(1,1))>=2000)
                non_rot_phase_data_comp = vertcat(non_rot_phase_data_comp,non_rot_phase_data);
            end
            if(i==rot_phase_num_rows)
                if(rot_end_ind<num_rows_gyro)
                    non_rot_phase_data(1,1) = rot_end_ind+1;
                    non_rot_phase_data(1,2) = num_rows_gyro;
                    non_rot_phase_data(1,3) = rot_end_time;
                    non_rot_phase_data(1,4) = time_raw_gyro(num_rows_gyro,1);
                    if((non_rot_phase_data(1,2)-non_rot_phase_data(1,1))>=2000)
                        non_rot_phase_data_comp = vertcat(non_rot_phase_data_comp,non_rot_phase_data);
                
                    end
                end
            
            else
            non_rot_phase_data(1,1) = rot_end_ind+1;
            non_rot_phase_data(1,2) = rot_phase_data_comp(i+1,1)-1;
            non_rot_phase_data(1,3) = rot_end_time;
            non_rot_phase_data(1,4) = rot_phase_data_comp(i+1,3);
            if((non_rot_phase_data(1,2)-non_rot_phase_data(1,1))>=2000)
                non_rot_phase_data_comp = vertcat(non_rot_phase_data_comp,non_rot_phase_data);
            end
            end
            
        else
            non_rot_phase_data(1,1) = rot_end_ind+1;
            non_rot_phase_data(1,2) = rot_phase_data_comp(i+1,1)-1;
            non_rot_phase_data(1,3) = rot_end_time;
            non_rot_phase_data(1,4) = rot_phase_data_comp(i+1,3);
        end
%         if((move_phase_data_mean_lin_acc(1,2)-move_phase_data_mean_lin_acc(1,1))>=2000)
%             move_phase_data_mean_lin_acc_comp = vertcat(move_phase_data_mean_lin_acc_comp,move_phase_data_mean_lin_acc);
%         end
     else
        if(i+1<=rot_phase_num_rows)
            non_rot_phase_data(1,1) = rot_end_ind+1;
            non_rot_phase_data(1,2) = rot_phase_data_comp(i+1,1)-1;
            non_rot_phase_data(1,3) = rot_end_time;
            non_rot_phase_data(1,4) = rot_phase_data_comp(i+1,3);
            if((non_rot_phase_data(1,2)-non_rot_phase_data(1,1))>=2000)
                non_rot_phase_data_comp = vertcat(non_rot_phase_data_comp,non_rot_phase_data);
            end
        end
        
        if(i==rot_phase_num_rows)
            if(rot_end_ind<num_rows_gyro)
                non_rot_phase_data(1,1) = rot_end_ind+1;
                non_rot_phase_data(1,2) = num_rows_gyro;
                non_rot_phase_data(1,3) = rot_end_time;
                non_rot_phase_data(1,4) = time_raw_gyro(num_rows_gyro,1);
                if((non_rot_phase_data(1,2)-non_rot_phase_data(1,1))>=2000)
                    non_rot_phase_data_comp = vertcat(non_rot_phase_data_comp,non_rot_phase_data);
                
                end
            end
        end
    end
end

[num_rows_mov_phase,num_cols_move_phase] = size(non_rot_phase_data_comp);
non_rot_phase_data_comp = non_rot_phase_data_comp(2:num_rows_mov_phase,:);
end


