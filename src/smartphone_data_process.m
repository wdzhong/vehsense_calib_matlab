function smartphone_data_process(tripFolder)

%Read files

%[data_file_raw_acc,data_file_raw_lin_acc,data_file_raw_gyro,data_file_gps,data_file_obd] = ReadRawData('VehSenseDataThu Oct 05 22:13:52 EDT 2017Weida');
[data_file_raw_acc,data_file_raw_lin_acc,data_file_raw_gyro,data_file_gps,data_file_obd] = ReadRawData(tripFolder);


%reading raw_gps data

[time_gps,latLon,gps_speed,gps_bearing] = getGPSData(data_file_gps);

figure
plot(time_gps,gps_bearing)

[gps_speed,time_gps] = preProcessGPSspeed(gps_speed,time_gps);

% figure
% plot(time_gps,gps_bearing)

%reading OBD data
[time_obd,obd_speed] = getOBDData(data_file_obd);
obd_speed_smoo_app = SmoothDataApp(obd_speed,0.1);

figure
plot(time_obd,obd_speed)

figure
plot(time_obd,obd_speed_smoo_app)

[num_rows_obd,num_cols_obd] = size(obd_speed);

acc_obd = zeros(num_rows_obd,1);

for i=1:num_rows_obd-1
    obd_speed_next = obd_speed_smoo_app(i+1,1)*(1000/3600);
    obd_now = obd_speed_smoo_app(i,1)*(1000/3600);
    
    time_next = time_obd(i+1,1)/1000;
    time_now = time_obd(i,1)/1000;

    del_speed = obd_speed_next-obd_now;
    del_time = time_next-time_now;

    acc_obd(i,1) = del_speed/del_time;
end
figure
plot(time_obd,acc_obd)


acc_obd_smoo = SmoothDataApp(acc_obd,0.1);

figure
plot(time_obd,acc_obd_smoo)


high_acc_phases = getHighAccPhases(acc_obd_smoo,time_obd);
high_decc_phases = getHighDeccPhases(acc_obd_smoo,time_obd);


acc_phases = getACCPhases(obd_speed,time_obd);
decc_phases = getDECCPhases(obd_speed,time_obd);

obd_start_time = time_obd(1,1);


%Read raw acc data

[time_raw_acc,sys_time_acc,raw_acc] = getRawAcc(data_file_raw_acc);

%Remove gravity 

[lin_acc,gravity] = RemoveGravity(raw_acc,0.999);

%lin_acc = SmoothDataButter(raw_acc,1,0.9999999,'high');

% figure
% plot(sys_time_acc,lin_acc(:,1))
% 
% figure
% plot(sys_time_acc,lin_acc(:,2))
% 
% figure
% plot(sys_time_acc,lin_acc(:,3))
%smoo_lin = SmoothDataButter(lin_acc,3,0.003,'low');

% smoo_lin(:,1) = smooth(lin_acc(:,1),11);
% smoo_lin(:,2) = smooth(lin_acc(:,2),11);
% smoo_lin(:,3) = smooth(lin_acc(:,3),11);


smoo_lin = SmoothDataApp(lin_acc,0.01);

% Smooth raw data (APP Way)
smoo_raw_acc_comp = SmoothDataApp(raw_acc,0.002);

%lin_acc = RemoveGravity(smoo_raw_acc_comp,0.9995);

% figure
% plot(time_raw_acc,lin_acc(:,1))
% 
% figure
% plot(time_raw_acc,lin_acc(:,2))
% 
% figure
% plot(time_raw_acc,lin_acc(:,3))




% figure 
% plot(time_raw_acc,smoo_raw_acc_comp(:,1));

%filtering raw acc using butterworth filter

