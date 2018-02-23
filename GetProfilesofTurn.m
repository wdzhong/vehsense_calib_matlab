function [ my_turn_profile,my_lat_acc_prof,my_long_acc_prof,my_strt_ind,my_end_ind,my_strt_ind_lin_acc,my_end_ind_lin_acc] = GetProfilesofTurn( gyr_turn_event_comp,lin_acc_turn_event_comp,caliberated_butter_gyro,calibrated_raw_acc,caliberated_lin_acc_butter,gyr_ind,lin_ind )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
my_strt_ind = gyr_turn_event_comp(gyr_ind,1);
my_end_ind  = gyr_turn_event_comp(gyr_ind,3);

num_points_gyr = (my_end_ind - my_strt_ind) + 1;

my_strt_ind_lin_acc = lin_acc_turn_event_comp(lin_ind,1);
my_end_ind_lin_acc = lin_acc_turn_event_comp(lin_ind,3);

num_points_lin_acc = (my_end_ind_lin_acc - my_strt_ind_lin_acc) + 1;
% making num points of gyro profile equal lin_acc profile.

diff_num_points = num_points_lin_acc - num_points_gyr;

if(diff_num_points>0)
    num_points_to_be_added = diff_num_points/2;
    my_strt_ind = my_strt_ind - num_points_to_be_added;
    my_end_ind = my_end_ind + num_points_to_be_added;
else
    num_points_to_be_added = abs(diff_num_points)/2;
    my_strt_ind_lin_acc = my_strt_ind_lin_acc - num_points_to_be_added;
    my_end_ind_lin_acc = my_end_ind_lin_acc + num_points_to_be_added;
end


my_turn_profile = caliberated_butter_gyro(my_strt_ind:my_end_ind,3);
my_long_acc_prof = calibrated_raw_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,2);
my_lat_acc_prof = caliberated_lin_acc_butter(my_strt_ind_lin_acc:my_end_ind_lin_acc,1);

% figure
% plot(time_raw_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,1),calibrated_raw_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,2))


end

