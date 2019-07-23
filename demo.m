clear;
clc;
close all;

% Load trained model
knnMdl = loadCompactModel('model_knn.mat');

% Testing model
% 1. Load image
image = imread('data/cropped/train/indramayu/indramayu_1.jpg');
grayImage = rgb2gray(image);

% 2. Extract LBP Features
NumNeighbors = 8; % range antara 4 sampai 24
Radius = 1; % range antara 1 sampai 5
fiturLBP = extractLBPFeatures(grayImage, 'Radius', Radius, 'NumNeighbors', NumNeighbors);

% 3. Predict image
predict = knnMdl.predict(fiturLBP);
if (predict == 0)
    label = 'Harumanis';
elseif (predict == 1)
    label = 'Indramayu';
end

imshow(image);
title(['Label : ', label]);