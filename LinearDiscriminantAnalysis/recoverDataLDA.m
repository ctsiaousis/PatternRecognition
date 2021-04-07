function [X_rec] = recoverDataLDA(Z, v)

% You need to return the following variables correctly.
X_rec = zeros(size(Z, 1), length(v));

% ====================== YOUR CODE HERE ======================

for i = 1 : size(Z, 1)
    X_rec(i,:) = Z(i,:)*v;
end

% =============================================================

end
