%% Load image data
clear;
clc;
close all;

addpath('lib');
load(fullfile('data', 'mangga.mat'));

%% Ambil ciri LBP dengan lib Matlab

% PARAMETER
NumNeighbors = 8; % range antara 4 sampai 24
Radius = 1; % range antara 1 sampai 5

for i = 1:size(imageData,2)
    grayImage = rgb2gray(imageData{i});
    lbp_features{i,:} = extractLBPFeatures(grayImage, 'Radius', Radius, ...
        'NumNeighbors', NumNeighbors);
    disp(['LBP features from image - ', num2str(i) ,' successfully extracted']);
end
features = cell2mat(lbp_features);

%% Process data
% Shuffle data
idx = randperm(size(features,1));
filename = listName(idx);
features = features(idx,:);
label = label(idx,:);
% Split data
split_ratio = 0.8;
num_features = size(features,1);
% untuk data train
num_data_train = num_features * split_ratio;
data_train = features(1:num_data_train,:);
label_train = label(1:num_data_train,:);
filename_train = filename(1:num_data_train);

% untuk data test
num = 1 - split_ratio;
test_num = int64(num * size(features,1));
indramayu = find(label == 0);
harumanis = find(label == 1);
rand_indramayu = randperm(size(indramayu,1), test_num/2);
rand_harumanis = randperm(size(harumanis,1), test_num/2);

idx_indramayu = indramayu(rand_indramayu);
idx_harumanis = harumanis(rand_harumanis);
test_indramayu = features(idx_indramayu,:);
test_harumanis = features(idx_harumanis,:);
label_indramayu = label(idx_indramayu,:);
label_harumanis = label(idx_harumanis,:);
filename_indramayu = filename(:,idx_indramayu);
filename_harumanis = filename(:,idx_harumanis);
data_test = [test_indramayu; test_harumanis];
label_test = [label_indramayu; label_harumanis];
filename_test = [filename_indramayu, filename_harumanis];

% save mat dataset
save('fiturLBP.mat', 'data_train', ...
    'data_test', 'label_train', 'label_test', ...
    'filename_train', 'filename_test');