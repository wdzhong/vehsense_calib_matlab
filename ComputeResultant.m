function [res_data] = ComputeResultant(data)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
[num_row,num_col] = size(data);
res_data = zeros(num_row,1);

for i=1:num_row
    res_data(i,:) = sqrt(((data(i,1))^2)+((data(i,2))^2)+((data(i,3))^2));
end
end

