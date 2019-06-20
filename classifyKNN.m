%% Load image data
clear;
clc;
close all;

addpath('lib');
load('fiturLBP.mat');

%% Fit into knn classifier
% membuat partisi kfold cross validation
cv = cvpartition(labelTrain, 'KFold', 10);

% train semua data untuk setiap partisi
for i = 1:cv.NumTestSets
    trainPartition = dataTrain(cv.training(i),:);
    labelTrainPartition = labelTrain(cv.training(i),:);
    testPartition = dataTrain(cv.test(i),:);
    labelTestPartition = labelTrain(cv.test(i),:);
    
    knnMdl = fitcknn(trainPartition, labelTrainPartition, ...
        'NumNeighbors', 7, 'Standardize', 1);
    predict = knnMdl.predict(testPartition);
    correctPredict = predict == labelTestPartition;
    accuracy(i) = sum(correctPredict) / size(labelTestPartition, 1);
end

% save model
% saveCompactModel(knnMdl, 'KNNModel');