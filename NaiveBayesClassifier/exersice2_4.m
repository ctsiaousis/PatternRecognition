clear all; close all; clc;
load('digits');
A = reshape(train3(43, :), 28, 28)';
imagesc(A); colorbar

%% Calculate p0..p9
% TODO: change the eval to ceil and ceilfun
e = 0.0000001;
for i = 0:9
    eval(sprintf('n = size(train%i,1);',i));
    eval(sprintf('p%i = (1/n)*sum(train%i);',i,i));
    eval(sprintf('p%i(p%i==0) = e;',i,i));
    eval(sprintf('p%i(p%i==1) = 1-e;',i,i));
end

for d=0:9
    for i=1:500
        logP = 'lpxp%i(%i,:) = train%i(%i,:)*log(p%i)''+(1-train%i(%i,:))*log(1-p%i)'';';
        eval(sprintf(logP,d,i,d,i,d,d,i,d));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
for i=0:9
    eval(sprintf('image_%i = train%i''*lpxp%i;',i,i,i));
    eval(sprintf('imageToDisp = reshape(image_%i,28,28)'';',i));
    subplot(5,2,i+1);
    title(sprintf('digit %i',i));
    imagesc(imageToDisp); colorbar
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
end

for d=0:9
    eval(sprintf('index = (max(ltst%i));',d));
    index = repmat(index,[10],[1]); %repeat row 10 times
    eval(sprintf('[x%i,y%i]= find(ltst%i==index);',d,d,d));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for d=0:9
eval(sprintf('accuracy%i = sum(x%i(x%i==1)) / length(x%i)',d,d,d,d));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500
    if x0(i)==2
        ones = ones+1;
    end
    if x0(i)==3
        twos = twos+1;
    end
    if x0(i)==4
        threes = threes+1;
    end
    if x0(i)==5
        fours = fours+1;
    end
    if x0(i)==6
        fives = fives+1;
    end
    if x0(i)==7
        six = six+1;
    end
    if x0(i)==8
        sevens = sevens+1;
    end
    if x0(i)==9
        eights = eights+1;
    end
    if x0(i)==10
        nines = nines+1;
    end
end

