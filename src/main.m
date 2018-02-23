% main entry point of program

% normally this should not happen
if exist('../data/', 'dir') ~= 7
    disp("There is no ../data folder")
    disp("Create ../data folder. You need to put data files in it.")
    mkdir '../data'
    return
end

dataDirectory = dir('../data/');

% deal with trip data one by one
for folder_index = 1:size(dataDirectory, 1)
    if dataDirectory(folder_index).isdir && ~isequal(dataDirectory(folder_index).name, '.') && ~isequal(dataDirectory(folder_index).name, '..')
        fprintf("Now deal with data from trip: %s\n", dataDirectory(folder_index).name);
        fullPath = strcat('../data/', dataDirectory(folder_index).name);
        smartphone_data_process(fullPath);
    end
end
