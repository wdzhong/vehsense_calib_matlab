function [ std_dev ] = CalculateSTDSlide( data,win_length )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[num_row,num_col] = size(data);

std_dev = zeros(num_row,num_col);

for i=1:num_row
    if(i+win_length>num_row)
        break;
    end
    
    for j=1:num_col
         std_dev(i,j) = std(data(i:i+win_length,j));
         
    end
    
end

end

