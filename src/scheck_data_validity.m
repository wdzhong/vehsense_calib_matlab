%Read files

data_file_raw_acc = csvread(strcat('nexus5x4','/raw_acc.txt'));
data_file_raw_lin_acc = csvread(strcat('nexus5x4','/raw_lin_acc.txt'));
data_file_raw_gyro = csvread(strcat('nexus5x4','/raw_gyro.txt'));

%gps = csvread(strcat(data_folder_path,'/gps.txt'));
%obd = csvread(strcat(data_folder_path,'/raw_obd.txt'));

%Read raw acc data

[time_raw_acc,sys_time_acc,raw_acc] = getRawAcc(data_file_raw_acc);

%  figure
%  plot(time_raw_acc,raw_acc(:,3))

[time_lin_acc,sys_time_lin_acc,raw_lin_acc] = getRawLinAcc(data_file_raw_lin_acc);

% read raw gyro data

[time_raw_gyro,sys_time_gyro,raw_gyro] = getGyro(data_file_raw_gyro);

figure
plot(time_raw_gyro,raw_gyro(:,1))

% Smooth raw_gyro data (APP Way)0.008
smoo_raw_gyro_comp = SmoothDataApp(raw_gyro,0.001);
smoo_res_gyro_comp = ComputeResultant(smoo_raw_gyro_comp);

figure
plot(time_raw_gyro,smoo_raw_gyro_comp(:,1))
figure
plot(time_raw_gyro,smoo_raw_gyro_comp(:,2))
figure
plot(time_raw_gyro,smoo_raw_gyro_comp(:,3))

%Smooth raw_gyro data (Butterworth filter)
filter_butter_raw_gyro = SmoothDataButter(raw_gyro,3,0.0008,'low');

figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,1))
figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,2))
figure
plot(time_raw_gyro,filter_butter_raw_gyro(:,3))

smoo_raw_acc_comp = SmoothDataApp(raw_acc,0.001);
smoo_lin_acc_comp = SmoothDataApp(raw_lin_acc,0.005);


figure
plot(time_raw_acc,smoo_raw_acc_comp(:,1))

figure
plot(time_raw_acc,smoo_raw_acc_comp(:,2))

figure
plot(time_raw_acc,smoo_raw_acc_comp(:,3))






figure
plot(time_lin_acc,smoo_lin_acc_comp(:,1))

figure
plot(time_lin_acc,smoo_lin_acc_comp(:,2))

figure
plot(time_lin_acc,smoo_lin_acc_comp(:,3))



res_lin_acc = ComputeResultant(smoo_lin_acc_comp);

figure
plot(time_lin_acc,res_lin_acc)

filter_butter_raw_acc_lin = SmoothDataButter(raw_lin_acc,3,0.003,'low');

figure
plot(time_lin_acc,filter_butter_raw_acc_lin(:,1))
figure
plot(time_lin_acc,filter_butter_raw_acc_lin(:,2))
figure
plot(time_lin_acc,filter_butter_raw_acc_lin(:,3))