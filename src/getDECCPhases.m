function [ decc_phases_comp ] = getDECCPhases( obd_speed,time_obd )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_obd,num_cols_obd] = size(obd_speed);
decc_phases = zeros(1,4);

decc_phases_comp = zeros(1,4);

prev_val = obd_speed(1,1);

i = 2;
k=0;

while(i<num_rows_obd)
    if((obd_speed(i,1)<=prev_val)&&(obd_speed(i,1)>=10))
        decc_phase_start_ind = i;
        k=i;
        while((obd_speed(k,1)<=prev_val)&&(obd_speed(k,1)>=5))
        
            if(k==num_rows_obd)
                break;
            end
            prev_val = obd_speed(k,1);
            k = k+1;
        end
        decc_phase_end_ind = k;
        
        if((decc_phase_end_ind-decc_phase_start_ind)>=25&&(abs(obd_speed(decc_phase_end_ind,1)-obd_speed(decc_phase_start_ind,1))>10))  % 5sec 
            decc_phases(1,1) = decc_phase_start_ind;
            decc_phases(1,2) = decc_phase_end_ind;
            decc_phases(1,3) = time_obd(decc_phase_start_ind,1);
            decc_phases(1,4) = time_obd(decc_phase_end_ind,1);
            decc_phases_comp = vertcat(decc_phases_comp,decc_phases);
        end
        
        i=k;
    end
    prev_val = obd_speed(i,1);
    i = i+1;
    
end
[num_rows_decc_phases,num_cols_decc_phases] = size(decc_phases_comp);
decc_phases_comp = decc_phases_comp(2:num_rows_decc_phases,:);
end

