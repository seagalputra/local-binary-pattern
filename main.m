%% Load image data
clear;
clc;
close all;

addpath('lib');
load(fullfile('data', 'mangga.mat'));

%% Using texture descriptor extract feature vector using Local Binary Pattern

for i = 1:size(imageData,2)
    tempLbp = localBinaryPattern(imageData{i});
    imageLbp{i} = uint8(tempLbp);
    
    % Split image into separate patch
    imageSplit{i} = createImagePatch(imageLbp{i}, [16 16]);

    % Create histogram from patch
    feature(i,:) = createFeatureFromHistogram(imageSplit{i});
    disp(['image - ', num2str(i), ' extracted..']);
end

%% Shuffle and split data
label = label';
idx = randperm(size(feature,1));
feature = feature(idx,:);
label = label(idx,:);

%% Split data
dataTrain = feature(1:100,:);
dataValidation = feature(101:120,:);
labelTrain = label(1:100,:);
labelValidation = label(101:120,:);

%% Fit into knn classifier
% knnMdl = fitcknn(dataTrain, labelTrain, 'NumNeighbors',11,'Standardize',1);
% predict = knnMdl.predict(dataValidation);
predict = kNNClassifier(dataTrain, dataValidation, labelTrain, 11);

%% Accuracy
correct = predict == labelValidation;
accuracy = sum(correct) / size(labelValidation, 1);
disp(['Akurasi : ', num2str(accuracy)]);