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
% dataTrain = feature(1:3000,:);
% dataValidation = feature(3001:4000,:);
% labelTrain = label(1:3000,:);
% labelValidation = label(3001:4000,:);

%% cek data
dataTrain = feature(1:20,:);
dataValidation = feature(21:25,:);
labelTrain = label(1:20,:);
labelValidation = label(21:25,:);

%% kNearest Neighbors Algorithm
% k = 1:2:100;
% for i = 1:size(k,2)
%     disp(['K : ',num2str(k(i))]);
%     predict(:,i) = kNNClassifier(dataTrain, dataValidation, labelTrain, k(i));
% end

%%
k = 3;
predict = kNNClassifier(dataTrain, dataValidation, labelTrain, k);
%% Compute accuracy
correct = predict == labelValidation;
accuracy = sum(correct) / size(labelValidation, 1);
disp(['Akurasi : ', num2str(accuracy)]);

%%
% for i = 1:size(predict,2)
%     correct = predict(:,i) == labelValidation;
%     accuracy(i) = sum(correct) / size(labelValidation,1);
% end