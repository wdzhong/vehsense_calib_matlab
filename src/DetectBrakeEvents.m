function [ brake_event_comp ] = DetectBrakeEvents( calibrated_raw_acc,time_raw_acc )
%UNTITLED28 Summary of this function goes here
%   Detailed explanation goes here

[num_row_raw_acc,num_cols_raw_acc] = size(calibrated_raw_acc);
brake_thres = -0.01;
brake_event = zeros(1,9);
brake_event_comp = zeros(1,9);
k = 1;
minima = 0;
minima_ind = 1;
i=1;



while(i<=num_row_raw_acc)
    
    if(calibrated_raw_acc(i,2)<=brake_thres)
        brake_event(1,1) = i;
        brake_event(1,2) = time_raw_acc(i,1);
        k=i+1;
        minima =0;
        
        
        while((calibrated_raw_acc(k,2)<=brake_thres)&&(k<num_row_raw_acc))
            if(calibrated_raw_acc(k,2)<minima)
                minima = calibrated_raw_acc(k,2);
                minima_ind = k;
            end
            k = k+1;
        end
        
        brake_event(1,3) = k;
        brake_event(1,4) = time_raw_acc(k,1);
        brake_event(1,5) = minima;
        brake_event(1,6) = minima_ind;
        brake_event(1,7) = time_raw_acc(minima_ind,1);
        brake_event(1,8) = brake_event(1,2) 
        brake_event(1,9) = brake_event(1,4) ;
        
        brake_time = brake_event(1,4) - brake_event(1,2);
        
        seconds_start = floor(brake_event(1,2)/1000);
        seconds_end = floor(brake_event(1,4)/1000);
        
        if(seconds_start<60)
            brake_event(1,2) = seconds_start;
        else
            min_start = int2str(floor(seconds_start/60));
            r_start = int2str(rem(seconds_start , 60 ));
            start_time = strcat(min_start,'.',r_start);
            brake_event(1,2) = str2double(start_time);
        end
        
        if(seconds_end<60)
            brake_event(1,4) = seconds_end;
        else
            min_end = int2str(floor(seconds_end/60));
            r_end = int2str(rem(seconds_end , 60 ));
            end_time = strcat(min_end,'.',r_end);
            brake_event(1,4) = str2double(end_time);
        end
        
        
       
        if((minima<=-0.1)&&(brake_time>1000))
            brake_event_comp = vertcat(brake_event_comp,brake_event);
        end
    i = k;
    end
    
 
    i = i+1;
    
end
[num_rows_brake_events,num_cols_brake_events] = size(brake_event_comp);
brake_event_comp = brake_event_comp(2:num_rows_brake_events,:);
end

