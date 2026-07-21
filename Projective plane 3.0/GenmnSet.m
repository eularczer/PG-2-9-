%% GenmnSet generate all type (m,n) sets recursively adding extra points.
function[AllTypemnSet]=GenmnSet()
    % Configurations.
    global P; global NumP; global m; global n; global q; 
    % AllTypemnSet is to collect checked (m,n) set from the recursive function.
    global AllTypemnSet;
    AllTypemnSet={};
 

    %% Recursively discuss whether every point in type(m,n) set. 
    % RemainingSets are the points can be added to the type(m,n) set, the points 
    % not in this set is either excluded or in the Intermediate set. 
    % IntermediateSet is the generating type(m,n) set in process.
    % SearchedLIndex is a n*2 matrix, to record the lines have been searched and line intersections.
    IntermediateSet=[]; RemainingSet=P; SearchedLIndex=[];
    
    % Directly set some points in RemainingSet from a line, and remove others in the line. 
    [IntermediateSet,RemainingSet,SearchedLIndex]=RoughlyNoAutomorphism([],P,[]);

    % Search it by adding the points one-by-one recursively.
    ElementwiseGen(IntermediateSet,RemainingSet,SearchedLIndex);
end


%% Recursively add points and tree-like search it.
function ElementwiseGen(IntermediateSet,RemainingSet,SearchedLIndex)
    % Configurations. AllTypemnSet is a cell which makes the code readable.
    global AllTypemnSet; global K; 

    % If the IntermediateSet has size larger than K, then it should be dropped.
    if size(IntermediateSet,1)>K     
    % If the set is of size K, then check whether it is of type (m,n).
    elseif size(IntermediateSet,1)==K
        [mnSetOrNot,LIntersection]=CheckmnSet(IntermediateSet,SearchedLIndex);
        if mnSetOrNot
            % The last column of AllTypemnSet is the intersection number LIntersection.
            AllTypemnSet=[AllTypemnSet;[mat2cell(IntermediateSet,ones(1,size(IntermediateSet,1)),size(IntermediateSet,2))',LIntersection]];        
        end
    elseif size(IntermediateSet,1)<K
        % If the RemainingSet is not possible to fill the IntermediateSet to
        % size K, then finish this search branch.
        if all(size(IntermediateSet,1)+size(RemainingSet,1)>=K) && all(~isempty(RemainingSet))  
            % ChasingSetIndex is to contain the added point index in RemainingSet.
            % ExcludedPIndex is to record the removed points from RemainingSet,
            % which can be larger than ChasingSetIndex.
            % TrivialorNot signs whether there is acceleration method.
            [TrivialorNot,ChasingSetIndex,ExcludedPIndex,SearchedLIndex]=ChasingmnSet(IntermediateSet,RemainingSet,SearchedLIndex);
            % If the IntermediateSet is possible, then we proceed, else stop it.
            if ~isempty(ChasingSetIndex)
                % Fork the ChasingSet branch.
                for i=1:size(ChasingSetIndex,1)
                    ChasingSet=RemainingSet(ChasingSetIndex(i,:),:);
                    % TempRemainingSet is to remove impossible points.
                    TempRemainingSet=RemainingSet;
                    TempRemainingSet(ExcludedPIndex(i,:),:)=[];
                    ElementwiseGen([IntermediateSet;ChasingSet],TempRemainingSet,SearchedLIndex);                 
                end
                % If the searching is trivial, then fork a branch to search set without RemainSet[1], 
                % but some points should also be exlucded.
                if TrivialorNot==1
                    TempRemainingSet=RemainingSet; TempRemainingSet(ExcludedPIndex(i,:),:)=[];
                    ElementwiseGen([IntermediateSet],TempRemainingSet,SearchedLIndex); 
                end
            end
        end
    end
end








