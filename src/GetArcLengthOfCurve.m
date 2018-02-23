function [ my_disp_prof ] = GetArcLengthOfCurve( my_vel_prof )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[num_row_my_prof,num_cols_my_prof] = size(my_vel_prof);

my_disp_prof = zeros(num_row_my_prof,1);
for j=1:num_row_my_prof
    disp = my_vel_prof(j,1)*0.005;
    my_disp_prof(j,1) = disp;
end

end

