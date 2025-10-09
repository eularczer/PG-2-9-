% This function inputs an IntermediateSet during generating a TypemnSet and
% the remaining points and excluded points, and outputs if the set is consistent and 
% if it can be generated using "chasing consequence" method.
% RemainingSet contains all the possible points, and ExcludedSet contains
% all the points have been excluded.
function[Consistent,ChasingSet]=PossiblemnSet(IntermediateSet,RemainingSet,ExcludedSet)
% We need to use all lines to test the IntermediateSet.
global L;
% Set m,n,K, for some fixed number to test the function. 
% tm,tn are the needed numbers of line intersecting with the TypemnSet.
global m; global n; global K; global tm; global tn;

ChasingSet=[];
% We test all the lines in L for the NewSet one by one.
for i=1:size(L,1)
    % If the set K intersects some line l with more than n(>m) elements,
    % then terminate this process.
    if InterNumKL(IntermediateSet,L(i,:))>n || length(IntermediateSet)>K
        Consistent=0;
        return;
    end
end

% If all lines fit the set K appropriately, then return possible.
Consistent=1;
return;



% This function count the number of points both in K and on line l.
% NewSet is the growing mnSet, and l is the tested line.
function[InterNumKL]=InterNumKL(NewSet,l)
lMat=cell2mat(l');
InterNumKL=0;
for i=1:size(NewSet,1)
    if ismember(NewSet(i,:),lMat,'rows') InterNumKL=InterNumKL+1; end
end