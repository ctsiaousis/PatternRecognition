function out = mapFeature(X1, X2)
% MAPFEATURE Feature mapping function to polynomial features
%
%   MAPFEATURE(X1, X2) maps the two input features
%   to quadratic features used in the regularization exercise.
%
%   Returns a new feature array with more features, comprising of 
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%
%   Inputs X1, X2 must be the same size
%

assert(isequal(size(X1), size(X2)),...
    'Inputs X1, X2 must be the same size')
degree = 6;
out = ones(length(X1(:,1)), 28);
for i=1:degree
    for j=0:i
        out(:,end+1) = (X1.^(i-j)).*(X2.^j);
    end
end

end
