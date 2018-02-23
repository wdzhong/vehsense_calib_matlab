function [ rot_phase_data_comp ] = DetectRotPhases( mean_res_gyro_comp,time_raw_gyro )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

[num_rows,num_cols] = size(mean_res_gyro_comp);

num_points_rot = 0;

thresh = 0.02;
rot_phase_data = zeros(1,4);
rot_phase_data_comp = zeros(1,4);
i=1;


while(i<=num_rows)
    if((mean_res_gyro_comp(i,1)>=thresh))
        k=i;
        rot_phase_data(1,1) = i;
        rot_phase_data(1,3) = time_raw_gyro(i,:);
        while((mean_res_gyro_comp(k,1)>=thresh))
            if(k+1>num_rows)
                break;
            end
            k = k+1;
           num_points_rot = num_points_rot + 1;
        end
        
        if(num_points_rot>100)
             rot_phase_data(1,2) = k;
             rot_phase_data(1,4) = time_raw_gyro(k,:);
             rot_phase_profile = mean_res_gyro_comp(i:k,1);
             [max_value, index_number] = max(rot_phase_profile);
             
             if(max_value>=0.02)
                rot_phase_data_comp = vertcat(rot_phase_data_comp,rot_phase_data);
             end
        end
        i = k;
        
    end
   num_points_rot = 0;
   i = i+1;
end
[num_rows_rot_phase,num_cols_rot_phase] = size(rot_phase_data_comp);

rot_phase_data_comp = rot_phase_data_comp(2:num_rows_rot_phase,:);

end

