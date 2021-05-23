clear all
close all
clc
C = 100; % Choose C = 0.01, 0.1, 1, 10, 100, 1000, 10000

load('./twofeature1.txt');
n = size(twofeature1, 1); % use the last example
y = twofeature1(1:n, 1);
X = twofeature1(1:n, 2:3);

Xpos = X(y==1, :); % positive examples
Xneg = X(y==-1, :); % negative examples

%  Visualize the example dataset
hold on
plot(Xpos(:, 1), Xpos(:, 2), 'b.');
plot(Xneg(:, 1), Xneg(:, 2), 'r.');
hold off
axis square;

% Form the matrices for the quadratic optimization.
H = zeros(n, n);

for i = 1 : n
    for j = i : n
        H(i,j) = y(i)*y(j)*X(i,:)*X(j,:)';
        H(j,i) = H(i,j);
    end
end

f = -ones(n,1);

A = [];

b = [];

Aeq = y';

beq = 0;

lambda = quadprog(H, f, A, b, Aeq, beq,...
    zeros(n,1), -C * f); % Find the Lagrange multipliers

% note the extra restriction in order to maximize the LaGrange
indices = find(lambda > 0.0001 & lambda < C); % Find the support vectors
Xsup = X(indices, :); % The support vectors only 
ysup = y(indices, :);
lambdasup = lambda(indices);

% Find the bias term w0
w0 = y(indices(1)) - sum((lambda.*y) .* (X*X(indices(1),:)'));

% Find the weights
w = sum(((lambda.*y)*ones(1,size(X,2))) .* X);

% Plot support vectors
Xsup_pos = Xsup(ysup==1, :);
Xsup_neg = Xsup(ysup==-1, :);

hold on
plot(Xsup_pos(:, 1), Xsup_pos(:, 2), 'bo');
plot(Xsup_neg(:, 1), Xsup_neg(:, 2), 'ro');
hold off

% Find the width of the margin
width    = (  -w0  ) / max(norm(w(1)),norm(w(2)));
widthNeg = (-w0 - 1) / max(norm(w(1)),norm(w(2)));
widthPos = (-w0 + 1) / max(norm(w(1)),norm(w(2)));

% Plot decision boundary
x1   = linspace(0.05, 4.5, 100);
x2   = x1 * (-1 .* w(1) / w(2)) + width;
xNeg = x1 * (-1 .* w(1) / w(2)) + widthNeg;
xPos = x1 * (-1 .* w(1) / w(2)) + widthPos;
hold on
plot(x1, x2  , 'k')
plot(x1, xPos, 'b')  %Plot the Margin of class +1
plot(x1, xNeg, 'r')  %Plot the Margin of class -1
hold off
xlabel(sprintf('C = %d', C))
