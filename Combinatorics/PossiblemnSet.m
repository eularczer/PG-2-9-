% This function inputs a set in the process of generating and a waiting to
% be added point, and outputs if the point cosistent with the original set.
% Lset are set of all lines, RemainingSet contains all the possible points.
% m,n are parameters by definition when searching. k is the size of set.
% Remainingtm, Remainingtn are parameters for allowed remaining secant lines.
function[PossibleOrNot]=PossiblemnSet(IntermediateSet,RemainingSet,CheckingP)
% global point set and line set
global L;
% Set m,n,k, for some fixed number to test the function.
m=1; n=3; K=3; 
Remainingtm=6; Remainingtn=1;
% If the IntermediateSet is full, and CheckingP is null, then check it.
if size(IntermediateSet,1)==K && isempty(CheckingP)
    PossibleOrNot=CheckmnSet(IntermediateSet);
    return;
end
% If the checking point is already in the IntermediateSet, then do nothing.
if isempty(IntermediateSet) PossibleOrNot=1; return; end
if ismember(CheckingP,IntermediateSet,'rows') 
    PossibleOrNot=1;
    return;
end
NewSet=[IntermediateSet;CheckingP];
% We test all the lines in LSet for the NewSet one by one.
for i=1:size(L,1)
    % If the set K intersects some line l with more than n(>m) elements,
    % then terminate this process.
    if InterNumKL(NewSet,L(i,:))>n || length(NewSet)>K
        PossibleOrNot=0;
        return;
    end
end
% If all lines fit the set K appropriately, then return possible.
PossibleOrNot=1;
return;

% This function checks whether the input set of points is a type(m,n) set
% for the ultimate set.
function[mnSetOrNot]=CheckmnSet(IntermediateSet)
% global point set and line set
global L;
for i=1:size(L,1)
    k=InterNumKL(IntermediateSet,L(i,:));
    if k~=1 && k~=3 mnSetOrNot=0; return; end
end
mnSetOrNot=1;

% This function count the number of points both in K and on line l.
% NewSet is the growing K, and l is the tested line.
function[InterNumKL]=InterNumKL(NewSet,l)
lMat=cell2mat(l');
InterNumKL=0;
for i=1:length(NewSet)
    if ismember(NewSet(i),lMat) InterNumKL=InterNumKL+1; end 
end