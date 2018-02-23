function [ synced_data ] = Sync_With_OBD( data,index )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[num_rows,num_cols] = size(data);

synced_data = data(index:num_rows,:);
end

