function [ my_vel_prof ] = GetVelProfile( my_long_acc_prof,init_vel )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[num_row_my_prof,num_cols_my_prof] = size(my_long_acc_prof);
my_vel_prof = zeros(num_row_my_prof,1);

for j=1:num_row_my_prof
    init_vel = init_vel + my_long_acc_prof(j,1)*0.005;
    my_vel_prof(j,1) = init_vel;
end

end

