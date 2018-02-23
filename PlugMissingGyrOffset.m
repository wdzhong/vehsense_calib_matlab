function [ gyro_offsets_final ] = PlugMissingGyrOffset( gyro_offsets_or )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

gyr_offset = zeros(1,7);

if(gyro_offsets_or(1,1)~=1)
    gyr_offset(1,1) = 1;
    gyr_offset(1,2) = gyro_offsets_or(1,1);
    gyr_offset(1,3) = 0;
    gyr_offset(1,4) = gyro_offsets_or(1,3);
    gyr_offset(1,5) = gyro_offsets_or(1,5);
    gyr_offset(1,6) = gyro_offsets_or(1,6);
    gyr_offset(1,7) = gyro_offsets_or(1,7);
    
end

gyro_offsets_final = vertcat(gyr_offset,gyro_offsets_or);

end

