function [ still_phase_data_comp ] = DetectStillPhasesSTD( std_dev_raw_acc_comp,time_raw_acc )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
[std_dev_raw_num_rows,std_dev_raw_num_cols] = size(std_dev_raw_acc_comp);

num_points_still = 0;
x_std_still = 0.01;
y_std_still = 0.01;
z_std_still = 0.01;
still_phase_data = zeros(1,4);
still_phase_data_comp = zeros(1,4);
i=1;

while(i<=std_dev_raw_num_rows)
    if((std_dev_raw_acc_comp(i,1)<=x_std_still)&&(std_dev_raw_acc_comp(i,2)<=y_std_still)&&(std_dev_raw_acc_comp(i,3)<=z_std_still))
        k=i;
        still_phase_data(1,1) = i;
        still_phase_data(1,3) = time_raw_acc(i,:);
        while((std_dev_raw_acc_comp(k,1)<=x_std_still)&&(std_dev_raw_acc_comp(k,2)<=y_std_still)&&(std_dev_raw_acc_comp(k,3)<=z_std_still))
            if(k+1>std_dev_raw_num_rows)
                break;
            end
            k = k+1;
           num_points_still = num_points_still + 1;
        end
        
        if(num_points_still>100)
             still_phase_data(1,2) = k;
             still_phase_data(1,4) = time_raw_acc(k,:);
             still_phase_data_comp = vertcat(still_phase_data_comp,still_phase_data);
        end
        i = k;
        
    end
   num_points_still = 0;
   i = i+1;
end

end

