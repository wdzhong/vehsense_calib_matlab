function [ mod_data ] = RemoveLeadData( data,num_points )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
[num_row,num_col] = size(data);

mod_data = data(num_points:num_row,:);

end