% filter_butter_raw_acc = zeros(num_row_raw_acc,1);
% 
% [b,a] = butter(3,0.003,'low');
% filter_butter_raw_acc =  filter(b,a,raw_acc);
% 
% figure
% plot(time_raw_acc,filter_butter_raw_acc(:,2))
% 
% filter_window(:,1) = smooth(raw_acc(:,1),101);
% filter_window(:,2) = smooth(raw_acc(:,2),101);
% filter_window(:,3) = smooth(raw_acc(:,3),101);
% 
% 
% figure
% plot(time_raw_acc,filter_window(:,2))
% 
% [b,a] = butter(3,0.003,'low');
% filter_butter_raw_acc_after_smoo =  filter(b,a,filter_window);
% figure
% plot(time_raw_acc,filter_butter_raw_acc_after_smoo(:,2))


%Removing data until the time stamp obd is initialized

[index_raw_acc] = Get_Syncing_Index(sys_time_acc,obd_start_time);

time_raw_acc = Sync_With_OBD(time_raw_acc,index_raw_acc);
sys_time_acc = Sync_With_OBD(sys_time_acc,index_raw_acc);
smoo_raw_acc_comp = Sync_With_OBD(smoo_raw_acc_comp,index_raw_acc);
smoo_lin = Sync_With_OBD(smoo_lin,index_raw_acc);



%Remove leading data(5sec) to account for the stabilization of the filter
% num_lead_points = 1000;
% 
% smoo_raw_acc_comp = RemoveLeadData(smoo_raw_acc_comp,num_lead_points);
% time_raw_acc = RemoveLeadData(time_raw_acc,num_lead_points);
% sys_time_acc = RemoveLeadData(sys_time_acc,num_lead_points);

[smoo_raw_acc_comp] = MakeDataRowsMultipleTen(smoo_raw_acc_comp);
[smoo_lin] = MakeDataRowsMultipleTen(smoo_lin);
[time_raw_acc] = MakeDataRowsMultipleTen(time_raw_acc);
[sys_time_acc] = MakeDataRowsMultipleTen(sys_time_acc);




%sys_time_acc  = sys_time_acc - sys_time_acc(1,1);
% figure
% plot(time_raw_acc,smoo_raw_acc_comp(:,1))
% 
% figure
% plot(time_raw_acc,smoo_raw_acc_comp(:,2))
% 
figure
plot(sys_time_acc,smoo_lin(:,3))


% figure
% plot(time_raw_acc,raw_acc(:,3))

% Read raw lin acc

[time_lin_acc,sys_time_lin_acc,raw_lin_acc] = getRawLinAcc(data_file_raw_lin_acc);

%Smoothing lin_acc (APP Way)
smoo_lin_acc_comp = SmoothDataApp(raw_lin_acc,0.005);
res_lin_acc = ComputeResultant(raw_lin_acc);
smoo_lin_res_acc_comp = SmoothDataApp(res_lin_acc,0.005);
res_lin_acc_after_smoo = ComputeResultant(smoo_lin_acc_comp);

%Smoothing Butterworth filter
filter_butter_raw_acc_lin = SmoothDataButter(raw_lin_acc,3,0.003,'low');



[index_lin_acc] = Get_Syncing_Index(sys_time_lin_acc,obd_start_time);

time_lin_acc = Sync_With_OBD(time_lin_acc,index_lin_acc);
sys_time_lin_acc = Sync_With_OBD(sys_time_lin_acc,index_lin_acc);
smoo_lin_acc_comp = Sync_With_OBD(smoo_lin_acc_comp,index_lin_acc);
res_lin_acc_after_smoo = Sync_With_OBD(res_lin_acc_after_smoo,index_lin_acc);
filter_butter_raw_acc_lin = Sync_With_OBD(filter_butter_raw_acc_lin,index_lin_acc);
smoo_lin_res_acc_comp = Sync_With_OBD(smoo_lin_res_acc_comp,index_lin_acc);



figure
plot(sys_time_lin_acc,filter_butter_raw_acc_lin(:,3))

% filter_window_lin_acc(:,1) = smooth(raw_lin_acc(:,1),101);
% filter_window_lin_acc(:,2) = smooth(raw_lin_acc(:,2),101);
% filter_window_lin_acc(:,3) = smooth(raw_lin_acc(:,3),101);
% 
% 
% figure
% plot(time_lin_acc,filter_window_lin_acc(:,2))
% 
% [b,a] = butter(3,0.003,'low');
% filter_butter_raw_acc_lin_after_smoo =  filter(b,a,filter_window_lin_acc);
% 
% figure
% plot(time_lin_acc,filter_butter_raw_acc_lin_after_smoo(:,2))


