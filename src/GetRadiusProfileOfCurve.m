function [ my_rad_profile,my_rad_profile_x_acc ] = GetRadiusProfileOfCurve( my_disp_prof,d_theta_my_turn_prof,my_vel_prof,my_lat_acc_prof )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

[num_row_my_prof,num_cols_my_prof] = size(my_vel_prof);
my_rad_profile = zeros(num_row_my_prof,1);
my_rad_profile_x_acc = zeros(num_row_my_prof,1);

for j=1:num_row_my_prof
    %using length of arc method
    rad = my_disp_prof(j,1)/d_theta_my_turn_prof(j,1);
    my_rad_profile(j,1) = rad;
    
    %using lat_acc
    
    rad_x_acc = ((my_vel_prof(j,1))^2)/my_lat_acc_prof(j,1);
    my_rad_profile_x_acc(j,1) =  rad_x_acc;
end

end

