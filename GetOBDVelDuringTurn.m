function [ turn_vel_profile_indexes ] = GetOBDVelDuringTurn( gyr_turn_event_comp_res,time_obd )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


[num_rows_gyr_turn,num_cols_gyr_turn] = size(gyr_turn_event_comp_res);
turn_vel_profile_indexes = zeros(num_rows_gyr_turn,5);

for i=1:num_rows_gyr_turn
    turn_strt_time = gyr_turn_event_comp_res(i,10);
    turn_end_time = gyr_turn_event_comp_res(i,11);
    
    [c1 start_ind] = min(abs(time_obd-turn_strt_time));
    [c2 end_ind] = min(abs(time_obd-turn_end_time));
    
    turn_vel_profile_indexes(i,1)= start_ind;
    turn_vel_profile_indexes(i,2)= time_obd(start_ind,1);
    turn_vel_profile_indexes(i,3)= end_ind;
    turn_vel_profile_indexes(i,4)= time_obd(end_ind,1);
    turn_vel_profile_indexes(i,5)= (time_obd(end_ind,1) - time_obd(start_ind,1)); % Turn Time
    
    
end

end

