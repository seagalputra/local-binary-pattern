clear;
clc;
close all;

listSubFolder = dir('data\**\*.JPG');
for i = 1:size(listSubFolder,1)
    imageData{i} = imread(fullfile(listSubFolder(i).folder, listSubFolder(i).name));
    name = strsplit(listSubFolder(i).name, '_');
    if (isequal(name{1}, 'indramayu'))
        label{i} = 'indramayu';
    elseif (isequal(name{1}, 'harumanis'))
        label{i} = 'harumanis';
    end
    disp([listSubFolder(i).name, ' loaded']);
end

save(fullfile('data','mangga.mat'), 'imageData', 'label');