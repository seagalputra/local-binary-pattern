clear;
clc;
close all;

% Load trained model
knnMdl = loadCompactModel('KNNModel');

% Testing model
% 1. Load image
image = imread('data/cropped/indramayu/indramayu_20.jpg');
grayImage = rgb2gray(image);

% 2. Extract LBP Features
fiturLBP = extractLBPFeatures(grayImage);

% 3. Predict image
predict = knnMdl.predict(fiturLBP);
if (predict == 0)
    label = 'Indramayu';
elseif (predict == 1)
    label = 'Harumanis';
end

imshow(image);
title(['Label : ', label]);