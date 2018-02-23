function [ index ] = Get_Syncing_Index(sys_time,obd_start_time )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [c index] = min(abs(sys_time-obd_start_time))
end

