%% Load image data
clear;
clc;
close all;

addpath('lib');
load('fiturLBP.mat');

%% Cari nilai k terbaik
k = 1:2:200;
for i = 1:size(k,2)
    knnMdl = fitcknn(dataTrain,labelTrain,'NumNeighbors',i,'Standardize',1);
    predict = knnMdl.predict(dataTest);
    correct = predict == labelTest;
    accuracy(i) = sum(correct) / size(labelTest,1);
end

%% Assign the besk k value in new model
[~,maxIdx] = max(accuracy);
bestK = k(maxIdx);
knnMdl = fitcknn(dataTrain,labelTrain,'NumNeighbors',bestK,'Standardize',1);
% save model
save('KNNModel','knnMdl');

% %% Fit into knn classifier
% knnMdl = fitcknn(dataTrain, labelTrain, 'NumNeighbors',7,'Standardize',1);
% predict = knnMdl.predict(dataTest);
% 
% %% Accuracy
% correct = predict == labelTest;
% accuracy = sum(correct) / size(labelTest, 1);
% disp(['Akurasi : ', num2str(accuracy)]);