%Remove leading data(10sec) to account for the stabilization of the filter

% smoo_lin_acc_comp = RemoveLeadData(smoo_lin_acc_comp,num_lead_points);
% 
% smoo_lin_res_acc_comp = RemoveLeadData(smoo_lin_res_acc_comp,num_lead_points);
% res_lin_acc_after_smoo = RemoveLeadData(res_lin_acc_after_smoo,num_lead_points);
% filter_butter_raw_acc_lin = RemoveLeadData(filter_butter_raw_acc_lin,num_lead_points);
% time_lin_acc = RemoveLeadData(time_lin_acc,num_lead_points);
% sys_time_lin_acc = RemoveLeadData(sys_time_lin_acc,num_lead_points);



[smoo_lin_acc_comp] = MakeDataRowsMultipleTen(smoo_lin_acc_comp);
[smoo_lin_res_acc_comp] = MakeDataRowsMultipleTen(smoo_lin_res_acc_comp);
[filter_butter_raw_acc_lin] = MakeDataRowsMultipleTen(filter_butter_raw_acc_lin);

[res_lin_acc_after_smoo] = MakeDataRowsMultipleTen(res_lin_acc_after_smoo);
[time_lin_acc] = MakeDataRowsMultipleTen(time_lin_acc);
[sys_time_lin_acc] = MakeDataRowsMultipleTen(sys_time_lin_acc);


%sys_time_lin_acc = sys_time_lin_acc - sys_time_lin_acc(1,1);
figure
plot(time_lin_acc,filter_butter_raw_acc_lin(:,3))



% read raw gyro data

[time_raw_gyro,sys_time_gyro,raw_gyro] = getGyro(data_file_raw_gyro);

figure
plot(time_raw_gyro,raw_gyro(:,1))

% Smooth raw_gyro data (APP Way)0.008
smoo_raw_gyro_comp = SmoothDataApp(raw_gyro,0.001);
smoo_res_gyro_comp = ComputeResultant(smoo_raw_gyro_comp);

%Smooth raw_gyro data (Butterworth filter)
filter_butter_raw_gyro = SmoothDataButter(raw_gyro,3,0.009,'low');

[index_gyro] = Get_Syncing_Index(sys_time_gyro,obd_start_time);

time_raw_gyro = Sync_With_OBD(time_raw_gyro,index_gyro);
sys_time_gyro = Sync_With_OBD(sys_time_gyro,index_gyro);
smoo_raw_gyro_comp = Sync_With_OBD(smoo_raw_gyro_comp,index_gyro);
smoo_res_gyro_comp = Sync_With_OBD(smoo_res_gyro_comp,index_gyro);
filter_butter_raw_gyro = Sync_With_OBD(filter_butter_raw_gyro,index_gyro);


figure
plot(time_raw_gyro,smoo_res_gyro_comp(:,1))

%Remove leading data(10sec) to account for the stabilization of the filter
% smoo_raw_gyro_comp = RemoveLeadData(smoo_raw_gyro_comp,num_lead_points);
% smoo_res_gyro_comp = RemoveLeadData(smoo_res_gyro_comp,num_lead_points);
% time_raw_gyro  = RemoveLeadData(time_raw_gyro,num_lead_points);
% sys_time_gyro = RemoveLeadData(sys_time_gyro,num_lead_points);



%Removing initial 10 second data for stabilization
% filter_butter_raw_gyro = RemoveLeadData(filter_butter_raw_gyro,num_lead_points);

[smoo_raw_gyro_comp] = MakeDataRowsMultipleTen(smoo_raw_gyro_comp);
[smoo_res_gyro_comp] = MakeDataRowsMultipleTen(smoo_res_gyro_comp);
[time_raw_gyro] = MakeDataRowsMultipleTen(time_raw_gyro);

[sys_time_gyro] = MakeDataRowsMultipleTen(sys_time_gyro);
[filter_butter_raw_gyro] = MakeDataRowsMultipleTen(filter_butter_raw_gyro);


