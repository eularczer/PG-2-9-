% This function is to generate all type (m,n) sets recursively.
% No parameters are needed to input since all we need is global variable P,L.
function[AllTypemnSet]=GenmnSet()
% AllTypemnSet is used as a global variable to receive the all subsets output in
% the recursive function.
global AllTypemnSet;
AllTypemnSet={};
% Then we recursively discuss whether every point in type(m,n) set. The set
% size is determined (calculated by (m,n)) by K.
global P; global L; global NumP; global m; global n;

% We roughly remove automorphism by setting the first sevral points in TypemnSet.
% Directly set a point e in TypemnSet to remove automorphism is inefficient
% anymore, we fix points in one line at first stage.
% The leader orbit ci(1<=i<=m) are picked from the line l1 which is also
% set by us artificially. (ci is not implemented now, since it depends on the value of m and n.)
% Fork two branches to elementwisely generate the TypemnSet. One of the
% contains the first m points in line one L1 and directly drops the other
% points, and the second do the similar for first n points in L1.
RemainingSet=P;
IntermediateSet=cell2mat(L(1,[1:m])'); ExcludingIndex=find(ismember(P,cell2mat(L(1,:)'),'rows')); RemainingSet(ExcludingIndex',:)=[];
ElementwiseGen(IntermediateSet,RemainingSet);
IntermediateSet=cell2mat(L(1,[1:n])'); % The RemainingSet are the same as above.
ElementwiseGen(IntermediateSet,RemainingSet);



% RemainingSets are the points to be added to the type(m,n) set, and
% IntermediateSet is the generating type(m,n) set in process. 
function ElementwiseGen(IntermediateSet,RemainingSet)
% K is the size of TypemnSet in the final.
global AllTypemnSet; global K; 

% If the IntermediateSet has size larger than K, then it means the chasing
% consequence adding too many points, So we ignore it.
if size(IntermediateSet,1)>K

% If the set of size K has been constructed, then check if it is of type (m,n).
elseif size(IntermediateSet,1)==K
    [mnSetOrNot,LIntersection]=CheckmnSet(IntermediateSet);
    if mnSetOrNot
        % transform the matrix to the cell. More important, at the last
        % column to add a line intersection number for this type (m,n) set.
        AllTypemnSet=[AllTypemnSet;[mat2cell(IntermediateSet,ones(1,size(IntermediateSet,1)),size(IntermediateSet,2))',LIntersection]];
        % In most general case we do not need the LIntersection number.
        %AllTypemnSet=[AllTypemnSet;mat2cell(IntermediateSet,ones(1,size(IntermediateSet,1)),size(IntermediateSet,2))'];
    end
% If the RemainingSet is not possible to fill the IntermediateSet to k many
% elements, then directly let the recursive branch go die.
% If the set still needs to be constructed, then proceed.
elseif size(IntermediateSet,1)+size(RemainingSet,1)>=K && ~isempty(RemainingSet)
    % Evaluate the IntermediateSet and RemainingSet and ExcludedSet. Find
    % the unique adaptable set of points if possible. For example, in PG(2,4) 
    % a line l intersects the RemainingSet of 2 points, and ExcludedSet of
    % 2 point, then to find a type (1,3) set the only point in the line
    % must be added to the IntermediateSet. 
    % If unique adaptable set cannot be found, we just add 1 point from RemainingSet.
    % Since the paper call this method "chasing consequence", ChasingSet is
    % used to contain the returning set of index in RemainingSet.
    [Consistent,ChasingSetIndex,ExcludingIndex]=PossiblemnSet(IntermediateSet,RemainingSet);
    % If the IntermediateSet is consistent, then we proceed, else drop it.
    % Since the set is not tested after constructing in the preceding recursion.
    if Consistent
        % If the ChasingSet is empty, which means no chasing consequence
        % occur, then we fork the recursion to search.
        if isempty(ChasingSetIndex) && isempty(ExcludingIndex)
            % The forked recursive searches are the one containing next
            % point and the one not containing it.     
            ElementwiseGen([IntermediateSet;RemainingSet(1,:)],RemainingSet(2:size(RemainingSet,1),:));
            ElementwiseGen(IntermediateSet,RemainingSet(2:size(RemainingSet,1),:)); 
        % If the ChasingSet is not empty, then first add the ChasingSet to
        % the IntermediateSet, then remove the ChasingSet from RemainingSet,
        % then add it to the ExcludedSet.
        elseif ~isempty(ChasingSetIndex)
            %RowIndex=find(ismember(RemainingSet,ChasingSet,'rows'))';
            ChasingSet=RemainingSet(ChasingSetIndex,:);
            RemainingSet(ChasingSetIndex,:)=[];
            ElementwiseGen([IntermediateSet;ChasingSet],RemainingSet);
        % If the ExcludingIndex is not emoty, then it means for some l\in L
        % kI of l is reached n and so all the other points both on the line
        % and RemainingSet need to be removed from RemainingSet.
        elseif ~isempty(ExcludingIndex)
            RemainingSet(ExcludingIndex,:)=[];
            ElementwiseGen(IntermediateSet,RemainingSet);
        end
    % If the IntermediateSet is inconsistent after last construction, ignore it.
    else
        
    end
end









