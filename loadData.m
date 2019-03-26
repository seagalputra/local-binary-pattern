clear;
clc;
close all;

listSubFolder = dir('data\**\*.JPG');
for i = 1:size(listSubFolder,1)
    imageData{i} = imread(fullfile(listSubFolder(i).folder, listSubFolder(i).name));
    name = strsplit(listSubFolder(i).name, '_');
    if (isequal(name{1}, 'indramayu'))
        % assign label 0 for indramayu
        label(i,:) = 0;
    elseif (isequal(name{1}, 'harumanis'))
        % assign label 1 for harumanis
        label(i,:) = 1;
    end
    disp([listSubFolder(i).name, ' loaded']);
end

save(fullfile('data','mangga.mat'), 'imageData', 'label');