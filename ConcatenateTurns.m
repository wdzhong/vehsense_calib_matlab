function [ concanetated_turn_event_comp ] = ConcatenateTurns( lin_acc_turn_event_comp )
%UNTITLED27 Summary of this function goes here
%   Detailed explanation goes here

[num_rows_lin_acc_turn_events,num_cols_lin_acc_turn_events] = size(lin_acc_turn_event_comp);
concanetated_turn_event = zeros(1,9);
concanetated_turn_event_comp = zeros(1,9);
i =1;

while i<=num_rows_lin_acc_turn_events-1
    end_time = lin_acc_turn_event_comp(i,4);
    next_start_time = lin_acc_turn_event_comp(i+1,2);
    
    if(end_time==next_start_time)
        concanetated_turn_event(1,1) = lin_acc_turn_event_comp(i,1);
        concanetated_turn_event(1,2) = lin_acc_turn_event_comp(i,2);
        concanetated_turn_event(1,3) = lin_acc_turn_event_comp(i+1,3);
        concanetated_turn_event(1,4) = lin_acc_turn_event_comp(i+1,4);
        concanetated_turn_event(1,5) = lin_acc_turn_event_comp(i,5);
        concanetated_turn_event(1,6) = lin_acc_turn_event_comp(i,6);
        concanetated_turn_event(1,7) = lin_acc_turn_event_comp(i,7);
        concanetated_turn_event(1,8) = lin_acc_turn_event_comp(i,8);
        concanetated_turn_event(1,9) = lin_acc_turn_event_comp(i+1,9);
        i = i+1;
       
    else
        concanetated_turn_event = lin_acc_turn_event_comp(i,:);
    end
    
%     figure
%     plot(time_lin_acc(concanetated_turn_event(1,1):concanetated_turn_event(1,3),:),caliberated_lin_acc_butter(concanetated_turn_event(1,1):concanetated_turn_event(1,3),1))
    
    concanetated_turn_event_comp = vertcat(concanetated_turn_event_comp,concanetated_turn_event);
    i = i+1;
end



[num_rows_lin_acc_turn_events_concat,num_cols_lin_acc_turn_events_concat] = size(concanetated_turn_event_comp);
concanetated_turn_event_comp = concanetated_turn_event_comp(2:num_rows_lin_acc_turn_events_concat,:);
end

