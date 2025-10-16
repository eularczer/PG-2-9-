% This function inputs an IntermediateSet during generating a TypemnSet and
% the remaining points and excluded points. 
% RemainingSet contains all the possible points.
% Use "chasing consequence" method by testing kI+kR==n, which includes
% adding all other points both in RemainingSet and line, and also exclude
% all other points both in RemainingSet and line if kI==n. 
% So ExcludingIndex returns index of all the points need to be excluded if kI==n.
function[Consistent,ChasingSetIndex,ExcludingIndex]=PossiblemnSet(IntermediateSet,RemainingSet)
% We need to use all lines to test the IntermediateSet.
global L;
% Set m,n,K, for some fixed number to test the function. 
% tm,tn are the needed numbers of line intersecting with the TypemnSet.
global m; global n; global K; global tm; global tn;
% Initialize the ChasingSet, Consistent and ExcludingIndex.
Consistent=1; ChasingSetIndex=[]; ExcludingIndex=[];
% Use LIIntermediateSet to record the intersection number of line and Intermediate set,
LIIntermediateSet=[]; LIRemainingSet=[]; 

% If IntermediateSet and RemainingSet cannot attach K, then drop it.
if size(IntermediateSet,1)+size(RemainingSet,1)<K Consistent=0; return; end

% Test all the lines in L for the NewSet one by one.
for i=1:size(L,1)
    % If the IntermediateSet intersects some line l with more than n(>m) elements,
    % then terminate this process.
    [kI,]=InterNumKL(IntermediateSet,L(i,:));
    % We need to record the intersections of lines and IntermediateSet,
    % since we need to chase the consequence. The cost here can be overlooked.
    if kI>n
        Consistent=0; return;
    else 
        LIIntermediateSet=[LIIntermediateSet,kI];
        % kR is the intersection number of line L(i,:) and RemainingSet.
        % RowIdx is the index of points in the remaining set and the line, 
        % which means the index is according to the RemainingSet.
        [kR,RowIndex]=InterNumKL(RemainingSet,L(i,:));
        % If the points in the remaining set adding the points in the
        % intermediate set for line L(i,:) still cannot attain m, then this
        % set cannot be a type (m,n) set.
        if kR+kI<m Consistent=0; return;
        % If intermediate set and line intersect more than n points, then this cannot be a type (m,n) set.
        elseif kI>n Consistent=0; return;
        % If the line and intermediate set intersect more than m points,
        % and less than n. Then discuss the remaining set and use chasing consequence method. 
        elseif kI>m && kI<n
            % If line and intermediate set intersect more than m points, then drop it.
            if kI+kR<n Consistent=0; return;
            % Chasing Consequence!
            elseif kI+kR==n
                ChasingSetIndex=RowIndex; return;
                %ChasingSet=RemainingSet(RowIndex,:); return;
            end
        % If KI==n, then drop all the other points on the line which are
        % in RemainingSet. 
        elseif kI==n && kR~=0
            ExcludingIndex=RowIndex; return;
        end   
    end
end
% In fact we can use more restriction like rhom, rhon, sigmam, sigman, tm,
% tn to search faster. But they are macro property which needs to be first
% recorded then used. In fact they must be used, or Checkmn is too heavy burden.

% tm and tn must be used, or the IntermediateSet would be too many.
% This works efficient when LIIntermediateSet has a large size. Since tm,
% tn can reflect the global property.
if sum(LIIntermediateSet>m)>tn Consistent=0; return; end



% This function count the number of points both in point set and on line l.
% The parameter InterNumL return the number of intersection, and RowIdx
% return the index of the points in NewSet and the line l.
function[InterNumL,RowIdx]=InterNumKL(TestSet,l)
% Initialize the returned value.
RowIdx=[]; InterNumL=0;
lMat=cell2mat(l');
% The function ismember is pretty powerful, so just compare two matrix is enough.
IndexVector=ismember(TestSet,lMat,'rows');
InterNumL=sum(IndexVector);
RowIdx=find(IndexVector);