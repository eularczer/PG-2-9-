% This function is to generate all type (m,n) sets recursively.
% No parameters are needed to input since all we need is global variable P,L.
function[AllTypemnSet]=GenmnSetOld()
% AllTypemnSet is used as a global variable to receive the all subsets output in
% the recursive function.
global AllTypemnSet;
AllTypemnSet={};
% Then we recursively discuss whether every point in type(m,n) set. The set
% size is determined (calculated by (m,n)) by K.
global P; global NumP;

% This is a bruteforce method to generate TypemnSet, and it returns all the
% possible TypemnSet in the projective plane. But a lot of them would be
% removed by no-automorphism. To avoid the waste of calculation, we can 
% directly set some point e in the TypemnSet and only search the case which has e.  
% ElementwiseGen([],P);

% We roughly remove automorphism by setting the first sevral points in TypemnSet.
% We directly set a point e, and from this point to construct the TypemnSet.
% The leader orbit ci(1<=i<=m) are picked from the line l1 which is also
% set by us artificially. (ci is not implemented now, since it depends on the value of m and n.)
% See Sets of Type (m,n) in the affine and projective planes of order nine,
% Penttila, Royle, 1995, Section 3, paragraph 3.
e=P(1,:);
% Directly setting a point e in the TypemnSet. It can reduce about half the
% time which needs in brute force.
ElementwiseGen(e,P(2:NumP,:));




% RemainingSets are the points to be added to the type(m,n) set, and
% IntermediateSet is the generating type(m,n) set in process.
% By the paper, we also 
function ElementwiseGen(IntermediateSet,RemainingSet)
global AllTypemnSet; global K;
% m,n are parameters by definition when searching. k is the size of set
% calculated by the math formula.
if size(IntermediateSet,1)==K
    % If there the set K is constructed well, then check if it is of type (m,n).
    [mnSetOrNot,LIntersection]=CheckmnSet(IntermediateSet);
    if mnSetOrNot
        % transform the matrix to the cell. More important, at the last
        % column to add a line intersection number for this type (m,n) set.
        AllTypemnSet=[AllTypemnSet;[mat2cell(IntermediateSet,ones(1,size(IntermediateSet,1)),size(IntermediateSet,2))',LIntersection]];
        % In most general case we do not need the LIntersection number.
        %AllTypemnSet=[AllTypemnSet;mat2cell(IntermediateSet,ones(1,size(IntermediateSet,1)),size(IntermediateSet,2))'];
    end
% If the RemainingSet is not possible to fill the IntermediateSet to k many
% elements, then directly ignore it. The forked recursive function would go 
% die by himself.
elseif size(IntermediateSet,1)+size(RemainingSet,1)>=K
    % If the set still needs to be constructed, then proceed.
    % If it is possible to add a point to the IntermediateSet, then we add.
    % And to remove the point from remaining set.
    if PossiblemnSetOldV1(IntermediateSet,RemainingSet,RemainingSet(1,:))
        % Even if this point is suitable, we still need to explore other
        % possibilities such that this point is not in type(m,n) set. So we
        % fork the generating function.
        ElementwiseGen(IntermediateSet,RemainingSet(2:size(RemainingSet,1),:));
        ElementwiseGen([IntermediateSet;RemainingSet(1,:)],RemainingSet(2:size(RemainingSet,1),:));        
    % If the point is inconsistent with the IntermediateSet of type(m,n),
    % then omit this point and search nexe one.
    else
        RemainingSet=RemainingSet(2:size(RemainingSet,1),:);
        ElementwiseGen(IntermediateSet,RemainingSet);
    end
end