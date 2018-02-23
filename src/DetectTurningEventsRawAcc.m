function [ raw_acc_turn_event_comp ] = DetectTurningEventsRawAcc( calibrated_raw_acc,time_raw_acc )
%UNTITLED25 Summary of this function goes here
%   Detailed explanation goes here

[num_row_raw_acc,num_cols_raw_acc] = size(calibrated_raw_acc);

raw_acc_turn_thres_pos = 0.01;
raw_acc_turn_thres_neg = -0.01;
raw_acc_turn_event = zeros(1,9);
raw_acc_turn_event_comp = zeros(1,9);
k = 1;
maxima = 0;
maxima_ind = 1;
minima = 0;
minima_ind = 1;
i=1;

while(i<=num_row_raw_acc)
    % +ve turns
    if(calibrated_raw_acc(i,1)>=raw_acc_turn_thres_pos)
        raw_acc_turn_event(1,1) = i;
        raw_acc_turn_event(1,2) = time_raw_acc(i,1);
        raw_acc_turn_event(1,8) = time_raw_acc(i,1);
        k=i+1;
        maxima =0;
        
        
        while((calibrated_raw_acc(k,1)>=raw_acc_turn_thres_pos)&&(k<num_row_raw_acc))
            if(calibrated_raw_acc(k,1)>maxima)
                maxima = calibrated_raw_acc(k,1);
                maxima_ind = k;
            end
            k = k+1;
        end
        
        raw_acc_turn_event(1,3) = k;
        raw_acc_turn_event(1,4) = time_raw_acc(k,1);
        raw_acc_turn_event(1,9) = time_raw_acc(k,1);
        raw_acc_turn_event(1,5) = maxima;
        raw_acc_turn_event(1,6) = maxima_ind;
        raw_acc_turn_event(1,7) = time_raw_acc(maxima_ind,1);
        
       
        
        turn_time = raw_acc_turn_event(1,4) - raw_acc_turn_event(1,2);
        
        seconds_start = floor(raw_acc_turn_event(1,2)/1000);
        seconds_end = floor(raw_acc_turn_event(1,4)/1000);
        
        if(seconds_start<60)
            raw_acc_turn_event(1,2) = seconds_start;
        else
            min_start = int2str(floor(seconds_start/60));
            r_start = int2str(rem(seconds_start , 60 ));
            start_time = strcat(min_start,'.',r_start);
            raw_acc_turn_event(1,2) = str2double(start_time);
        end
        
        if(seconds_end<60)
            raw_acc_turn_event(1,4) = seconds_end;
        else
            min_end = int2str(floor(seconds_end/60));
            r_end = int2str(rem(seconds_end , 60 ));
            end_time = strcat(min_end,'.',r_end);
            raw_acc_turn_event(1,4) = str2double(end_time);
        end
        
        
       
        if((maxima>=0.3)&&(turn_time>1000))
            raw_acc_turn_event_comp = vertcat(raw_acc_turn_event_comp,raw_acc_turn_event);
            
%              figure
%              plot(time_lin_acc(lin_acc_turn_event(1,1):lin_acc_turn_event(1,3),:),caliberated_lin_acc_butter(lin_acc_turn_event(1,1):lin_acc_turn_event(1,3),1))
%             
%             figure
%             plot(time_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),:),calibrated_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),1))
        end
    i = k;
    end
    
    % negative turns
    if(calibrated_raw_acc(i,1)<=raw_acc_turn_thres_neg)
        raw_acc_turn_event(1,1) = i;
        raw_acc_turn_event(1,2) = time_raw_acc(i,1);
        raw_acc_turn_event(1,8) = time_raw_acc(i,1);
        k=i+1;
        minima =0;
        
        
        while((calibrated_raw_acc(k,1)<=raw_acc_turn_thres_neg)&&(k<num_row_raw_acc))
            if(calibrated_raw_acc(k,1)<minima)
                minima = calibrated_raw_acc(k,1);
                minima_ind = k;
            end
            k = k+1;
        end
        
        raw_acc_turn_event(1,3) = k;
        raw_acc_turn_event(1,4) = time_raw_acc(k,1);
        raw_acc_turn_event(1,9) = time_raw_acc(k,1);
        raw_acc_turn_event(1,5) = minima;
        raw_acc_turn_event(1,6) = minima_ind;
        raw_acc_turn_event(1,7) = time_raw_acc(minima_ind,1);
        turn_time = raw_acc_turn_event(1,4) - raw_acc_turn_event(1,2);
        
        seconds_start = floor(raw_acc_turn_event(1,2)/1000);
        seconds_end = floor(raw_acc_turn_event(1,4)/1000);
        
        if(seconds_start<60)
            raw_acc_turn_event(1,2) = seconds_start;
        else
            min_start = int2str(floor(seconds_start/60));
            r_start = int2str(rem(seconds_start , 60 ));
            start_time = strcat(min_start,'.',r_start);
            raw_acc_turn_event(1,2) = str2double(start_time);
        end
        
        if(seconds_end<60)
            raw_acc_turn_event(1,4) = seconds_end;
        else
            min_end = int2str(floor(seconds_end/60));
            r_end = int2str(rem(seconds_end , 60 ));
            end_time = strcat(min_end,'.',r_end);
            raw_acc_turn_event(1,4) = str2double(end_time);
        end
        
        
       
        if((minima<=-0.3)&&(turn_time>1000))
            raw_acc_turn_event_comp = vertcat(raw_acc_turn_event_comp,raw_acc_turn_event);
            
%             figure
%             plot(time_lin_acc(lin_acc_turn_event(1,1):lin_acc_turn_event(1,3),:),caliberated_lin_acc_butter(lin_acc_turn_event(1,1):lin_acc_turn_event(1,3),1))
%             figure
%             plot(time_raw_gyro(gyr_turn_event(1,1):gyr_turn_event(1,3),:),caliberated_mean_gyr(gyr_turn_event(1,1):gyr_turn_event(1,3),3))
%         
%             figure
%             plot(time_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),:),calibrated_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),1))
        end
    i = k;
    end
    
 
    i = i+1;
    
end

[num_rows_raw_acc_turn_events,num_cols_raw_acc_turn_events] = size(raw_acc_turn_event_comp);
raw_acc_turn_event_comp = raw_acc_turn_event_comp(2:num_rows_raw_acc_turn_events,:);


end

