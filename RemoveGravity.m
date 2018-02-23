function [ processed_data,gravity ] = RemoveGravity( data,alpha )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here



[num_rows,num_cols] = size(data);

gravity = zeros(num_rows,num_cols);

processed_data = zeros(num_rows,num_cols);


for i=1:num_rows

    if(i==1)
        gravity(i,1) = alpha*1 + (1-alpha)*data(i,1);
        gravity(i,2) = alpha*1 + (1-alpha)*data(i,2);
        gravity(i,3) = alpha*1 + (1-alpha)*data(i,3);
    
    else
    
        gravity(i,1) = alpha*gravity(i-1,1) + (1-alpha)*data(i,1);
        gravity(i,2) = alpha*gravity(i-1,2) + (1-alpha)*data(i,2);
        gravity(i,3) = alpha*gravity(i-1,3) + (1-alpha)*data(i,3);  
    end
    processed_data(i,1) = data(i,1) - gravity(i,1);
    processed_data(i,2) = data(i,2) - gravity(i,2);
    processed_data(i,3) = data(i,3) - gravity(i,3);

end
end

