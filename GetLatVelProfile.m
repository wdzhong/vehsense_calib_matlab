function [ my_lat_velocity ] = GetLatVelProfile( my_lat_acc_prof,init_lat_vel )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[num_row_my_prof,num_cols_my_prof] = size(my_lat_acc_prof);
my_lat_velocity = zeros(num_row_my_prof,1);

for j=1:num_row_my_prof
    init_lat_vel = init_lat_vel + (my_lat_acc_prof(j,1)*(0.005));
    my_lat_velocity(j,1) = init_lat_vel;
    
end

end