figure
plot(time_obd,-acc_obd)

hold on
plot(sys_time_acc,smoo_lin(:,3))

hold on 

plot(sys_time_acc,smoo_lin(:,2))

hold on
plot(sys_time_acc,smoo_lin(:,1))





figure
plot(sys_time_gyro,filter_butter_raw_gyro(:,1))

figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,2))

figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,3))

figure
plot(time_raw_gyro,smoo_raw_gyro_comp(:,1))



% filter_window_gyro(:,1) = smooth(raw_gyro(:,1),101);
% filter_window_gyro(:,1) = smooth(raw_gyro(:,1),101);
% filter_window_gyro(:,1) = smooth(raw_gyro(:,1),101);
% 
% 
% figure
% plot(time_raw_gyro,filter_window_gyro(:,2))
% 
% [b,a] = butter(3,0.003,'low');
% filter_butter_raw_gyro_after_smoo =  filter(b,a,filter_window_gyro);
% figure
% plot(time_raw_gyro,filter_butter_raw_gyro_after_smoo(:,2))



% Detect All the still phases in the profile (App way)

%calculating std_dev
std_dev_raw_acc_smoo = CalculateSTDSlide(smoo_raw_acc_comp,9);
mean_raw_smoo = CalculateMeanSlide(smoo_raw_acc_comp,9);


std_dev_raw_acc_comp = SmoothDataApp(std_dev_raw_acc_smoo,0.003);
mean_raw_acc_smoo_comp = SmoothDataApp(mean_raw_smoo,0.003);

[std_dev_raw_num_rows,std_dev_raw_num_cols] = size(std_dev_raw_acc_comp);

% Still detection logic(Using STD)
%still_phase_data_comp = DetectStillPhasesSTD(std_dev_raw_acc_comp,time_raw_acc);


% Calculating stdev and mean of lin acc sliding window here
std_dev_lin_acc_smoo = CalculateSTDSlide(smoo_lin_acc_comp,9);
mean_lin_smoo = CalculateMeanSlide(smoo_lin_acc_comp,9);
mean_lin_res_acc = CalculateMeanSlide(res_lin_acc_after_smoo,9);

std_dev_lin_acc_comp = SmoothDataApp(std_dev_lin_acc_smoo,0.003);
mean_lin_res_acc_comp = SmoothDataApp(mean_lin_res_acc,0.003);

figure
plot(time_lin_acc./1000,mean_lin_res_acc_comp(:,1))


% Still Phase detection using MEAN

still_phase_data_comp = DetectStillPhasesMean(mean_lin_res_acc_comp,time_lin_acc);

% Move phase detection using mean res_lin_acc data
move_phase_data_mean_lin_acc_comp = DetectMovementPhasesMean(still_phase_data_comp,time_lin_acc);


%calculating std_dev and mean GYRO
std_dev_raw_gyro_smoo = CalculateSTDSlide(filter_butter_raw_gyro,9);
mean_raw_gyro_smoo = CalculateMeanSlide(smoo_raw_gyro_comp,9);
mean_res_gyro_smoo = CalculateMeanSlide(smoo_res_gyro_comp,9);

std_dev_raw_gyro_comp = SmoothDataApp(std_dev_raw_gyro_smoo,0.003);
mean_raw_gyro_comp = SmoothDataApp(mean_raw_gyro_smoo,0.007);
mean_res_gyro_comp = SmoothDataApp(mean_res_gyro_smoo,0.003);

% figure 
% plot(time_raw_gyro,std_dev_raw_gyro_comp(:,1))

figure 
plot(time_raw_gyro,mean_res_gyro_comp(:,1))

[std_dev_gyr_num_rows,std_dev_gyr_num_cols] = size(std_dev_raw_gyro_comp);

[mean_gyr_res_num_rows,mean_gyr_res_num_cols] = size(mean_res_gyro_comp);


% Plotting all acc and decc phases alon with inertial data 

[num_row_acc_phases,num_cols_decc_phases] = size(acc_phases);

