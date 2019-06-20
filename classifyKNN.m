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
        'NumNeighbors', 11, 'Standardize', 1);
    predict = knnMdl.predict(testPartition);
    correctPredict = predict == labelTestPartition;
    confusionMat{i} = confusionmat(double(correctPredict), labelTestPartition);
    accuracy(i) = sum(correctPredict) / size(labelTestPartition, 1);
end

% jumlah keseluruhan confusion matrix
sumConfusion = zeros(2,2);
for i = 1:size(confusionMat,2)
    sumConfusion = sumConfusion + confusionMat{i};
end

% rata-rata akurasi
averageAcc = mean(accuracy);
disp(averageAcc);
% save model
saveCompactModel(knnMdl, 'KNNModel');