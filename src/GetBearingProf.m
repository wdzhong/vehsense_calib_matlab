function [ d_theta_my_turn_prof,theta_prof ] = GetBearingProf( my_turn_profile )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[num_row_my_prof,num_cols_my_prof] = size(my_turn_profile);

d_theta_my_turn_prof = zeros(num_row_my_prof,1);
theta_prof = zeros(num_row_my_prof,1);
%Caculating dthetas and theta profile

theta_init = 0;

for j=1:num_row_my_prof
    theta_step = abs(my_turn_profile(j,1)*0.005);
    d_theta_my_turn_prof(j,1) = theta_step;
    
    theta_init = theta_init + theta_step;
    theta_prof(j,1) = theta_init;
end

end

