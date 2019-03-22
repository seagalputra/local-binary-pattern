%% Preprocessing data
clear;
clc;
close all;
addpath('lib');
data = xlsread('data\dataset.xlsx', 'DataTrain');

% shuffle data
% idx = randperm(size(data,1));
% data = data(idx,:);

% separate data and label
feature = data(:,1:4);
label = data(:,5);

%% split data into training and validation
dataTrain = feature(1:3000,:);
dataValidation = feature(3001:4000,:);
labelTrain = label(1:3000,:);
labelValidation = label(3001:4000,:);

%% kNearest Neighbors Algorithm
k = 5;
predict = kNNClassifier(dataTrain, dataValidation, labelTrain, k);

%% Compute accuracy
correct = predict == labelValidation;
accuracy = sum(correct) / size(labelValidation, 1);
disp(['Akurasi : ', num2str(accuracy)]);