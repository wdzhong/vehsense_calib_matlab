function [ speed ] = EstimateSpeed( calibrated_raw_acc,gps_speed,time_raw_acc,time_gps )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[num_row_acc,num_cols_acc] = size(calibrated_raw_acc);
[num_row_gps,num_col_gps] = size(gps_speed);

gps_strt_ind = 4;
acc_strt_ind = 1;

speed_ind = 1;

speed = zeros(num_row_acc,1);

for i=gps_strt_ind:num_row_gps
    init_speed = gps_speed(i,1);
    if(i+1<=num_row_gps)
        acc_end_ind = acc_strt_ind + (floor(time_gps(i+1,1)-time_gps(i,1))*200);
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

