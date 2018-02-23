function [ raw_acc,raw_lin_acc,raw_gyro,gps,obd ] = ReadRawData( data_folder_path )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

raw_acc = csvread(strcat(data_folder_path,'/raw_acc.txt'));
raw_lin_acc = csvread(strcat(data_folder_path,'/raw_lin_acc.txt'));
raw_gyro = csvread(strcat(data_folder_path,'/raw_gyro.txt'));
gps = csvread(strcat(data_folder_path,'/gps.txt'));
obd = csvread(strcat(data_folder_path,'/raw_obd.txt'));

end

