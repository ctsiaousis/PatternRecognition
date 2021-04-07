function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA

	A=zeros(NumFeatures,NewDim);
    
	[NumSamples NumFeatures] = size(Samples);
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes)  %The number of classes

    %For each class i
	%Find the necessary statistics
    
    %Calculate the Class Prior Probability
	P(i)=
    %Calculate the Class Mean 
	mu(i,:)
    %Calculate the Within Class Scatter Matrix
	Sw=
    %Calculate the Global Mean
	m0=

  
    %Calculate the Between Class Scatter Matrix
	Sb= 
    
    %Eigen matrix EigMat=inv(Sw)*Sb
    EigMat = inv(Sw)*Sb;
    
    %Perform Eigendecomposition

    
    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
	A=zeros(NumFeatures,NewDim);  % Return the LDA projection vectors
