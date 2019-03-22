%% Preprocessing data
clear;
clc;
close all;

data = xlsread('..\data\dataset.xlsx', 'DataTrain');

% shuffle data
idx = randperm(size(data,1));
data = data(idx,:);

% separate data and label
feature = data(:,1:4);
label = data(:,5);

%% split data into training and validation
dataTrain = feature(1:3000,:);
dataValidation = feature(3001:4000,:);
labelTrain = label(1:3000,:);
labelValidation = label(3001:4000,:);

%% kNearest Neighbors Algorithm
% calculate distance
k = 3;
euclidean = @(x,y) sqrt(sum((x-y).^2));
for i = 1:size(dataValidation,1)
    for j = 1:size(dataTrain,1)
        disp(['Compute distance from data validation ',num2str(i),' to data train ', num2str(j)]);
        distance(j,:) = euclidean(dataValidation(i,:), dataTrain(j,:));
        
        if (size(distance,1) == size(dataTrain,1))
            % sort distance in ascending
            [sortDist, indDis] = sort(distance, 'ascend');
            % sort training label
            labelSort = labelTrain(indDis);
            labelVote = labelSort(1:k,:);
            % find most frequent label
            predict(i,:) = mode(labelVote);
        end
    end
end

%% Compute accuracy