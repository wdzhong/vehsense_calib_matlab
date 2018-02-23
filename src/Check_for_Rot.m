function [ result ] = Check_for_Rot( strt_time,target_time,sys_time_gyro,mean_res_gyro_comp )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

[c index_start] = min(abs(sys_time_gyro-strt_time));
[c index_end] = min(abs(sys_time_gyro-target_time));
thresh = 0.02;
num_points_rot = 0;
result =0;
i = index_start;
while(i<=index_end)
     if((mean_res_gyro_comp(i,1)>=thresh))
        k=i;
        
        while((mean_res_gyro_comp(k,1)>=thresh))
            if(k+1>index_end)
                break;
            end
            k = k+1;
           num_points_rot = num_points_rot + 1;
        end
        
%         figure
%         plot(mean_res_gyro_comp(i:k,1))
        
        if(num_points_rot>50)
             rot_phase_profile = mean_res_gyro_comp(i:k,1);
             [max_value, index_number] = max(rot_phase_profile);
             
             if(max_value>=0.02)
                result = 1;
             end
        end
        i = k;
        
     end
   num_points_rot = 0;
   i = i+1;
end

end

