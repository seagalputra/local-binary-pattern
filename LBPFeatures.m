%% Load image data
clear;
clc;
close all;

addpath('lib');
load(fullfile('data', 'mangga.mat'));

%% Using texture descriptor extract feature vector using Local Binary Pattern

% TODO : Fix this thing
% for i = 1:size(imageData,2)
%     tempLbp = localBinaryPattern(imageData{i});
%     imageLbp{i} = uint8(tempLbp);
%     
%     % Split image into separate patch
%     imageSplit = createImagePatch(imageLbp{i},4,4);
% 
%     % Create histogram from patch
%     for j = 1:size(imageSplit,2)
%         features(i,:) = createFeatureFromHistogram(imageSplit{j});
%     end
%     disp(['image - ', num2str(i), ' extracted..']);
% end

%% Ambil ciri LBP dengan lib Matlab
for i = 1:size(imageData,2)
    grayImage = rgb2gray(imageData{i});
    lbpFeatures{i,:} = extractLBPFeatures(grayImage);
    disp(['LBP features from image - ', num2str(i) ,' successfully extracted']);
end
features = cell2mat(lbpFeatures);

%% Process data
% Shuffle data
idx = randperm(size(features,1));
features = features(idx,:);
label = label(idx,:);
% Split data
splitRatio = 0.8;
numFeatures = size(features,1);
numDataTrain = numFeatures * splitRatio;
numDataTest = numFeatures - numDataTrain;
dataTrain = features(1:numDataTrain,:);
dataTest = features(numDataTrain+1:numFeatures,:);
labelTrain = label(1:numDataTrain,:);
labelTest = label(numDataTrain+1:numFeatures,:);

save('fiturLBP.mat', 'dataTrain', 'dataTest', 'labelTrain', 'labelTest');