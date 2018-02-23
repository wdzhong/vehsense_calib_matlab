function [ my_lat_disp_vel_prof,lat_disp_steps ] = GetLatDisp( my_lat_velocity )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
[num_row_my_prof,num_cols_my_prof] = size(my_lat_velocity);
my_lat_disp_vel_prof = zeros(num_row_my_prof,1);
lat_disp_steps = zeros(num_row_my_prof,1);
int_lat_disp = 0;

for j=1:num_row_my_prof
    d_lat_disp = my_lat_velocity(j,1)*(0.005);
    lat_disp_steps(j,1) = d_lat_disp;
    int_lat_disp = int_lat_disp + d_lat_disp;
    my_lat_disp_vel_prof(j,1) = int_lat_disp;
    
end

end

