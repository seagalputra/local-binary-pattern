function predict = kNNClassifier(dataTrain, dataValidation, labelTrain, k)
% kNearest Neighbors Algorithm

% calculate distance
euclidean = @(x,y) sqrt(sum((x-y).^2));
for i = 1:size(dataValidation,1)
    for j = 1:size(dataTrain,1)
        % disp(['Compute distance from data validation ',num2str(i),' to data train ', num2str(j)]);
        distance(j,:) = euclidean(dataValidation(i,:), dataTrain(j,:));
    end

    % sort distance in ascending
    [sortDist, indDis] = sort(distance, 'ascend');
    % sort training label
    labelSort = labelTrain(indDis);
    labelVote = labelSort(1:k,:);
    % find most frequent label
    predict(i,:) = mode(labelVote);
end

end