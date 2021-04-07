function X_rec = recoverDataPCA(Z, U, K)
%RECOVERDATA Recovers an approximation of the original data when using the 
%projected data
%   X_rec = RECOVERDATA(Z, U, K) recovers an approximation the 
%   original data that has been reduced to K dimensions. It returns the
%   approximate reconstruction in X_rec.
%

    rows = size(Z, 1);
    X_rec = zeros(rows, size(U, 1));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the approximation of the data by projecting back
%               onto the original space using the top K eigenvectors in U.
%
%

    for i = 1 : rows
        X_rec(i,:) = Z(i,:) * U(:,1:K)';
    end

% =============================================================

end
