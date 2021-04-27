function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA
    
	[NumSamples NumFeatures] = size(Samples);
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes)  %The number of classes

    m0 = 0;
    Sw = zeros(size(Samples,2),size(Samples,2));
    St = cov(Samples); %total covariance matrix or total Scatter

    %For each class i
	%Find the necessary statistics
    for i=1:NumClasses
        %Calculate the Class Prior Probability
        P = sum(Labels==i-1)/NumSamples;
        %Calculate the Class Mean 
        mu(i,:) = mean(Samples(Labels==i-1,:));
        %Calculate the Within Class Scatter Matrix
        Sw = Sw + (P*cov(Samples(Labels==i-1,:)));
        %Calculate the Global Mean
        m0 = mean(NumFeatures*mu(i,:))+m0;
    end
  
    %Calculate the Between Class Scatter Matrix
	Sb = St-Sw;
    
    %Eigen matrix EigMat=inv(Sw)*Sb
    EigMat = inv(Sw)*Sb;
    
    %Perform Eigendecomposition
    [V,D] = eig(EigMat);
    
    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
	A=zeros(NumFeatures,NewDim);  % Return the LDA projection vectors
    
    assert(NewDim<=NumClasses-1,'Rescaling Error')
    
    % Sort the eigenvectors according to their corresponding eigenvalues (descending order)
% D = diag(D);
% [~, index] = sort(-D);
% D = D(index);
% V = V(:, index);
% A = V(:,1:NumClasses-1);

    
    lambda = diag(D);
    [~,SortOrder] = sort(lambda,'descend');
%     A = V(:,SortOrder);
    V = V(:, SortOrder);
    A = V(:,1:NewDim);
%     reshape(A,1,[])
    disp(A)
    disp(V)
%     assert(NumFeatures==size(A,1)&&NewDim==size(A,2),'whatsu doin');
end