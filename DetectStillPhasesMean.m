function [ still_phase_data_comp ] = DetectStillPhasesMean( mean_lin_res_acc_comp,time_lin_acc )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
[num_rows,num_cols] = size(mean_lin_res_acc_comp);
i = 1;
k = 0;
thresh = 0.075;
still_phase_data = zeros(1,4);
still_phase_data_comp = zeros(1,4);
num_points_still  = 0;

while(i<=num_rows)
    if((mean_lin_res_acc_comp(i,1)<=thresh))
        k=i;
        still_phase_data(1,1) = i;
        still_phase_data(1,3) = time_lin_acc(i,:);
        while((mean_lin_res_acc_comp(k,1)<=thresh))
            if(k+1>num_rows)
                break;
            end
            k = k+1;
           num_points_still = num_points_still + 1;
        end
        
        if(num_points_still>1000)
             still_phase_data(1,2) = k;
             still_phase_data(1,4) = time_lin_acc(k,:);
             still_phase_data_comp = vertcat(still_phase_data_comp,still_phase_data);
        end
        i = k;
        
    end
   num_points_still = 0;
   i = i+1;
end

[still_phase_num_rows,still_phase_num_cols] = size(still_phase_data_comp);
still_phase_data_comp = still_phase_data_comp(2:still_phase_num_rows,:);

end

