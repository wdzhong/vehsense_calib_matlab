function [ start_ind, acc_or_obd] = CalcStartIndex( sys_time_acc,time_obd )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if(sys_time_acc(1,1)>time_obd(1,1))
    time_to_find = sys_time_acc(1,1);
    [c start_ind] = min(abs(time_obd-time_to_find));
    acc_or_obd = 0; %OBD
    
else
    time_to_find = time_obd(1,1);
    [c start_ind] = min(abs(sys_time_acc-time_to_find));
    acc_or_obd = 1; %ACC
end
    
    

end