confusion_matrix_zero = [ones,twos,threes,fours,fives,six,sevens,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500
    if x1(i)==3
        twos = twos+1;
    end
    if x1(i)==1
        zeros = zeros+1;
    end
    if x1(i)==4
        threes = threes+1;
    end
    if x1(i)==5
        fours = fours+1;
    end
    if x1(i)==6
        fives = fives+1;
    end
    if x1(i)==7
        six = six+1;
    end
    if x1(i)==8
        sevens = sevens+1;
    end
    if x1(i)==9
        eights = eights+1;
    end
    if x1(i)==10
        nines = nines+1;
    end
end

confusion_matrix_one = [zeros,twos,threes,fours,fives,six,sevens,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x2(i)==1
        zeros = zeros+1;
    end
    if x2(i)==2
        ones = ones+1;
    end
    if x2(i)==4
        threes = threes+1;
    end
    if x2(i)==5
        fours = fours+1;
    end
    if x2(i)==6
        fives = fives+1;
    end
    if x2(i)==7
        six = six+1;
    end
    if x2(i)==8
        sevens = sevens+1;
    end
    if x2(i)==9
        eights = eights+1;
    end
    if x2(i)==10
        nines = nines+1;
    end
end

confusion_matrix_two = [zeros,ones,threes,fours,fives,six,sevens,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x3(i)==1
        zeros = zeros+1;
    end
    if x3(i)==2
        ones = ones+1;
    end
    if x3(i)==3
        twos = twos+1;
    end
    if x3(i)==5
        fours = fours+1;
    end
    if x3(i)==6
        fives = fives+1;
    end
    if x3(i)==7
        six = six+1;
    end
    if x3(i)==8
        sevens = sevens+1;
    end
    if x3(i)==9
        eights = eights+1;
    end
    if x3(i)==10
        nines = nines+1;
    end
end

confusion_matrix_three = [zeros,ones,twos,fours,fives,six,sevens,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x4(i)==1
        zeros = zeros+1;
    end
    if x4(i)==2
        ones = ones+1;
    end
    if x4(i)==3
        twos = twos+1;
    end
    if x4(i)==4
        threes = threes+1;
    end
    if x4(i)==6
        fives = fives+1;
    end
    if x4(i)==7
        six = six+1;
    end
    if x4(i)==8
        sevens = sevens+1;
    end
    if x4(i)==9
        eights = eights+1;
    end
    if x4(i)==10
        nines = nines+1;
    end
end

confusion_matrix_four = [zeros,ones,twos,threes,fives,six,sevens,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x5(i)==1
        zeros = zeros+1;
    end
    if x5(i)==2
        ones = ones+1;
    end
    if x5(i)==3
        twos = twos+1;
    end
    if x5(i)==4
        threes = threes+1;
    end
    if x5(i)==5
        fours = fours+1;
    end
    if x5(i)==7
        six = six+1;
    end
    if x5(i)==8
        sevens = sevens+1;
    end
    if x5(i)==9
        eights = eights+1;
    end
    if x5(i)==10
        nines = nines+1;
    end
end

confusion_matrix_five = [zeros,ones,twos,threes,fours,six,sevens,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x6(i)==1
        zeros = zeros+1;
    end
    if x6(i)==2
        ones = ones+1;
    end
    if x6(i)==3
        twos = twos+1;
    end
    if x6(i)==4
        threes = threes+1;
    end
    if x6(i)==5
        fours = fours+1;
    end
    if x6(i)==6
        fives = fives+1;
    end
    if x6(i)==8
        sevens = sevens+1;
    end
    if x6(i)==9
        eights = eights+1;
    end
    if x6(i)==10
        nines = nines+1;
    end
end

confusion_matrix_six = [zeros,ones,twos,threes,fours,fives,sevens,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x7(i)==1
        zeros = zeros+1;
    end
    if x7(i)==2
        ones = ones+1;
    end
    if x7(i)==3
        twos = twos+1;
    end
    if x7(i)==4
        threes = threes+1;
    end
    if x7(i)==5
        fours = fours+1;
    end
    if x7(i)==6
        fives = fives+1;
    end
    if x7(i)==7
        six = six+1;
    end
    if x7(i)==9
        eights = eights+1;
    end
    if x7(i)==10
        nines = nines+1;
    end
end

confusion_matrix_seven = [zeros,ones,twos,threes,fours,fives,six,eights,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x8(i)==1
        zeros = zeros+1;
    end
    if x8(i)==2
        ones = ones+1;
    end
    if x8(i)==3
        twos = twos+1;
    end
    if x8(i)==4
        threes = threes+1;
    end
    if x8(i)==5
        fours = fours+1;
    end
    if x8(i)==6
        fives = fives+1;
    end
    if x8(i)==7
        six = six+1;
    end
    if x8(i)==8
        sevens = sevens+1;
    end
    if x8(i)==10
        nines = nines+1;
    end
end

confusion_matrix_eight = [zeros,ones,twos,threes,fours,fives,six,sevens,nines];

zeros = 0;
ones = 0;
twos = 0;
threes = 0;
fours = 0;
fives = 0;
six = 0;
sevens = 0;
eights = 0;
nines = 0;
for i=1:500

    if x9(i)==1
        zeros = zeros+1;
    end
    if x9(i)==2
        ones = ones+1;
    end
    if x9(i)==3
        twos = twos+1;
    end
    if x9(i)==4
        threes = threes+1;
    end
    if x9(i)==5
        fours = fours+1;
    end
    if x9(i)==6
        fives = fives+1;
    end
    if x9(i)==7
        six = six+1;
    end
    if x9(i)==8
        sevens = sevens+1;
    end
    if x9(i)==9
        eights = eights+1;
    end
end

confusion_matrix_nine = [zeros,ones,twos,threes,fours,fives,six,sevens,eights];
