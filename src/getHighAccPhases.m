function [ high_acc_phases_comp ] = getHighAccPhases( acc_obd_smoo,time_obd )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[num_rows_obd,num_cols_obd] = size(acc_obd_smoo);
high_acc_phases = zeros(1,4);

%start_index:end_index:start_time:end_time

high_acc_phases_comp = zeros(1,4);


acc_thresh = 0.5;
acc_max_thresh = 1;
max = 0;
i = 1;
k=0;

while(i<=num_rows_obd)
    if(acc_obd_smoo(i,1)>acc_thresh)
        acc_phase_start_ind = i;
        k=i;
        max = acc_obd_smoo(i,1);
        while(acc_obd_smoo(k,1)>=acc_thresh)
            if(acc_obd_smoo(k,1)>max)
                max = acc_obd_smoo(k,1);
            end
            
            if(k==num_rows_obd)
                break;
            end
            k = k+1;
        end
        acc_phase_end_ind = k;
        
        if(((acc_phase_end_ind-acc_phase_start_ind)>=5)&&(max>acc_max_thresh))  % 1sec 
            high_acc_phases(1,1) = acc_phase_start_ind;
            high_acc_phases(1,2) = acc_phase_end_ind;
            high_acc_phases(1,3) = time_obd(acc_phase_start_ind,1);
            high_acc_phases(1,4) = time_obd(acc_phase_end_ind,1);
            high_acc_phases_comp = vertcat(high_acc_phases_comp,high_acc_phases);
        end
        
        i=k;
    end
    i = i+1;
end
[num_rows_acc_phases,num_cols_acc_phases] = size(high_acc_phases_comp);
high_acc_phases_comp = high_acc_phases_comp(2:num_rows_acc_phases,:);

end

