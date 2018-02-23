function [ lin_acc_turn_event_comp ] = DetectTurningEventsLinAcc( caliberated_lin_acc_butter,time_lin_acc )
%UNTITLED26 Summary of this function goes here
%   Detailed explanation goes here

[num_row_raw_lin_acc,num_cols_raw_lin_acc] = size(caliberated_lin_acc_butter);
lin_acc_turn_thres_pos = 0.015;
lin_acc_turn_thres_neg = -0.015;
lin_acc_turn_event = zeros(1,9);
lin_acc_turn_event_comp = zeros(1,9);
k = 1;
maxima = 0;
maxima_ind = 1;
minima = 0;
minima_ind = 1;
i=1;

while(i<=num_row_raw_lin_acc)
    % +ve turns
    if(caliberated_lin_acc_butter(i,1)>=lin_acc_turn_thres_pos)
        lin_acc_turn_event(1,1) = i;
        lin_acc_turn_event(1,2) = time_lin_acc(i,1);
        lin_acc_turn_event(1,8) = time_lin_acc(i,1);
        k=i+1;
        maxima =0;
        
        
        while((caliberated_lin_acc_butter(k,1)>=lin_acc_turn_thres_pos)&&(k<num_row_raw_lin_acc))
            if(caliberated_lin_acc_butter(k,1)>maxima)
                maxima = caliberated_lin_acc_butter(k,1);
                maxima_ind = k;
            end
            k = k+1;
        end
        
        lin_acc_turn_event(1,3) = k;
        lin_acc_turn_event(1,4) = time_lin_acc(k,1);
        lin_acc_turn_event(1,9) = time_lin_acc(k,1);
        lin_acc_turn_event(1,5) = maxima;
        lin_acc_turn_event(1,6) = maxima_ind;
        lin_acc_turn_event(1,7) = time_lin_acc(maxima_ind,1);
        
       
        
        turn_time = lin_acc_turn_event(1,4) - lin_acc_turn_event(1,2);
        
        seconds_start = floor(lin_acc_turn_event(1,2)/1000);
        seconds_end = floor(lin_acc_turn_event(1,4)/1000);
        
        if(seconds_start<60)
            lin_acc_turn_event(1,2) = seconds_start;
        else
            min_start = int2str(floor(seconds_start/60));
            r_start = int2str(rem(seconds_start , 60 ));
            start_time = strcat(min_start,'.',r_start);
            lin_acc_turn_event(1,2) = str2double(start_time);
        end
        
        if(seconds_end<60)
            lin_acc_turn_event(1,4) = seconds_end;
        else
            min_end = int2str(floor(seconds_end/60));
            r_end = int2str(rem(seconds_end , 60 ));
            end_time = strcat(min_end,'.',r_end);
            lin_acc_turn_event(1,4) = str2double(end_time);
        end
        
        
       
        if((maxima>=0.3)&&(turn_time>1000))
            lin_acc_turn_event_comp = vertcat(lin_acc_turn_event_comp,lin_acc_turn_event);
            
%              figure
%              plot(time_lin_acc(lin_acc_turn_event(1,1):lin_acc_turn_event(1,3),:),caliberated_lin_acc_butter(lin_acc_turn_event(1,1):lin_acc_turn_event(1,3),1))
%             
%             figure
%             plot(time_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),:),calibrated_raw_acc(gyr_turn_event(1,1):gyr_turn_event(1,3),1))
        end
    i = k;
    end
    
    % negative turns
    if(caliberated_lin_acc_butter(i,1)<=lin_acc_turn_thres_neg)
        lin_acc_turn_event(1,1) = i;
        lin_acc_turn_event(1,2) = time_lin_acc(i,1);
        lin_acc_turn_event(1,8) = time_lin_acc(i,1);
        k=i+1;
        minima =0;
        
        
        while((caliberated_lin_acc_butter(k,1)<=lin_acc_turn_thres_neg)&&(k<num_row_raw_lin_acc))
            if(caliberated_lin_acc_butter(k,1)<minima)
                minima = caliberated_lin_acc_butter(k,1);
                minima_ind = k;
            end
            k = k+1;
        end
        
        lin_acc_turn_event(1,3) = k;
        lin_acc_turn_event(1,4) = time_lin_acc(k,1);
        lin_acc_turn_event(1,9) = time_lin_acc(k,1);
        lin_acc_turn_event(1,5) = minima;
        lin_acc_turn_event(1,6) = minima_ind;
        lin_acc_turn_event(1,7) = time_lin_acc(minima_ind,1);
        turn_time = lin_acc_turn_event(1,4) - lin_acc_turn_event(1,2);
        
        seconds_start = floor(lin_acc_turn_event(1,2)/1000);
        seconds_end = floor(lin_acc_turn_event(1,4)/1000);
        
        if(seconds_start<60)
            lin_acc_turn_event(1,2) = seconds_start;
        else
            min_start = int2str(floor(seconds_start/60));
            r_start = int2str(rem(seconds_start , 60 ));
            start_time = strcat(min_start,'.',r_start);
            lin_acc_turn_event(1,2) = str2double(start_time);
        end
        
        if(seconds_end<60)
            lin_acc_turn_event(1,4) = seconds_end;
        else
            min_end = int2str(floor(seconds_end/60));
            r_end = int2str(rem(seconds_end , 60 ));
            end_time = strcat(min_end,'.',r_end);
            lin_acc_turn_event(1,4) = str2double(end_time);
        end
        
        
       
        if((minima<=-0.3)&&(turn_time>1000))
            lin_acc_turn_event_comp = vertcat(lin_acc_turn_event_comp,lin_acc_turn_event);
            
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

[num_rows_lin_acc_turn_events,num_cols_lin_acc_turn_events] = size(lin_acc_turn_event_comp);
lin_acc_turn_event_comp = lin_acc_turn_event_comp(2:num_rows_lin_acc_turn_events,:);
end

