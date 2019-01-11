%% Load image data
clear;
clc;
close all;

addpath('lib');
img = imread('cameraman.tif');

%% Using texture descriptor extract feature vector using Local Binary Pattern
img_lbp = localBinaryPattern(img);
img_lbp = uint8(img_lbp);
imshow(img_lbp);

%% Split image into separate patch
img_split = createImagePatch(img_lbp, [16 16]);

%% Create histogram from patch
feature = createFeatureFromHistogram(img_split);