function [ my_turn_pos_profile ] = GetTurnPosProfile( lat_disp_steps,my_vel_prof )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
[num_row_my_prof,num_cols_my_prof] = size(my_vel_prof);

my_turn_pos_profile = zeros(num_row_my_prof,2);

x_ini = 0;
y_ini = 0;

for j=1:num_row_my_prof
    
    dx = lat_disp_steps(j,1);
    hyp = my_vel_prof(j,1)*(0.005);
    dy = ((hyp^2) - (dx^2))^(1/2);
    
    %dy = dx/(tan(theta_prof(j,1)));
    x_ini = x_ini + dx;
    y_ini = y_ini + dy;
    
    my_turn_pos_profile(j,1) = x_ini;
    my_turn_pos_profile(j,2) = y_ini;
    
%     x_ini = x;
%     y_ini = y;
    
end

end

