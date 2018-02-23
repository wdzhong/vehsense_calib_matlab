function [ time_stamp_lin_acc,sys_time_lin_acc,lin_acc ] = getRawLinAcc( raw_lin_data )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

time_stamp_lin_acc = raw_lin_data(:,1);
sys_time_lin_acc = raw_lin_data(:,2);
lin_acc = raw_lin_data(:,4:6);
[num_row_raw_lin_acc,num_col_raw_lin_acc] = size(lin_acc);


% making num of rows multiple of 10 for ease of calculation
num_row_raw_lin_acc = num_row_raw_lin_acc - mod(num_row_raw_lin_acc,10);
time_stamp_lin_acc = time_stamp_lin_acc(1:num_row_raw_lin_acc,:);
sys_time_lin_acc = sys_time_lin_acc(1:num_row_raw_lin_acc,:);
lin_acc = lin_acc(1:num_row_raw_lin_acc,:);

end