for i=1:num_row_acc_phases
    strt_time = acc_phases(i,3);
    end_time = acc_phases(i,4);
    
    %plotting inertial sensor response on acc phases
    [c index_start_gyro] = min(abs(sys_time_gyro-strt_time));
    [c index_end_gyro] = min(abs(sys_time_gyro-end_time));
    
    [c index_start_acc] = min(abs(sys_time_acc-strt_time));
    [c index_end_acc] = min(abs(sys_time_acc-end_time));
    
    figure
    plot(sys_time_gyro(index_start_gyro:index_end_gyro,:),smoo_res_gyro_comp(index_start_gyro:index_end_gyro,:))
    hold on
    plot(sys_time_acc(index_start_acc:index_end_acc,:),smoo_lin(index_start_acc:index_end_acc,1))
    hold on
    plot(sys_time_acc(index_start_acc:index_end_acc,:),smoo_lin(index_start_acc:index_end_acc,2))
    hold on
    plot(sys_time_acc(index_start_acc:index_end_acc,:),smoo_lin(index_start_acc:index_end_acc,3))
    
    hold on
    plot(time_obd(acc_phases(i,1):acc_phases(i,2),:),obd_speed(acc_phases(i,1):acc_phases(i,2),:)/10)
    hold on
    plot(time_obd(acc_phases(i,1):acc_phases(i,2),:),acc_obd(acc_phases(i,1):acc_phases(i,2),:))
    legend('GYRO','X_ACC','Y_ACC','Z_ACC','Speed','OBD_ACC','Location','north')
    hold off
end



figure
plot(sys_time_lin_acc(:,1),smoo_lin_acc_comp(:,3))
hold on
plot(sys_time_acc(:,1),smoo_lin(:,3))
hold on
plot(sys_time_acc(:,1),smoo_raw_acc_comp(:,3))
legend('System','Mine','Raw','Location','north')



%Based on decc phases

[num_row_decc_phases,num_cols_decc_phases] = size(decc_phases);


for i=1:num_row_decc_phases
    strt_time = decc_phases(i,3);
    end_time = decc_phases(i,4);
    
    %plotting inertial sensor response on acc phases
    [c index_start_gyro] = min(abs(sys_time_gyro-strt_time));
    [c index_end_gyro] = min(abs(sys_time_gyro-end_time));
    
    [c index_start_decc] = min(abs(sys_time_acc-strt_time));
    [c index_end_decc] = min(abs(sys_time_acc-end_time));
    
    figure
    plot(sys_time_gyro(index_start_gyro:index_end_gyro,:),smoo_res_gyro_comp(index_start_gyro:index_end_gyro,:))
    
    hold on
    plot(sys_time_acc(index_start_decc:index_end_decc,:),smoo_lin(index_start_decc:index_end_decc,1))
    
    hold on
    plot(sys_time_acc(index_start_decc:index_end_decc,:),smoo_lin(index_start_decc:index_end_decc,2))
    
    hold on
    plot(sys_time_acc(index_start_decc:index_end_decc,:),smoo_lin(index_start_decc:index_end_decc,3))
    
    hold on
    plot(time_obd(decc_phases(i,1):decc_phases(i,2),:),obd_speed(decc_phases(i,1):decc_phases(i,2),:)/10)
    hold on
    
    plot(time_obd(decc_phases(i,1):decc_phases(i,2),:),acc_obd(decc_phases(i,1):decc_phases(i,2),:))
    legend('GYRO','X_ACC','Y_ACC','Z_ACC','Speed','OBD_ACC','Location','north')
    
    hold off
end


% CALIBRATION USING OBD

[calib_para_acc,calib_para_decc] = Calibrate_OBD(acc_phases,decc_phases,sys_time_acc,sys_time_gyro,smoo_lin,mean_res_gyro_comp,obd_speed,time_obd);


% detection of rotation done here(using mean over here)

%The output is information about detected rotation phases such as start
%time, end time, min-max values etc.

rot_phase_data_comp = DetectRotPhases(mean_res_gyro_comp,time_raw_gyro);

non_rot_phase_data_comp = DetectNonRotPhases(rot_phase_data_comp,time_raw_gyro);

