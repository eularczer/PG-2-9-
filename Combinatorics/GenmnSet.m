% This function is to generate all type (m,n) sets recursively
function[AllTypemnSetRet]=GenmnSet()
% AllTypemnSet is used as a global variable to receive the all subsets output in
% the recursive function.
global AllTypemnSet;
AllTypemnSet={};
% Then we recursively discuss whether every point in type(m,n) set.
global P; 
ElementwiseGen([],P);
AllTypemnSetRet=AllTypemnSet;


% RemainingSets are the points to be added to the type(m,n) set, and
% IntermediateSet is the generating type(m,n) set in process.
function ElementwiseGen(IntermediateSet,RemainingSet)
global AllTypemnSet; 
% m,n are parameters by definition when searching. k is the size of set
% calculated by the math formula.
K=3;
if size(IntermediateSet,1)==K
    % If there the set K is constructed well, then check if it is of type (m,n).
    if PossiblemnSet(IntermediateSet,RemainingSet,[])
        AllTypemnSet=[AllTypemnSet;{IntermediateSet}];
    end
% If the RemainingSet is not possible to fill the IntermediateSet to k many
% elements, then directly ignore it. The forked recursive function would go
% die by himself.
elseif size(IntermediateSet,1)+size(RemainingSet,1)>=K
    % If the set still needs to be constructed, then proceed.
    % If it is possible to add a point to the IntermediateSet, then we add.
    % And to remove the point from remaining set.
    if PossiblemnSet(IntermediateSet,RemainingSet,RemainingSet(1,:))
        % Even if this point is suitable, we still need to explore other
        % possibilities such that this point is not in type(m,n) set. So we
        % fork the generating function.
        ElementwiseGen(IntermediateSet,RemainingSet(2:size(RemainingSet),:));
        ElementwiseGen([IntermediateSet;RemainingSet(1,:)],RemainingSet(2:size(RemainingSet),:));        
    % If the point is inconsistent with the IntermediateSet of type(m,n),
    % then omit this point and search nexe one.
    else
        RemainingSet=RemainingSet(2:size(RemainingSet),:);
        ElementwiseGen(IntermediateSet,RemainingSet);
    end
end









