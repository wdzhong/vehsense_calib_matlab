function [ move_phase_data_mean_lin_acc_comp ] = DetectMovementPhasesMean( still_phase_data_comp,time_lin_acc )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

[still_phase_num_rows,still_phase_num_cols] = size(still_phase_data_comp);
[mean_lin_res_num_rows,mean_lin_res_num_cols] = size(time_lin_acc);

move_phase_data_mean_lin_acc = zeros(1,4);
move_phase_data_mean_lin_acc_comp = zeros(1,4);

for i=1:still_phase_num_rows
    still_strt_ind = still_phase_data_comp(i,1);
    still_strt_time = still_phase_data_comp(i,3);
    still_end_ind = still_phase_data_comp(i,2);
    still_end_time = still_phase_data_comp(i,4);
    if(i==1)
        if(still_strt_ind>1)
            move_phase_data_mean_lin_acc(1,1) = 1;
            move_phase_data_mean_lin_acc(1,2) = still_strt_ind-1;
            move_phase_data_mean_lin_acc(1,3) = 0;
            move_phase_data_mean_lin_acc(1,4) = still_strt_time;
            if((move_phase_data_mean_lin_acc(1,2)-move_phase_data_mean_lin_acc(1,1))>=2000)
                move_phase_data_mean_lin_acc_comp = vertcat(move_phase_data_mean_lin_acc_comp,move_phase_data_mean_lin_acc);
            end
            if(i==still_phase_num_rows)
                if(still_end_ind<mean_lin_res_num_rows)
                    move_phase_data_mean_lin_acc(1,1) = still_end_ind+1;
                    move_phase_data_mean_lin_acc(1,2) = mean_lin_res_num_rows;
                    move_phase_data_mean_lin_acc(1,3) = still_end_time;
                    move_phase_data_mean_lin_acc(1,4) = time_lin_acc(mean_lin_res_num_rows,1);
                    if((move_phase_data_mean_lin_acc(1,2)-move_phase_data_mean_lin_acc(1,1))>=2000)
                        move_phase_data_mean_lin_acc_comp = vertcat(move_phase_data_mean_lin_acc_comp,move_phase_data_mean_lin_acc);
                
                    end
                end
            
            else
            move_phase_data_mean_lin_acc(1,1) = still_end_ind+1;
            move_phase_data_mean_lin_acc(1,2) = still_phase_data_comp(i+1,1)-1;
            move_phase_data_mean_lin_acc(1,3) = still_end_time;
            move_phase_data_mean_lin_acc(1,4) = still_phase_data_comp(i+1,3);
            if((move_phase_data_mean_lin_acc(1,2)-move_phase_data_mean_lin_acc(1,1))>=2000)
                move_phase_data_mean_lin_acc_comp = vertcat(move_phase_data_mean_lin_acc_comp,move_phase_data_mean_lin_acc);
            end
            end
            
        else
            move_phase_data_mean_lin_acc(1,1) = still_end_ind+1;
            move_phase_data_mean_lin_acc(1,2) = still_phase_data_comp(i+1,1)-1;
            move_phase_data_mean_lin_acc(1,3) = still_end_time;
            move_phase_data_mean_lin_acc(1,4) = still_phase_data_comp(i+1,3);
        end
%         if((move_phase_data_mean_lin_acc(1,2)-move_phase_data_mean_lin_acc(1,1))>=2000)
%             move_phase_data_mean_lin_acc_comp = vertcat(move_phase_data_mean_lin_acc_comp,move_phase_data_mean_lin_acc);
%         end
     else
        if(i+1<=still_phase_num_rows)
            move_phase_data_mean_lin_acc(1,1) = still_end_ind+1;
            move_phase_data_mean_lin_acc(1,2) = still_phase_data_comp(i+1,1)-1;
            move_phase_data_mean_lin_acc(1,3) = still_end_time;
            move_phase_data_mean_lin_acc(1,4) = still_phase_data_comp(i+1,3);
            if((move_phase_data_mean_lin_acc(1,2)-move_phase_data_mean_lin_acc(1,1))>=2000)
                move_phase_data_mean_lin_acc_comp = vertcat(move_phase_data_mean_lin_acc_comp,move_phase_data_mean_lin_acc);
            end
        end
        
        if(i==still_phase_num_rows)
            if(still_end_ind<mean_lin_res_num_rows)
                move_phase_data_mean_lin_acc(1,1) = still_end_ind+1;
                move_phase_data_mean_lin_acc(1,2) = mean_lin_res_num_rows;
                move_phase_data_mean_lin_acc(1,3) = still_end_time;
                move_phase_data_mean_lin_acc(1,4) = time_lin_acc(mean_lin_res_num_rows,1);
                if((move_phase_data_mean_lin_acc(1,2)-move_phase_data_mean_lin_acc(1,1))>=2000)
                    move_phase_data_mean_lin_acc_comp = vertcat(move_phase_data_mean_lin_acc_comp,move_phase_data_mean_lin_acc);
                
                end
            end
        end
    end
end

[num_rows_mov_phase,num_cols_move_phase] = size(move_phase_data_mean_lin_acc_comp);
move_phase_data_mean_lin_acc_comp = move_phase_data_mean_lin_acc_comp(2:num_rows_mov_phase,:);
end

