% overfittingTest.m

numFeatures = 1000;
numSelectedFeatures = 100;
numPositiveExamples = 15;  % E.g., Autism
numNegativeExamples = 10;  % E.g., Typically developing subjects
numExamples = numPositiveExamples + numNegativeExamples;
labels = ones(numExamples, 1);
labels(1:numNegativeExamples) = -1;
features = randn(numExamples, numFeatures);

disp('Classify without feature selection')
% Cross validation. Leave one out
numCorrectlyClassified = 0;
for i = 1:numExamples
    idx = [1:i-1, i+1:numExamples]; % Leave out example i 
    SVMStruct = svmtrain(features(idx, :), labels(idx));
    predictedLabel = svmclassify(SVMStruct, features(i, :)); % Classify example i
    if (predictedLabel == labels(i))
        numCorrectlyClassified = numCorrectlyClassified + 1;
    end
end

% Proportion of true results (both true positives and true negatives) among the total number of cases examined
accuracy = numCorrectlyClassified/numExamples;  
disp(strcat('accuracy : ', num2str(accuracy)))
disp(' ')

% --------------------------------------------------------------------

disp('Classify with feature selection inside the cross validation')

% Cross validation. Leave one out
numCorrectlyClassified = 0;
for i = 1:numExamples
    % Your code here    
end

% Proportion of true results (both true positives and true negatives) among the total number of cases examined
accuracy = numCorrectlyClassified/numExamples;  
disp(strcat('accuracy : ', num2str(accuracy)))
disp(' ')

% --------------------------------------------------------------------

disp('Classify with feature selection outside the cross validation')
% Feature selection
% Your code here

% Cross validation. Leave one out
numCorrectlyClassified = 0;
for i = 1:numExamples
    % Your code here
end

% Proportion of true results (both true positives and true negatives) among the total number of cases examined
accuracy = numCorrectlyClassified/numExamples;  
disp(strcat('accuracy : ', num2str(accuracy)))
disp(' ')
