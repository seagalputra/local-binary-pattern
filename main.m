%% Load image data
clear;
clc;
close all;

addpath('lib');
load('fiturLBP.mat');

%% Fit into knn classifier
knnMdl = fitcknn(dataTrain, labelTrain, 'NumNeighbors',7,'Standardize',1);
predict = knnMdl.predict(dataTest);

%% Accuracy
correct = predict == labelTest;
accuracy = sum(correct) / size(labelTest, 1);
disp(['Akurasi : ', num2str(accuracy)]);