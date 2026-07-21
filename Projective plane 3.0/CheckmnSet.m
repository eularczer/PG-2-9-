%% CheckmnSet checks whether the input IntermediateSet is a type(m,n) set.
% mnSetOrNot signs whether IntermediateSet is (m,n) set. LIntersection records the line intersections.
% SearchedIndex records the lines throughly searched, which can avoid searching repeatedly.
function[mnSetOrNot,LIntersection]=CheckmnSet(IntermediateSet,SearchedLIndex)
    % global point set and line set, and other parameters.
    global L; global m; global n; global D;

    % LIntersection is the set to record the number of intersections of the
    % lines with the type(m,n) set.
    LIntersection=[];
    % mnSetOrNot returns yes unless some intersection number is k.
    mnSetOrNot=1;
    for i=1:size(L,1)
        % If the line has been searched throughly, then skip the intersection counting step.
        SearchedOrNot=find(ismember(SearchedLIndex(:,1),i),1);
        if  ~isempty(SearchedOrNot)
            kI=SearchedLIndex(SearchedOrNot,2);
            LIntersection=[LIntersection,kI];
            continue;
        end
        % Otherwise this line has not been searched, then search it.
        k=InterNumKL(IntermediateSet,reshape(L(i,:,:),[],D));
        % Moreover we need to record the intersections of lines and IntermediateSet,
        % since when drawing BiGraph between lines and points we need it.
        if k==m
            LIntersection=[LIntersection,m];
        elseif k==n 
            LIntersection=[LIntersection,n];
        else 
            LIntersection=[LIntersection,k];
            mnSetOrNot=0;
            return; % Do not do the remaining wasting check.
        end
    end
    % the set which intersects all lines with n points should be dropped, since
    % intersection number need both m and n intersection number occurs.
    % if sum(ismember(LIntersection,m))~=tm mnSetOrNot=0; end
    % if sum(ismember(LIntersection,n))~=tn mnSetOrNot=0; end
end


% This function count the number of points both in point set and on line l.
% The parameter InterNumL return the number of intersection.
function InterNumL=InterNumKL(NewSet,l)
    % The function ismember is pretty powerful, so just compare two matrix.
    IndexVector=ismember(NewSet,l,'rows');
    InterNumL=sum(IndexVector);
end