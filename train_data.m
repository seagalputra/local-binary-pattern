clear; clc; close all;

load('training_mangga.mat');

% k-fold cross validation
fold = 10;
cv = cvpartition(train_label, 'KFold', fold);

k = 11;
for i = 1:cv.NumTestSets
    train = train_features(cv.training(i),:);
    label_train = train_label(cv.training(i),:);
    validation = train_features(cv.test(i),:);
    label_validation = train_label(cv.test(i),:);
    
    model = fitcknn(train, label_train, 'NumNeighbors', k, 'Standardize', 1);
    predict = model.predict(validation);
    
    % hitung akurasi
    correct = label_validation == predict;
    list_accuracy(i) = sum(correct) / size(label_validation,1);
end

% rata-rata akurasi
accuracy = mean(list_accuracy);
disp(['Accuracy : ', num2str(accuracy)]);
% simpan model
saveCompactModel(model, 'model_knn.mat');