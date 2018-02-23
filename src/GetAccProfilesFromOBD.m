function [ acc_profiles_obd_comp ] = GetAccProfilesFromOBD( time_obd,obd_speed )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% Format start_ind, end_ind, start_time, end_time    
acc_profiles_obd= zeros(1,4);
acc_profiles_obd_comp = zeros(1,4);
[pks,locs] = findpeaks(obd_speed);

[num_peaks,cols] = size(pks);

for i=1:num_peaks
    peak = pks(i,1);
    peak_ind =  locs(i,1);
    acc_profiles_obd(1,2) = peak_ind;
    acc_profiles_obd(1,4) = time_obd(peak_ind,1);
    
    
    k = peak_ind-1;
    temp_speed = peak;
    
    while((obd_speed(k,1)<=temp_speed)&&(k>=2)&&(obd_speed(k,1)~=0))
        temp_speed = obd_speed(k,1);
        k=k-1;
    end
strt_ind = k;  
acc_profiles_obd(1,1) = strt_ind;
acc_profiles_obd(1,3) = time_obd(strt_ind,1);

strt_speed = obd_speed(acc_profiles_obd(1,1),1);
end_speed = obd_speed(acc_profiles_obd(1,2),1);

if(((acc_profiles_obd(1,4)-acc_profiles_obd(1,3))>=5000)&&((end_speed-strt_speed)>=5)) %5sec
    acc_profiles_obd_comp = vertcat(acc_profiles_obd_comp,acc_profiles_obd);
end

end



[num_rows_acc_prof,num_cols_acc_prof] = size(acc_profiles_obd_comp);

acc_profiles_obd_comp = acc_profiles_obd_comp(2:num_rows_acc_prof,:);
    
end






