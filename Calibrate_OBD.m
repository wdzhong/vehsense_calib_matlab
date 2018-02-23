function [ calib_para_acc,calib_para_decc] = Calibrate_OBD( acc_phases,decc_phases,sys_time_acc,sys_time_gyro,smoo_lin,smoo_res_gyro_comp,obd_speed,time_obd )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here






%Based on acc phases

[num_row_acc_phases,num_cols_decc_phases] = size(acc_phases);
calib_para_acc = zeros(1,3);

window_interval = 500;

for i=1:num_row_acc_phases
    strt_time = acc_phases(i,3);
    end_time = acc_phases(i,4);
    
    %plotting inertial sensor response on acc phases
    [c index_start_gyro] = min(abs(sys_time_gyro-strt_time));
    [c index_end_gyro] = min(abs(sys_time_gyro-end_time));
    
    [c index_start_acc] = min(abs(sys_time_acc-strt_time));
    [c index_end_acc] = min(abs(sys_time_acc-end_time));
    
%     figure
%     plot(sys_time_gyro(index_start_gyro:index_end_gyro,:),smoo_res_gyro_comp(index_start_gyro:index_end_gyro,:))
%     
%     figure
%     plot(sys_time_acc(index_start_acc:index_end_acc,:),smoo_lin(index_start_acc:index_end_acc,1))
%     hold on
%     plot(sys_time_acc(index_start_acc:index_end_acc,:),smoo_lin(index_start_acc:index_end_acc,2))
%     hold on
%     plot(sys_time_acc(index_start_acc:index_end_acc,:),smoo_lin(index_start_acc:index_end_acc,3))
    
    
    
    diff_time1  = end_time - strt_time;
    target_time = strt_time+window_interval;% 1 second interval
    
    while(target_time<end_time)
        diff_time2 = end_time - strt_time;
        
        [c target_index] = min(abs(time_obd-target_time));
        [c start_index] = min(abs(time_obd-strt_time));
        
        start_speed = obd_speed(start_index,1);
        end_speed = obd_speed(target_index,1);
        
        diff_speed = abs((end_speed-start_speed)*(5/18));
        diff_time = (target_time-strt_time)/1000;
        
        avg_acc = diff_speed/diff_time;
        
        if(avg_acc>=1)
            rot = Check_for_Rot(strt_time,target_time,sys_time_gyro,smoo_res_gyro_comp);
            if(rot==0)
                calib_para = CalculateCalibPara(strt_time,target_time,sys_time_acc,smoo_lin);
                calib_para_acc = vertcat(calib_para_acc,calib_para);
            end
        end
        
        strt_time = target_time;
        
        target_time = target_time+window_interval;  % 1 second interval
        %if(target_time>end_time)
         %   target_time = end_time-1;
        %end
        
    end
end

%Based on decc phases

[num_row_decc_phases,num_cols_decc_phases] = size(decc_phases);
calib_para_decc = zeros(1,3);

%window_interval = 2000;

for i=1:num_row_decc_phases
    strt_time = decc_phases(i,3);
    end_time = decc_phases(i,4);
    
    %plotting inertial sensor response on acc phases
    [c index_start_gyro] = min(abs(sys_time_gyro-strt_time));
    [c index_end_gyro] = min(abs(sys_time_gyro-end_time));
    
    [c index_start_decc] = min(abs(sys_time_acc-strt_time));
    [c index_end_decc] = min(abs(sys_time_acc-end_time));
    
%     figure
%     plot(sys_time_gyro(index_start_gyro:index_end_gyro,:),smoo_res_gyro_comp(index_start_gyro:index_end_gyro,:))
%     
%     figure
%     plot(sys_time_acc(index_start_decc:index_end_decc,:),smoo_lin(index_start_decc:index_end_decc,1))
%     hold on
%     plot(sys_time_acc(index_start_decc:index_end_decc,:),smoo_lin(index_start_decc:index_end_decc,2))
%     hold on
%     plot(sys_time_acc(index_start_decc:index_end_decc,:),smoo_lin(index_start_decc:index_end_decc,3))
    
    
    
    diff_time1  = end_time - strt_time;
    target_time = strt_time+window_interval;% 1 second interval
    
    while(target_time<=end_time)
        diff_time2 = end_time - strt_time;
        
        [c target_index] = min(abs(time_obd-target_time));
        [c start_index] = min(abs(time_obd-strt_time));
        
        start_speed = obd_speed(start_index,1);
        end_speed = obd_speed(target_index,1);
        
        diff_speed = abs((end_speed-start_speed)*(5/18));
        diff_time = (target_time-strt_time)/1000;
        
        avg_acc = diff_speed/diff_time;
        
        if(avg_acc>=1)
            rot = Check_for_Rot(strt_time,target_time,sys_time_gyro,smoo_res_gyro_comp);
            if(rot==0)
                calib_para = CalculateCalibPara(strt_time,target_time,sys_time_acc,smoo_lin);
                calib_para_decc = vertcat(calib_para_decc,calib_para);
            end
        end
        
        
        strt_time = target_time;
        
        target_time = target_time+window_interval;  % 1 second interval
        %if(target_time>end_time)
         %   target_time = end_time;
        %end
        
    end
end













end

