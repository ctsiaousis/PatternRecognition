function v = fisherLinearDiscriminant(X1, X2)

    m1 = size(X1, 1);
    m2 = size(X2, 1);

    mu1 = % mean value of X1
    mu2 = % mean value of X2

    S1 = % scatter matrix of X1
    S2 = % scatter matrix of X2

    Sw = % Within class scatter matrix

    v = % optimal direction for maximum class separation 

    v = % return a vector of unit norm
