function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.


mu = zeros(1,size(X,2));% mean of each column (feature)

sigma = zeros(1,size(X,2));% standart deviation of each column
X_norm = zeros(size(X));% normalize each column independently

for i = 1: size(X, 2) %foreach column
    mu(:,i) = mean(X(:, i));
    sigma(:,i) = std(X(:, i));
    X_norm(:, i) = (X(:, i) - mu(1,i) ) / sigma(1,i);
end

% ============================================================

end
