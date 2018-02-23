function [ acc_phases_comp ] = getACCPhases( obd_speed,time_obd )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[num_rows_obd,num_cols_obd] = size(obd_speed);
acc_phases = zeros(1,4);

%start_index:end_index:start_time:end_time

acc_phases_comp = zeros(1,4);

prev_val = obd_speed(1,1);

i = 2;
k=0;

while(i<=num_rows_obd)
    if((obd_speed(i,1)>prev_val)&&(obd_speed(i,1)>5))
        acc_phase_start_ind = i;
        
        k=i;
        while(obd_speed(k,1)>=prev_val)
        
            if(k==num_rows_obd)
                break;
            end
            prev_val = obd_speed(k,1);
            k = k+1;
        end
        acc_phase_end_ind = k;
        
        if(((acc_phase_end_ind-acc_phase_start_ind)>=25)&&(abs(obd_speed(acc_phase_end_ind,1)-obd_speed(acc_phase_start_ind,1))>10))  % 5sec 
            acc_phases(1,1) = acc_phase_start_ind;
            acc_phases(1,2) = acc_phase_end_ind;
            acc_phases(1,3) = time_obd(acc_phase_start_ind,1);
            acc_phases(1,4) = time_obd(acc_phase_end_ind,1);
            acc_phases_comp = vertcat(acc_phases_comp,acc_phases);
        end
        
        i=k;
    end
    prev_val = obd_speed(i,1);
    i = i+1;
end
[num_rows_acc_phases,num_cols_acc_phases] = size(acc_phases_comp);
acc_phases_comp = acc_phases_comp(2:num_rows_acc_phases,:);
end