gyro_offsets = GetGyroOffsets(non_rot_phase_data_comp,filter_butter_raw_gyro,time_raw_gyro);

gyro_offsets = PlugMissingGyrOffset(gyro_offsets);

filter_butter_raw_gyro = ApplyGyrOffset(filter_butter_raw_gyro,gyro_offsets);

filter_butter_res_gyro = ComputeResultant(filter_butter_raw_gyro);


figure
plot(time_raw_gyro,filter_butter_res_gyro(:,1))

figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,1))

figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,2))

figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,3))





% Find all the increasing acceleration profiles. The idea is to deduce sign
% of the direction of the most significant component when the vehicle moves
% after being still for some time. These increasing acc sequences will give
% us more valid acc profiles that can be used for caliberation.


%valid_acc_profiles_for_caiberation = getValidAccProfilesForCaliberation(move_phase_data_mean_lin_acc_comp,still_phase_data_comp,rot_phase_data_comp);

%Calculation of caliberation parameters.

valid_cali_profiles_comp = GetValidCalibrationProfiles(move_phase_data_mean_lin_acc_comp,time_lin_acc,rot_phase_data_comp,mean_lin_res_acc_comp);

%plugging in appropriate caiberation profiles
valid_cali_profiles_comp = PlugInAppropriateCaliProf(valid_cali_profiles_comp,still_phase_data_comp,move_phase_data_mean_lin_acc_comp);

% plugging in missing movement caliberation values
valid_cali_profiles_comp = PlugMissingCaliValues(valid_cali_profiles_comp);

%Will have to do some sort of trace sync

[start_ind, acc_or_obd] = CalcStartIndex(sys_time_acc,time_obd);

%Converting OBD speed to m/sec
obd_speed = obd_speed(:,1)./(18/5);
[num_rows_obd_speed,num_cols_obd_speed] = size(obd_speed);

time_obd = time_obd(start_ind:num_rows_obd_speed,1);
obd_speed = obd_speed(start_ind:num_rows_obd_speed,1);

%time_obd = time_obd - time_obd(1,1);

figure
plot(time_obd,obd_speed)

% %Finding ACC profiles based on OBD data
% [acc_profiles_obd] = GetAccProfilesFromOBD(time_obd,obd_speed);
% 
% %Filtering out only those profiles where there is no rotation
% 
% [valid_acc_profiles_obd] = GetValidAccProfilesFromOBD(acc_profiles_obd,rot_phase_data_comp,sys_time_gyro,time_raw_gyro);


% Trying to get curvature results using res_gyr data and obd speeds without
% doing calibration

gyr_turn_event_comp_res = DetectTurnEventsGyrRes(filter_butter_res_gyro,time_raw_gyro,sys_time_gyro);
theta_comp_res = CalculateBearingChangeGyrRes(gyr_turn_event_comp_res,filter_butter_res_gyro);

turn_vel_profile_indexes = GetOBDVelDuringTurn(gyr_turn_event_comp_res,time_obd);

% Calculate Curvature of example turn

turn_ind = 40;

[example_turn_rad_profile,example_turn_disp_profile,example_turn_heading_profile,example_turn_gyr_profile,example_speed_profile] = GetRadProfileOBD(gyr_turn_event_comp_res,turn_vel_profile_indexes,obd_speed,turn_ind,time_obd,sys_time_gyro,filter_butter_res_gyro);

total_disp = sum(example_turn_disp_profile(:,2));
total_heading_change = sum(example_turn_heading_profile(:,2));
heading_change_deg=radtodeg(total_heading_change);

[num_ros_gyr,num_cols_gyr] = size(example_turn_gyr_profile);
init_timestamp_gyr = example_turn_gyr_profile(1,1);

for i=1:num_ros_gyr
    example_turn_gyr_profile(i,1) = (example_turn_gyr_profile(i,1) - init_timestamp_gyr)/1000;
end

[num_ros_rad,num_cols_rad] = size(example_turn_rad_profile);
init_timestamp_rad = example_turn_rad_profile(1,1);

