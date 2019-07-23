%% Load image data
clear;
clc;
close all;

load(fullfile('data', 'data_mangga.mat'));
%% Ambil ciri LBP dengan library Matlab
% PARAMETER
NumNeighbors = 8; % range antara 4 sampai 24
Radius = 1; % range antara 1 sampai 5

% konversi gambar menjadi grayscale
disp('Convert image into grayscale..')
train_gray = cellfun(@(image) rgb2gray(image), train_data, 'UniformOutput', false);
test_gray = cellfun(@(image) rgb2gray(image)', test_data, 'UniformOutput', false);

% ekstraksi fitur menggunakan local binary patterns
disp('Extract local binary pattern features..')
train_features = extract_features(train_gray, NumNeighbors, Radius);
test_features = extract_features(test_gray, NumNeighbors, Radius);

% acak urutan data
disp('Saving data..')
[train_features, train_filename, train_label] = shuffle_data(train_features, train_filename, train_label);
[test_features, test_filename, test_label] = shuffle_data(test_features, test_filename, test_label);

% simpan data ke dalam file mat
save('training_mangga.mat', 'train_features', 'train_filename', 'train_label');
save('testing_mangga.mat', 'test_features', 'test_filename', 'test_label');

function features = extract_features(data, NumNeighbors, Radius)
    size_data = size(data,1);
    for i = 1:size_data
        features(i,:) = extractLBPFeatures(data{i}, 'Radius', Radius, 'NumNeighbors', NumNeighbors);
    end
end

function [features_shuffle, filename_shuffle, label_shuffle] = shuffle_data(features, filename, label)
    idx = randperm(size(features,1));
    filename_shuffle = filename(idx);
    features_shuffle = features(idx,:);
    label_shuffle = label(idx,:);
end