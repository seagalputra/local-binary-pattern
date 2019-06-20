clear;
clc;
close all;

% original size image
% listSubFolder = dir('data\original\**\*.JPG');
% cropped size image
listSubFolder = dir('data\cropped\**\*.JPG');
% mixed size image
% listSubFolder = dir('data\mixed\**\*.JPG');

for i = 1:size(listSubFolder,1)
    imageData{i} = imread(fullfile(listSubFolder(i).folder, listSubFolder(i).name));
    name = strsplit(listSubFolder(i).name, '_');
    listName{i} = listSubFolder(i).name;
    if (isequal(name{1}, 'indramayu'))
        % assign label 0 for indramayu
        label(i,:) = 0;
    elseif (isequal(name{1}, 'harumanis'))
        % assign label 1 for harumanis
        label(i,:) = 1;
    end
    disp([listSubFolder(i).name, ' loaded']);
end

save(fullfile('data','mangga.mat'), 'listName', 'imageData', 'label');