function [ catesian_lat_lon ] = CreateTurnPosProfileFromGoogleMapData( )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
sample_lat_lon = zeros(12,2);

% sample_lat_lon(1,1) = 43.004604;
% sample_lat_lon(1,2) = -78.805632;
% sample_lat_lon(2,1) = 43.004602;
% sample_lat_lon(2,2) = -78.805471;
% sample_lat_lon(3,1) = 43.004604;
% sample_lat_lon(3,2) = -78.805211;
%sample_lat_lon(4,1) = 43.004604;
% sample_lat_lon(4,2) = -78.805079;

sample_lat_lon(1,1) = 43.004598;
sample_lat_lon(1,2) = -78.804983;
 
sample_lat_lon(2,1) = 43.004601;
sample_lat_lon(2,2) = -78.804833;

sample_lat_lon(3,1) = 43.004597;
sample_lat_lon(3,2) = -78.804753;

sample_lat_lon(4,1) = 43.004591;
sample_lat_lon(4,2) = -78.804673;

sample_lat_lon(5,1) = 43.004575;
sample_lat_lon(5,2) = -78.804550; 


sample_lat_lon(6,1) = 43.004562;
sample_lat_lon(6,2) = -78.804422;

sample_lat_lon(7,1) = 43.004540;
sample_lat_lon(7,2) = -78.804297;

sample_lat_lon(8,1) = 43.004518;
sample_lat_lon(8,2) = -78.804194;

sample_lat_lon(9,1) = 43.004505;
sample_lat_lon(9,2) = -78.804094;

sample_lat_lon(10,1) = 43.004482;
sample_lat_lon(10,2) = -78.803999


sample_lat_lon(11,1) = 43.004470;
sample_lat_lon(11,2) = -78.803895;

sample_lat_lon(12,1) = 43.004448;
sample_lat_lon(12,2) = -78.803792;


% sample_lat_lon(17,1) = 43.004414;
% sample_lat_lon(17,2) = -78.803668;
% sample_lat_lon(18,1) = 43.004379;
% sample_lat_lon(18,2) = -78.803515;
% sample_lat_lon(19,1) = 43.004349;
% sample_lat_lon(19,2) = -78.803324;
% sample_lat_lon(20,1) = 43.004318;
% sample_lat_lon(20,2) = -78.803113;
% sample_lat_lon(21,1) = 43.004303;
% sample_lat_lon(21,2) = -78.802877;
% sample_lat_lon(22,1) = 43.004284;
% sample_lat_lon(22,2) = -78.802517;
% sample_lat_lon(23,1) = 43.004284;
% sample_lat_lon(23,2) = -78.802034;
catesian_lat_lon = zeros(12,3);
lat_init = sample_lat_lon(1,1);
lon_init = sample_lat_lon(1,2);
%[x_init,y_init,z_init] = lla2ecef(deg2rad(sample_lat_lon(1,1)),deg2rad(sample_lat_lon(1,2)),0);

for j=1:12
    lat = sample_lat_lon(j,1);
    lon = sample_lat_lon(j,2);
    
    flatearth_pos = lla2flat([lat, lon,0], [lat_init,lon_init], 90, 0)
    
    %[x,y,z] = lla2ecef(deg2rad(lat),deg2rad(lon),0);
    
    catesian_lat_lon(j,:) = flatearth_pos;
%     catesian_lat_lon(j,1) = abs(abs(x) - abs(x_init));
%     catesian_lat_lon(j,2) = abs(abs(y) - abs(y_init));
%     catesian_lat_lon(j,3) = abs(abs(z) - abs(z_init));
    
    
    
end

end

