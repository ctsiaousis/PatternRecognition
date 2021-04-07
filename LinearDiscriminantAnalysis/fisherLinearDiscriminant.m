function v = fisherLinearDiscriminant(X1, X2)

%     m1 = size(X1, 1);
%     m2 = size(X2, 1);
% 
%     mu1 = % mean value of X1
%     mu2 = % mean value of X2
% 
%     S1 = % scatter matrix of X1
%     S2 = % scatter matrix of X2
% 
%     Sw = % Within class scatter matrix
% 
%     v = % optimal direction for maximum class separation 
% 
%     v = % return a vector of unit norm
    m1 = size(X1,1);
    m2 = size(X2,1);
    
    mu1 = mean(X1,'double')';    % mean value of X1
    mu2 = mean(X2,'double')';    % mean value of X2
    
    S1 = X1'*X1;        % scatter matrix of X1
    S2 = X2'*X2;        % scatter matrix of X2

    Sw = (S1+S2)/2;     % Within class scatter matrix

    v_b = inv(Sw)*(mu1(:,1)-mu2(:,1));% optimal direction for maximum class separation 

    v = v_b/norm(v_b);% return a vector of unit norm