for i=1:num_ros_rad
    example_turn_rad_profile(i,1) = (example_turn_rad_profile(i,1) - init_timestamp_rad)/1000;
end

figure
plot(example_turn_gyr_profile(:,1),example_turn_gyr_profile(:,2))
legend('Angular Velocity Profile','Location','north')
title('Radius and Angular Velocity profiles for a sample turn.','FontSize',14)
xlabel('Time(sec)','FontSize',16,'FontWeight','bold')
ylabel('Angular Velocity(rad/sec)','FontSize',16,'FontWeight','bold')
xlim([0 15])
set(gca,'FontSize',14);
hold off
ax1 = gca; % current axes
% ax1.XColor = 'r';
ax1.YColor = 'k';
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'YAxisLocation','right',...
    'Color','none');
line(example_turn_rad_profile(:,1),example_turn_rad_profile(:,2),'Parent',ax2,'Color','k','Linestyle',':')
%plot(time_decc_rpm_snow_fox_3(:,1)/1000,flip(rpm_decc_snow_fox_3(:,1)),'Parent',ax2,'Color','k')
ylabel('Meters','FontSize',16,'FontWeight','bold')
ylim([150 700])
xlim([0 15])
legend('Radius','Location','northeast')
set(gca,'FontSize',14);
%set(gca,'XTick',0:4); %<- Still need to manually specific tick marks
%set(gca,'YTick',0:100); %<- Still need to manually specific tick marks
%print('RPM_OBD_PREDICTED ', '-dtiff', '-r300');
%print('RPM_OBD_PREDICTED ', '-dpng', '-r300');










figure
plot(example_turn_gyr_profile(:,1),example_turn_gyr_profile(:,2))
hold on

plot(example_turn_rad_profile(:,1),example_turn_rad_profile(:,2))
hold off


% Calculation of calibration parameters
calibration_para_comp = CalculateCalibrationPara(valid_cali_profiles_comp,smoo_raw_acc_comp,smoo_lin_acc_comp);

% Actual calibration done here
calibrated_raw_acc = Calibrate_Raw_Acc(calibration_para_comp,smoo_raw_acc_comp);
caliberated_mean_gyr = Calibrate_Gyr(calibration_para_comp,mean_raw_gyro_comp);
caliberated_lin_acc = Calibrate_Lin_Acc(calibration_para_comp,smoo_lin_acc_comp);
caliberated_lin_acc_butter = Calibrate_Lin_Acc_Butter(calibration_para_comp,filter_butter_raw_acc_lin);
caliberated_butter_gyro = Calibrate_Gyr_Butter(calibration_para_comp,filter_butter_raw_gyro);

figure
plot(time_raw_gyro,(caliberated_butter_gyro(:,3)))

figure
plot(time_raw_acc,(calibrated_raw_acc(:,2)))



 




% Estimating speed using GPS_Speed and acc data.

%speed = EstimateSpeed(calibrated_raw_acc,gps_speed,time_raw_acc,time_gps);


speed = EstimateSpeedOBD(calibrated_raw_acc,obd_speed,time_raw_acc,time_obd,start_ind,acc_or_obd,sys_time_acc);
% 
% figure
% plot(time_raw_acc(:,1)./1000,(speed(:,1)))
% hold on
% plot(time_obd(start_ind:4351,1),obd_speed(start_ind:4351,1))



%Detecting turning events from caliberated_raw_acc data()

raw_acc_turn_event_comp = DetectTurningEventsRawAcc(calibrated_raw_acc,time_raw_acc);

%Detecting turning events from lin_acc data(using daat filtered via butterworht filter)

lin_acc_turn_event_comp = DetectTurningEventsLinAcc(caliberated_lin_acc_butter,time_lin_acc);

% cancatenating immediate turning profiles

concanetated_turn_event_comp = ConcatenateTurns(lin_acc_turn_event_comp);

%Detecting events long_acc, lat_acc, gyroscope
brake_event_comp = DetectBrakeEvents(calibrated_raw_acc,time_raw_acc);

% turn events gyroscope
gyr_turn_event_comp = DetectTurnEventsGyr(caliberated_butter_gyro,time_raw_gyro);

