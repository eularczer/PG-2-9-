% This function inputs a set in the process of generating and a waiting to
% be added point, and outputs if the point cosistent with the original set.
% Lset are set of all lines, RemainingSet contains all the possible points.
% m,n are parameters by definition when searching. k is the size of set.
% Remainingtm, Remainingtn are parameters for allowed remaining secant lines.
function[PossibleOrNot]=PossiblemnSetOld(IntermediateSet,RemainingSet,CheckingP)
% global point set and line set
global L;
% Set m,n,K, for some fixed number to test the function. 
% tm,tn are the needed numbers of line intersecting with the TypemnSet.
global m; global n; global K; global tm; global tn;


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



% This function count the number of points both in K and on line l.
% NewSet is the growing mnSet, and l is the tested line.
function[InterNumKL]=InterNumKL(NewSet,l)
lMat=cell2mat(l');
InterNumKL=0;
for i=1:size(NewSet,1)
    if ismember(NewSet(i,:),lMat,'rows') InterNumKL=InterNumKL+1; end
end