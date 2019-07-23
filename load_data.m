clear; clc; close all;

train_folder = dir('data/cropped/train/**/*.jpg');
test_folder = dir('data/cropped/test/**/*.jpg');

% load training image data
disp('Load training data..');
[train_data, train_label, train_filename] = load_batch_data(train_folder);
% load testing image data
disp('Load test data..');
[test_data, test_label, test_filename] = load_batch_data(test_folder);

% save file into mat
save('data/data_mangga.mat', 'train_data', 'test_data', ...
    'train_label', 'test_label', 'train_filename', 'test_filename');

function [data, label, list_filename] = load_batch_data(directory)
    data_size = size(directory,1);
    data = cell(data_size,1);
    label = zeros(data_size,1);
    list_filename = cell(data_size,1);
    for i = 1:data_size
        folder_name = directory(i).folder;
        filename = directory(i).name;
        data{i,:} = imread(fullfile(folder_name, filename));
        label(i,:) = assign_label(filename);
        list_filename{i,:} = filename;
    end
end

function label = assign_label(filename)
    name = strsplit(filename, '_');
    if (isequal(name{1}, 'harumanis'))
        label = 0;
    elseif (isequal(name{1}, 'indramayu'))
        label = 1;
    end
end