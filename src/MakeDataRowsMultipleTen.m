function [ mod_data] = MakeDataRowsMultipleTen( data )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


[num_row,num_col] = size(data);

% making num of rows multiple of 10 for ease of calculation
num_row = num_row - mod(num_row,10);
mod_data = data(1:num_row,:);

end

