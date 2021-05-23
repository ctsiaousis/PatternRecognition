clear all; close all; clc;
load('digits');
A = reshape(train3(43, :), 28, 28)';
imagesc(A); colorbar

%% Calculate p0..p9
% TODO: change the eval to cell
e = 0.0000001;
for i = 0:9
    eval(sprintf('n = size(train%i,1);',i));
    eval(sprintf('p%i = (1/n)*sum(train%i);',i,i));
    eval(sprintf('p%i(p%i==0) = e;',i,i));
    eval(sprintf('p%i(p%i==1) = 1-e;',i,i));
end

%% Calculate lpx(p0)..lpx(p9)
for d=0:9
    for i=1:500
        logP = 'lpxp%i(%i,:) = train%i(%i,:)*log(p%i)''+(1-train%i(%i,:))*log(1-p%i)'';';
        eval(sprintf(logP,d,i,d,i,d,d,i,d));
    end
end

%% Plot
figure
for i=0:9
    eval(sprintf('image_%i = train%i''*lpxp%i;',i,i,i));
    eval(sprintf('imageToDisp = reshape(image_%i,28,28)'';',i));
    subplot(5,2,i+1);
    title(sprintf('digit %i',i));
    imagesc(imageToDisp); colorbar
end

%% Part 3
for d=0:9
    for i=1:500
        eval(sprintf('curTestClass = test%i;',d));
        tst0 = curTestClass(i,:) * log(p0)' + (1 - curTestClass(i,:)) * log(1 - p0)';
        tst1 = curTestClass(i,:) * log(p1)' + (1 - curTestClass(i,:)) * log(1 - p1)';
        tst2 = curTestClass(i,:) * log(p2)' + (1 - curTestClass(i,:)) * log(1 - p2)';
        tst3 = curTestClass(i,:) * log(p3)' + (1 - curTestClass(i,:)) * log(1 - p3)';
        tst4 = curTestClass(i,:) * log(p4)' + (1 - curTestClass(i,:)) * log(1 - p4)';
        tst5 = curTestClass(i,:) * log(p5)' + (1 - curTestClass(i,:)) * log(1 - p5)';
        tst6 = curTestClass(i,:) * log(p6)' + (1 - curTestClass(i,:)) * log(1 - p6)';
        tst7 = curTestClass(i,:) * log(p7)' + (1 - curTestClass(i,:)) * log(1 - p7)';
        tst8 = curTestClass(i,:) * log(p8)' + (1 - curTestClass(i,:)) * log(1 - p8)';
        tst9 = curTestClass(i,:) * log(p9)' + (1 - curTestClass(i,:)) * log(1 - p9)';
        eval(sprintf('ltst%i(:,%i) = [tst0 tst1 tst2 tst3 tst4 tst5 tst6 tst7 tst8 tst9];',d,i));
    end
    eval(sprintf('index = max(ltst%i);',d));
    index = repmat(index,[10],[1]); %repeat row 10 times
    eval(sprintf('[x%i,y%i]= find(ltst%i==index);',d,d,d));
    %x=x-1 for better corespondance to digits
    eval(sprintf('x%i = x%i - 1;',d,d));
end

%% ------------------------------ACCURACY------------------------------

for d=0:9
%size of x{digit} where x{digit}=={digit} divide by total size
eval(sprintf('accuracy%i = size(x%i(x%i==%i),1) / size(x%i,1);',d,d,d,d,d));
end
accuracyMatrix = [  accuracy0; accuracy1; accuracy2; accuracy3; ...
                    accuracy4; accuracy5; accuracy6; accuracy7; ...
                    accuracy8; accuracy9];

%% -------------------------CONFUSION MATRICIES-------------------------

for d=0:9
eval(sprintf('curX = x%i;',d));
eval(sprintf('len = size(curX,1);'));
eval(sprintf(['confMat%i = [size(curX(curX==0),1)/len; '...
    'size(curX(curX==1),1)/len; size(curX(curX==2),1)/len; size(curX(curX==3),1)/len; '...
    'size(curX(curX==4),1)/len; size(curX(curX==5),1)/len; size(curX(curX==6),1)/len; '...
    'size(curX(curX==7),1)/len; size(curX(curX==8),1)/len; size(curX(curX==9),1)/len;];'],d));
end

confusionMatrix = [ confMat0 confMat1 confMat2 confMat3 ...
                    confMat4 confMat5 confMat6 confMat7 ...
                    confMat8 confMat9];
               
%% Display the matricies
f = figure;
uit = uitable(f, 'Data', accuracyMatrix);
uit.RowName={'digit 0'; 'digit 1'; 'digit 2'; 'digit 3'; 'digit 4'; ...
            'digit 5'; 'digit 6'; 'digit 7'; 'digit 8'; 'digit 9'};
uit.ColumnName={'Accuracy'; };
uit.Position = [50 50 uit.Extent(3) uit.Extent(4)];

f = figure;
uit = uitable(f, 'Data', confusionMatrix);
uit.RowName={'digit 0'; 'digit 1'; 'digit 2'; 'digit 3'; 'digit 4'; ...
            'digit 5'; 'digit 6'; 'digit 7'; 'digit 8'; 'digit 9'};
uit.ColumnName={'digit 0'; 'digit 1'; 'digit 2'; 'digit 3'; 'digit 4'; ...
            'digit 5'; 'digit 6'; 'digit 7'; 'digit 8'; 'digit 9'};
uit.Position = [50 50 uit.Extent(3) uit.Extent(4)];
