%% ChasingmnSet returned the ChasingSetIndex if some line can be chased, and if not it returns a single point index.
% IntermediateSet is the recursively generating TypemnSet.  
% RemainingSet contains the possible points could be added. 
% ExcludedPIndex returns index of points to be excluded.
% SearchedLIndex is a n*2 matrix, to record the lineIndex has been searched and intersections. 
% ChasingSetIndex is the critical returned set, which is always nonempty if
% the IntermediateSet can grow. 
% TrivialorNot means whether an acceleration chasing could be found. 
function[TrivialorNot,ChasingSetIndex,ExcludedPIndex,SearchedLIndex]=ChasingmnSet(IntermediateSet,RemainingSet,SearchedLIndex)
% The idea is to find feasible points add to IntermediateSet by the property of lines intersections with RemainingSet. 
% For example, a line l intersects the IntermediateSet in 2 points,  and intersects 
% RemainingSet in 1 point, then to find a type (1,3) set the only point in 
% the line must be added to the IntermediateSet. 
% Moreover, a line with less than m intersections with IntermediateSet should have m points.
    
    % Configurations.
    global L; global m; global n; global K; global tm; global tn; global D;
    % The ChasingSetIndex, ExcludedPIndex are usually changed simultaneously, 
    % but not always when some line is searched thoroughly.
    % When ChasingSetIndex is returned empty, it means the construction is no longer possible.
    % Every time ChasingSetIndex changes, the searching line process should
    % be stopped and returned, since the larger reconstructed IntermediateSet should be tested.
    ChasingSetIndex=[]; ExcludedPIndex=[]; 
    % TrivialorNot=1 if no acceleration method could be used.
    TrivialorNot=0;
    % LIIntermediateSet is to record the intersection number of line and Intermediate set.
    LIIntermediateSet=[]; LIRemainingSet=[]; 
        
    % If the points are not enough, then stop construction from these IntermediateSet and RemainingSet.
    if size(IntermediateSet,1)+size(RemainingSet,1)<K return; end
    
    % Test all the line intersections in PG(r,q) with the IntermediateSet one by one.
    for i=1:size(L,1)
        % If this line i is searched, then skip searching this line and record kI.
        SearchedOrNot=[];
        SearchedOrNot=find(ismember(SearchedLIndex(:,1),i),1); 
        if  ~isempty(SearchedOrNot)
            kI=SearchedLIndex(SearchedOrNot,2);
            LIIntermediateSet=[LIIntermediateSet,kI]; LIRemainingSet=[LIRemainingSet,0];        
            % if+continue has the same effect as if+else and put all the
            % below in the else clause.
            continue;
        end
        % kI is the intersection of line i and the IntermediateSet, kR is for RemainingSet.
        kI=InterNumKL(IntermediateSet,reshape(L(i,:,:),[],D)); 
        % kR is the intersections of this line L(i,:,:) and RemainingSet.
        % RowIdx is the index of points in the RemainingSet and the line.
        [kR,RowIndex]=InterIndexKL(RemainingSet,reshape(L(i,:,:),[],D));

        % Logically discuss kI>n, kI==n, m<kI<n, kI==m, kI<m.
        % If intermediateSet and the line l intersects in more than n points, 
        % then stop construction from these IntermediateSet and RemainingSet. 
        if kI>n
            return;
        % If the line just has n intersections, then drop all points in this line.
        % But not terminate the searching lines, since ChasingSetIndex can be not empty.
        elseif kI==n
            SearchedLIndex=[SearchedLIndex;[i,n]];
            if kR~=0                
                ExcludedPIndex=[ExcludedPIndex,RowIndex];
            end
        % If this line intersects IntermediateSet in m<kI<n. Try chasing consequence. 
        elseif kI>m && kI<n
            % If the points is not enough to form a m-line, then stop construction from these IntermediateSet and RemainingSet.
            if kI+kR<n return;
            % This is the most classical chasing consequence method, which forks a shorter search tree.
            elseif kI+kR==n
                % Record ChasingSetIndex and this line is searched thoroughly.
                ChasingSetIndex=RowIndex; ExcludedPIndex=[ExcludedPIndex,RowIndex];
                SearchedLIndex=[SearchedLIndex;[i,n]];
                % return is needed to form a larger IntermediateSet and try possibility.
                return;
            % If kI+kR>n, then return a all the possible chasing indexes. It forks a bushier search tree.
            % For example, this line need 1 more point to achieve n intersection,
            % but {1,3} are both possible, then return [1;3]. 
            % This non-classical chasing may decrease the speed, since increase CheckmnSet calls. 
            % So it needs a balance. Never chasing all in large order plane.
            elseif kI+kR-n==1
                % ChasingSetIndex is a multirow matrix, and TempExcludedPIndex is to record the ExcludedPIndex.
                ChasingSetIndex=nchoosek(RowIndex,n-kI); TempExcludedPIndex=ExcludedPIndex; ExcludedPIndex=[];
                for j=1:size(ChasingSetIndex,1)
                    ExcludedPIndex(j,:)=[TempExcludedPIndex,ChasingSetIndex(j,:)];
                end
                SearchedLIndex=[SearchedLIndex;[i,n]];
                return; 
            end   
        % If kI==m, then if not enough points for n-line, then drop the other points in it.
        elseif kI==m
            % If this line can never be an n-line, then drop the other points.
            if kI+kR<n 
                SearchedLIndex=[SearchedLIndex;[i,m]];
                if kR~=0 
                    ExcludedPIndex=[ExcludedPIndex,RowIndex]; 
                end
            end
        % If kI<m, little thing can be done. 
        elseif kI<m           
            % If the line can never be an n-line, then try chasing.
            if kI+kR==m
                ChasingSetIndex=RowIndex; ExcludedPIndex=[ExcludedPIndex,RowIndex];
                SearchedLIndex=[SearchedLIndex;[i,m]];
                return;
            % When the line is not so many, then non-classical chasing can also be used.
            % if kI+kR-1==m ...            
            end
        end          
        % If this line i is neither terminated by inconsistency nor by chasing
        % in advance, then record the intersection number of it.
        LIIntermediateSet=[LIIntermediateSet,kI]; LIRemainingSet=[LIRemainingSet,kR];
    end

    % rhom, rhon, sigmam, sigman, tm, tn are not used.    
    % This if clause works when LIIntermediateSet has a large size. Since tm, tn can
    % reflect the global property.
    % If there are too many some type of intersection lines, then stop construction from these IntermediateSet and RemainingSet. 
    if sum(LIIntermediateSet>m)>tn 
        ChasingSetIndex=[];
        return; 
    end

    % If the IntermediateSet is possible, with no acceleration method, then just add 1 point.
    ChasingSetIndex=[1]; ExcludedPIndex=[ExcludedPIndex,[1]]; TrivialorNot=1;
end


%% Count the intersecting points of TestSet and line l, returning the index in TestSet.
% The parameter InterNumL return the number of intersection, and RowIdx
% return the index of the points in NewSet and the line l.
function[InterNumL,RowIdx]=InterIndexKL(TestSet,l)
    % The function ismember is pretty powerful, so just compare two matrix.
    IndexVector=ismember(TestSet,l,'rows');
    InterNumL=sum(IndexVector);
    RowIdx=find(IndexVector)';
end


%% Count the intersecting points both in NewSet and on line l.
function InterNumL=InterNumKL(NewSet,l)
    % Use ismember to compare two matrices.
    IndexVector=ismember(NewSet,l,'rows');
    InterNumL=sum(IndexVector);
end