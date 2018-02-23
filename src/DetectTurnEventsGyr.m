function [ gyr_turn_event_comp ] = DetectTurnEventsGyr( caliberated_butter_gyro,time_raw_gyro )
%UNTITLED29 Summary of this function goes here
%   Detailed explanation goes here

[num_row_raw_gyro,num_cols_raw_gyro] = size(caliberated_butter_gyro);

gyr_turn_thres_pos = 0.01;
gyr_turn_thres_neg = -0.01;
gyr_turn_event = zeros(1,9);
gyr_turn_event_comp = zeros(1,9);
k = 1;
maxima = 0;
maxima_ind = 1;
minima = 0;
minima_ind = 1;
i=1;


% Testing Using filtered data from butterworth filter

%Brake events
while(i<=num_row_raw_gyro)
    % +ve turns
    if(caliberated_butter_gyro(i,3)>=gyr_turn_thres_pos)
        gyr_turn_event(1,1) = i;
        gyr_turn_event(1,2) = time_raw_gyro(i,1);
        gyr_turn_event(1,8) = time_raw_gyro(i,1);
        k=i+1;
        maxima =0;
        
        
        while((caliberated_butter_gyro(k,3)>=gyr_turn_thres_pos)&&(k<num_row_raw_gyro))
            if(caliberated_butter_gyro(k,3)>maxima)
                maxima = caliberated_butter_gyro(k,3);
                maxima_ind = k;
            end
            k = k+1;
        end
        
        gyr_turn_event(1,3) = k;
        gyr_turn_event(1,4) = time_raw_gyro(k,1);
        gyr_turn_event(1,9) = time_raw_gyro(k,1);
        gyr_turn_event(1,5) = maxima;
        gyr_turn_event(1,6) = maxima_ind;
        gyr_turn_event(1,7) = time_raw_gyro(maxima_ind,1);
        
        turn_time = gyr_turn_event(1,4) - gyr_turn_event(1,2);
        
        seconds_start = floor(gyr_turn_event(1,2)/1000);
        seconds_end = floor(gyr_turn_event(1,4)/1000);
        
        if(seconds_start<60)
            gyr_turn_event(1,2) = seconds_start;
        else
            min_start = int2str(floor(seconds_start/60));
            r_start = int2str(rem(seconds_start , 60 ));
            start_time = strcat(min_start,'.',r_start);
            gyr_turn_event(1,2) = str2double(start_time);
        end
        
        if(seconds_end<60)
            gyr_turn_event(1,4) = seconds_end;
        else
            min_end = int2str(floor(seconds_end/60));
            r_end = int2str(rem(seconds_end , 60 ));
            end_time = strcat(min_end,'.',r_end);
            gyr_turn_event(1,4) = str2double(end_time);
        end
        
        
       
        if((maxima>=0.02)&&(turn_time>500))
            gyr_turn_event_comp = vertcat(gyr_turn_event_comp,gyr_turn_event);
            
%             figure
%             plot(time_raw_gyro(gyr_turn_event(1,1):gyr_turn_event(1,3),:),caliberated_butter_gyro(gyr_turn_event(1,1):gyr_turn_event(1,3),3))
             
%           figure
%           plot(time_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),:),calibrated_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),1))
        end
    i = k;
    end
    
    % negative turns
    if(caliberated_butter_gyro(i,3)<=gyr_turn_thres_neg)
        gyr_turn_event(1,1) = i;
        gyr_turn_event(1,2) = time_raw_gyro(i,1);
        gyr_turn_event(1,8) = time_raw_gyro(i,1);
        k=i+1;
        minima =0;
        
        
        while((caliberated_butter_gyro(k,3)<=gyr_turn_thres_neg)&&(k<num_row_raw_gyro))
            if(caliberated_butter_gyro(k,3)<minima)
                minima = caliberated_butter_gyro(k,3);
                minima_ind = k;
            end
            k = k+1;
        end
        
        gyr_turn_event(1,3) = k;
        gyr_turn_event(1,4) = time_raw_gyro(k,1);
        gyr_turn_event(1,9) = time_raw_gyro(k,1);
        gyr_turn_event(1,5) = minima;
        gyr_turn_event(1,6) = minima_ind;
        gyr_turn_event(1,7) = time_raw_gyro(minima_ind,1);
        turn_time = gyr_turn_event(1,4) - gyr_turn_event(1,2);
        
        seconds_start = floor(gyr_turn_event(1,2)/1000);
        seconds_end = floor(gyr_turn_event(1,4)/1000);
        
        if(seconds_start<60)
            gyr_turn_event(1,2) = seconds_start;
        else
            min_start = int2str(floor(seconds_start/60));
            r_start = int2str(rem(seconds_start , 60 ));
            start_time = strcat(min_start,'.',r_start);
            gyr_turn_event(1,2) = str2double(start_time);
        end
        
        if(seconds_end<60)
            gyr_turn_event(1,4) = seconds_end;
        else
            min_end = int2str(floor(seconds_end/60));
            r_end = int2str(rem(seconds_end , 60 ));
            end_time = strcat(min_end,'.',r_end);
            gyr_turn_event(1,4) = str2double(end_time);
        end
        
        
       
        if((minima<=-0.02)&&(turn_time>1000))
            gyr_turn_event_comp = vertcat(gyr_turn_event_comp,gyr_turn_event);
            
%             figure
%             plot(time_raw_gyro(gyr_turn_event(1,1):gyr_turn_event(1,3),:),caliberated_butter_gyro(gyr_turn_event(1,1):gyr_turn_event(1,3),3))
%         
%             figure
%             plot(time_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),:),calibrated_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),1))
        end
    i = k;
    end
    
 
    i = i+1;
    
end
[num_rows_gyr_turn_events,num_cols_gyr_turn_events] = size(gyr_turn_event_comp);
gyr_turn_event_comp = gyr_turn_event_comp(2:num_rows_gyr_turn_events,:);
end

