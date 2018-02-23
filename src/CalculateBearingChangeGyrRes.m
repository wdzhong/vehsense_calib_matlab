function [ theta_comp_res ] = CalculateBearingChangeGyrRes( gyr_turn_event_comp_res,filter_butter_res_gyro)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_gyr_turn_events,num_cols_gyr_turn_events] = size(gyr_turn_event_comp_res);

theta_comp_res = zeros(num_rows_gyr_turn_events,1);
for j=1:num_rows_gyr_turn_events
    
%     figure 
%     plot(time_raw_gyro(gyr_turn_event_comp(j,1):gyr_turn_event_comp(j,3),1),caliberated_butter_gyro(gyr_turn_event_comp(j,1):gyr_turn_event_comp(j,3),3))
    
    ex_turn_profile = filter_butter_res_gyro(gyr_turn_event_comp_res(j,1):gyr_turn_event_comp_res(j,3),1);
    
    [num_row_ex_prof,num_cols_ex_prof] = size(ex_turn_profile);
    
    theta = 0;
    for i=1:num_row_ex_prof
        theta = theta + ex_turn_profile(i,1)*0.005;
    end
    theta_comp_res(j,1) = radtodeg(theta);
end

end

