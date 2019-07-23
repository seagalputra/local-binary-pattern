clear; clc; close all;

% load fitur testing data
load('testing_mangga.mat');
% load model KNN
model = loadCompactModel('model_knn.mat');

% testing data
size_data = size(test_features,1);
for i = 1:size_data
    test_predict = model.predict(test_features);
end
% hitung akurasi
accuracy = sum(test_predict == test_label) / size(test_label,1);
disp(['Accuracy : ', num2str(accuracy)]);
% plot confusion matrix
confusion_matrix = confusionmat(test_label, test_predict);
plotConfMat(confusion_matrix);
