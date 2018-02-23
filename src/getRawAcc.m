function [ time_stamp,sys_time_acc,acc ] = getRawAcc( raw_acc_data )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


time_stamp = raw_acc_data(:,1);
sys_time_acc = raw_acc_data(:,2);
acc = raw_acc_data(:,4:6);


% [num_row_raw_acc,num_col_raw_acc] = size(acc);
% 
% % making num of rows multiple of 10 for ease of calculation
% num_row_raw_acc = num_row_raw_acc - mod(num_row_raw_acc,10);
% time_stamp = time_stamp(1:num_row_raw_acc,:);
% sys_time_acc = sys_time_acc(1:num_row_raw_acc,:);
% acc = acc(1:num_row_raw_acc,:);

end

