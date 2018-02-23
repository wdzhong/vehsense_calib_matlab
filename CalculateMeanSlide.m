function [ avg ] = CalculateMeanSlide( data,win_length )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
[num_row,num_col] = size(data);

avg = zeros(num_row,num_col);

for i=1:num_row
    if(i+win_length>num_row)
        break;
    end
    
    for j=1:num_col
         avg(i,j) = mean(data(i:i+win_length,j));
         
    end
    
end

end

