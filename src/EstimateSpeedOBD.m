function [ speed ] = EstimateSpeedOBD( calibrated_raw_acc,obd_speed,time_raw_acc,time_obd,start_ind,acc_or_obd,sys_time_acc )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[num_row_acc,num_cols_acc] = size(calibrated_raw_acc);
[num_row_obd,num_col_obd] = size(obd_speed);

if(acc_or_obd==0)
    obd_strt_ind = start_ind;
    acc_strt_ind = 1;
else
    obd_strt_ind = 1;
    acc_strt_ind = start_ind;
end

speed_ind = 1;

speed = zeros(num_row_acc,1);

for i=obd_strt_ind:num_row_obd
    init_speed = obd_speed(i,1);
    if(i+1<=num_row_obd)
        target_time = time_obd(i+1,1);
        [c, acc_end_ind] = min(abs(sys_time_acc-target_time));
        %acc_end_ind = acc_strt_ind + (floor(time_obd(i+1,1)-time_obd(i,1))*200);
    end
    if(acc_end_ind>=num_row_acc)
        acc_end_ind = num_row_acc;
    end
    
    for j=acc_strt_ind:acc_end_ind
        init_speed = init_speed + calibrated_raw_acc(j,2)*0.005;
        speed(speed_ind,1) = init_speed;
        speed_ind = speed_ind + 1;
    end
    acc_strt_ind = acc_end_ind+1;
end

%time_raw_acc = time_raw_acc(1121:num_row_acc,1);
% figure
% plot(time_raw_acc(1121:num_row_acc-1,1),speed)

end

