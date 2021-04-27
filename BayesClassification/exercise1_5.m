close all;
clear;
clc;

data_file = './data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');


%% Compute Aspect Ratio

count_tst_C1   = size(test_C1_indices,2);
count_tst_C2   = size(test_C2_indices,2);
count_tr_C2  = size(train_C1_indices,2);
count_tr_C2  = size(train_C2_indices,2);
ratio_tr_c1 = zeros(count_tr_C2,1);
ratio_tr_c2 = zeros(count_tr_C2,1);
ratio_tst_c1 = zeros(count_tst_C1,1);
ratio_tst_c2 = zeros(count_tst_C2,1);

% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)
for i=1:count_tr_C2
    ratio_tr_c1(i,1) = computeAspectRatio(squeeze(train_C1_images(i,:,:)));
end
for i=1:count_tr_C2
    ratio_tr_c2(i,1) = computeAspectRatio(squeeze(train_C2_images(i,:,:)));
end
for i=1:count_tst_C1
    ratio_tst_c1(i,1) = computeAspectRatio(squeeze(test_C1_images(i,:,:)));
end
for i=1:count_tst_C2
    ratio_tst_c2(i,1) = computeAspectRatio(squeeze(test_C2_images(i,:,:)));
end

bounds_tr_c1 = [min(ratio_tr_c1), max(ratio_tr_c1)];
bounds_tr_c2 = [min(ratio_tr_c2), max(ratio_tr_c2)];
bounds_tst_c1 = [min(ratio_tst_c1), max(ratio_tst_c1)];
bounds_tst_c2 = [min(ratio_tst_c2), max(ratio_tst_c2)];

% display the total minimum and maximum aspect ratio
minAspectRatio = min([bounds_tr_c1(1), bounds_tr_c2(1), bounds_tst_c1(1), bounds_tst_c2(1)])
maxAspectRatio = max([bounds_tr_c1(2), bounds_tr_c2(2), bounds_tst_c1(2), bounds_tst_c2(2)])

%display two random samples with their bounding rect
image_class1 = squeeze(train_C1_images(34,:,:));
previewWithBoundingRect(image_class1);
image_class2 = squeeze(test_C2_images(73,:,:));
previewWithBoundingRect(image_class2);

%% Bayesian Classifier

% Prior Probabilities
PC1 = count_tr_C2/size(data.trainX,1)
PC2 = count_tr_C2/size(data.trainX,1)

% Likelihoods
mu1 = sum(ratio_tr_c1)/count_tr_C2;
mu2 = sum(ratio_tr_c2)/count_tr_C2;
var1 = sqrt(sum((ratio_tr_c1-mu1).^2)/count_tr_C2);
var2 = sqrt(sum((ratio_tr_c2-mu2).^2)/count_tr_C2);
PgivenC1 =@(x) exp(-(x-mu1).^2/(2*(var1^2)))/(var1*sqrt(2*pi));
PgivenC2 =@(x) exp(-(x-mu2).^2/(2*(var2^2)))/(var2*sqrt(2*pi));

% Posterior Probabilities
PC1givenL =@(x) PC1*PgivenC1(x);
PC2givenL =@(x) PC2*PgivenC2(x);

% Classification result
% BayesClass1 is correct when is equal to 1
BayesClass1 = 1*(PC1givenL(ratio_tr_c1(:,:))>=PC2givenL(ratio_tr_c1(:,:))) + ...
    2*(PC1givenL(ratio_tr_c1(:,:)) <PC2givenL(ratio_tr_c1(:,:)));

% BayesClass2 is correct when is equal to 1
BayesClass2 = 2*(PC1givenL(ratio_tr_c2(:,:))>PC2givenL(ratio_tr_c2(:,:))) + ...
    1*(PC1givenL(ratio_tr_c2(:,:))<=PC2givenL(ratio_tr_c2(:,:)));


% Count misclassified digits
count_errors = sum(BayesClass1 == 2) + sum(BayesClass2 == 2);  %result <- 1361
count_correct = sum(BayesClass1 == 1) + sum(BayesClass2 == 1); %result <- 11339

% Total Classification Error (percentage)
Error = count_errors/(count_tr_C2+count_tr_C2);

