function [Z] = projectDataLDA(X, v)

% You need to return the following variables correctly.
Z = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================

withVecs = X * v
Z = Z + withVecs;

% =============================================================

end
