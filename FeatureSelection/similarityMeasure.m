% The following function uses the squared Pearson's correlation coefficient 
% to measure the similarity between vectors x and y
function r = similarityMeasure(x, y)
    
    x0 = x - mean(x);
    y0 = y - mean(y);

    r = x0'*y0/(sqrt(x0'*x0)*sqrt(y0'*y0));
    r = r^2; % square

    %R = corrcoef(x, y)
    %r = R(1,2)^2
