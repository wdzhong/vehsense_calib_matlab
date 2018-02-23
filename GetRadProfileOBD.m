function [ example_turn_rad_profile,example_turn_disp_profile,example_turn_heading_profile,example_turn_gyr_profile,example_speed_profile] = GetRadProfileOBD( gyr_turn_event_comp_res,turn_vel_profile_indexes,obd_speed,turn_ind,time_obd,sys_time_gyro,filter_butter_res_gyro )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
gyr_turn_start_ind = gyr_turn_event_comp_res(turn_ind,1);
gyr_turn_end_ind = gyr_turn_event_comp_res(turn_ind,3);

example_turn_gyr_profile(:,2) =  filter_butter_res_gyro(gyr_turn_start_ind:gyr_turn_end_ind,1);
example_turn_gyr_profile(:,1) =  sys_time_gyro(gyr_turn_start_ind:gyr_turn_end_ind,1);


obd_speed_start_ind = turn_vel_profile_indexes(turn_ind,1);
obd_speed_end_ind = turn_vel_profile_indexes(turn_ind,3);

example_speed_profile(:,1) =  time_obd(obd_speed_start_ind:obd_speed_end_ind,1);
example_speed_profile(:,2) =  obd_speed(obd_speed_start_ind:obd_speed_end_ind,1);


example_turn_rad_profile = zeros(obd_speed_end_ind-obd_speed_start_ind,2);
example_turn_disp_profile = zeros(obd_speed_end_ind-obd_speed_start_ind,3);
example_turn_heading_profile = zeros(obd_speed_end_ind-obd_speed_start_ind,3);

start_speed = obd_speed(obd_speed_start_ind,1);
start_time_obd = time_obd(obd_speed_start_ind,1);
k=1;
total_disp = 0;
total_heading = 0;

for i=obd_speed_start_ind+1:obd_speed_end_ind
    
    end_time_obd = time_obd(i,1);
    delta_disp = start_speed*((end_time_obd-start_time_obd)/1000);
    total_disp = total_disp+delta_disp;
    example_turn_disp_profile(k,1) = start_time_obd;
    example_turn_disp_profile(k,2) = delta_disp;
    example_turn_disp_profile(k,3) = total_disp;
    
    [c1 temp_gyr_end_ind] = min(abs(sys_time_gyro-end_time_obd));
    
    if(temp_gyr_end_ind>gyr_turn_end_ind)
        temp_gyr_end_ind = gyr_turn_end_ind;
    end
    
    delta_heading = 0;
    
    start_gyr = filter_butter_res_gyro(gyr_turn_start_ind,1);
    start_time_gyr = sys_time_gyro(gyr_turn_start_ind,1);
    for j=gyr_turn_start_ind+1:temp_gyr_end_ind
        end_time_gyr = sys_time_gyro(j,1);
        delta_heading = delta_heading + start_gyr*((end_time_gyr-start_time_gyr)/1000);
        
        start_time_gyr = end_time_gyr;
        start_gyr = filter_butter_res_gyro(j,1);
    end
    total_heading = total_heading+delta_heading;
    example_turn_heading_profile(k,1) = start_time_obd;
    example_turn_heading_profile(k,2) = delta_heading;
    example_turn_heading_profile(k,3) = total_heading;
    
    gyr_turn_start_ind = temp_gyr_end_ind;
    rad = delta_disp/delta_heading;
    
    example_turn_rad_profile(k,1) = start_time_obd;
    example_turn_rad_profile(k,2) = rad;
    
    start_speed = obd_speed(i,1);
    start_time_obd = end_time_obd;
    k=k+1;
end


end

