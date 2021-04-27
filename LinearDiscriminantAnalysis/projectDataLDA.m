function [Z] = projectDataLDA(X, v)

% You need to return the following variables correctly.
Z = zeros(size(X, 1), size(v,2));

% ====================== YOUR CODE HERE ======================

Z = Z + X * v;

% =============================================================

end
