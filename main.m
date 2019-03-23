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

%% Convert label to binary 0 or 1
% label 0 untuk indramayu, label 1 untuk harumanis
for i = 1:size(labelTrain,1)
    if (labelTrain{i} == 'indramayu')
        Y(i,:) = 0; 
    elseif (labelTrain{i} == 'harumanis')
        Y(i,:) = 1;
    end
end

%% Fit into knn classifier
% knnMdl = fitcknn(dataTrain, labelTrain, 'NumNeighbors',11,'Standardize',1);
% predict = knnMdl.predict(dataValidation);
predict = kNNClassifier(dataTrain, dataValidation, Y, 11);

%% Accuracy
% correct = predict == labelValidation;
% accuracy = sum(correct) / size(labelValidation, 1);
% disp(['Akurasi : ', num2str(accuracy)]);

%%
for i = 1:size(predict,1)
    eq(i) = predict(i) == labelValidation{i};
end
corr = sum(eq) / size(predict,1);