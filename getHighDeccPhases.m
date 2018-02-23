function [ high_decc_phases_comp ] = getHighDeccPhases( acc_obd_smoo,time_obd )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_obd,num_cols_obd] = size(acc_obd_smoo);
high_decc_phases = zeros(1,4);

%start_index:end_index:start_time:end_time

high_decc_phases_comp = zeros(1,4);


acc_thresh = -0.5;
acc_max_thresh = -1;
min = 0;
i = 1;
k=0;

while(i<=num_rows_obd)
    if(acc_obd_smoo(i,1)<acc_thresh)
        decc_phase_start_ind = i;
        k=i;
        min = acc_obd_smoo(i,1);
        while(acc_obd_smoo(k,1)<=acc_thresh)
            if(acc_obd_smoo(k,1)<min)
                min = acc_obd_smoo(k,1);
            end
            
            if(k==num_rows_obd)
                break;
            end
            k = k+1;
        end
        decc_phase_end_ind = k;
        
        if(((decc_phase_end_ind-decc_phase_start_ind)>=5)&&(min<acc_max_thresh))  % 1sec 
            high_decc_phases(1,1) = decc_phase_start_ind;
            high_decc_phases(1,2) = decc_phase_end_ind;
            high_decc_phases(1,3) = time_obd(decc_phase_start_ind,1);
            high_decc_phases(1,4) = time_obd(decc_phase_end_ind,1);
            high_decc_phases_comp = vertcat(high_decc_phases_comp,high_decc_phases);
        end
        
        i=k;
    end
    i = i+1;
end
[num_rows_acc_phases,num_cols_acc_phases] = size(high_decc_phases_comp);
high_decc_phases_comp = high_decc_phases_comp(2:num_rows_acc_phases,:);

end

