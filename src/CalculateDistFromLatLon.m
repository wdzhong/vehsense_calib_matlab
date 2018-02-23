function [ disthav_comp,distpyth_comp ] = CalculateDistFromLatLon( latLon )
%UNTITLED31 Summary of this function goes here
%   Detailed explanation goes here
[num_rows_lat_lon,num_cols_lat_lon] = size(latLon);

disthav_comp = zeros(num_rows_lat_lon-1,1);
distpyth_comp = zeros(num_rows_lat_lon-1,1);

for i=1:num_rows_lat_lon-1
    lat1 = latLon(i,1);
    lon1 = latLon(i,2);
    
    latlon1 = [lat1,lon1]
    
    lat2 = latLon(i+1,1);
    lon2 = latLon(i+1,2);
    
    latlon2 = [lat2,lon2];
    
    [disthav,distpyth] = lldistkm(latlon1,latlon2);
    
    disthav = disthav*1000; % in meters
    distpyth = distpyth*1000;
    
    disthav_comp(i,1) =  disthav;
    distpyth_comp(i,1) = distpyth;
    
end

end