%gyr_turn_event_comp_res = DetectTurnEventsGyrRes(filter_butter_res_gyro,time_raw_gyro);

%Calculate theta deviation during turns
theta_comp = CalculateBearingChangeGyr(gyr_turn_event_comp,caliberated_butter_gyro);

theta_comp_res = CalculateBearingChangeGyrRes(gyr_turn_event_comp_res,filter_butter_res_gyro);

%Calculating distance from lat lon data

[disthav_comp,distpyth_comp] = CalculateDistFromLatLon(latLon);

% Estimating radius of curvature od an example turn

%estimating theta(heading) time series for an example turn

[my_turn_profile,my_lat_acc_prof,my_long_acc_prof,my_strt_ind,my_end_ind,my_strt_ind_lin_acc,my_end_ind_lin_acc] = GetProfilesofTurn(gyr_turn_event_comp,lin_acc_turn_event_comp,caliberated_butter_gyro,calibrated_raw_acc,caliberated_lin_acc_butter,6,9);

[d_theta_my_turn_prof,theta_prof] = GetBearingProf(my_turn_profile);

%Estimating velocity profile
% init_vel = 17;
% my_vel_prof = GetVelProfile(my_long_acc_prof,init_vel);

my_vel_prof = speed(my_strt_ind:my_end_ind,1);

%Estimating displacement time series

my_disp_prof = GetArcLengthOfCurve(my_vel_prof);
total_disp = sum(my_disp_prof);

heavy = zeros(2519,1);
ssum = 0;

for i=1:2519
    ssum = ssum + my_disp_prof(i,1);
    heavy(i,1) = ssum;
end
    

%Estimating radius time series
[my_rad_profile,my_rad_profile_x_acc] = GetRadiusProfileOfCurve(my_disp_prof,d_theta_my_turn_prof,my_vel_prof,my_lat_acc_prof);

%Estimating Lateral Velocity
init_lat_vel = 0;
my_lat_velocity = GetLatVelProfile(my_lat_acc_prof,init_lat_vel);

% Estimating lateral disp using velocity
[my_lat_disp_vel_prof,lat_disp_steps] = GetLatDisp(my_lat_velocity);

%estimating position profile(Considering start of a turn as origin)
my_turn_pos_profile = GetTurnPosProfile(lat_disp_steps,my_vel_prof);

% Plotting road profile using lat_lon data from google map

% Creating sample lat_lon data

%catesian_lat_lon = CreateTurnPosProfileFromGoogleMapData();


%Plot All Profiles for sample turn

% figure
% plot(catesian_lat_lon(:,1),catesian_lat_lon(:,2))

figure
plot(my_turn_pos_profile(:,1),my_turn_pos_profile(:,2))

time_start = time_raw_gyro(my_strt_ind);
time_end = time_raw_gyro(my_end_ind);

time_start_lin_acc = time_lin_acc(my_strt_ind_lin_acc,1);
time_end_lin_acc = time_lin_acc(my_end_ind_lin_acc,1);


figure 
plot(time_lin_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,1),my_lat_disp_vel_prof)

figure 
plot(time_lin_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,1),my_lat_velocity)

figure 
plot(time_lin_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,1),my_lat_acc_prof)

figure 
plot(time_lin_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,1),my_long_acc_prof)

figure 
plot(time_raw_gyro(my_strt_ind:my_end_ind,1),my_turn_profile)

figure 
plot(time_raw_gyro(my_strt_ind:my_end_ind,1),theta_prof)

figure 
plot(time_lin_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,1),my_vel_prof)

figure 
plot(time_lin_acc(my_strt_ind_lin_acc:my_end_ind_lin_acc,1),my_disp_prof)

% figure 
% plot(time_raw_gyro(my_strt_ind:my_end_ind,1),my_lat_disp_profile)

figure 
plot(heavy,my_rad_profile)

figure 
plot(time_raw_gyro(my_strt_ind:my_end_ind,1),my_rad_profile)

figure
plot(time_raw_gyro(my_strt_ind:my_end_ind,1),my_rad_profile_x_acc)

end
