function [ gps_speed_mod,time_gps_mod ] = preProcessGPSspeed(gps_speed,time_gps)
%UNTITLED Summary of this function goes here
% Replaces weird 0 speed values with previous time_stamp values. Also fills
% in values for timestamps where gps is locked. This happens when the
% vehicle is stationary

gps_speed_mod = zeros(1,1);
time_gps_mod = zeros(1,1);

[num_rows,num_cols] = size(gps_speed);

i = 1;
while(i<=num_rows)
    
    if((gps_speed(i,1)==0)&&(i~=1))
        if(gps_speed(i-1,1)>5)
            gps_speed(i,1)=gps_speed(i-1,1);
        end
    end
    
    
    if(i~=1)
        if(((time_gps(i,1)-time_gps(i-1,1))>5))
            k = time_gps(i-1,1)+1;
            while(k<time_gps(i,1))
                time_gps_mod = vertcat(time_gps_mod,k);
                gps_speed_mod = vertcat(gps_speed_mod,0);
                k=k+1;
            end
        end
    end
       
 
    gps_speed_mod = vertcat(gps_speed_mod,gps_speed(i,1));
    time_gps_mod = vertcat(time_gps_mod,time_gps(i,1));
    i = i+1;
end


end

