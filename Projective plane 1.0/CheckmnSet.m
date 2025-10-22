% This function checks whether the input set of points is a type(m,n) set
% for the ultimate set.
function[mnSetOrNot,LIntersection]=CheckmnSet(IntermediateSet)
% global point set and line set, and other parameters.
global L; global m; global n;
% global intersection number tm, tn must be used, or all the lines can
% intersect with TypemnSet with n points. Like the whole set in PG(2,3).
global tm; global tn;

% LIntersection is the set to record the number of intersections of the
% lines with the type(m,n) set.
LIntersection=[];
% mnSetOrNot returns yes unless some intersection number is k.
mnSetOrNot=1;
for i=1:size(L,1)
    [k,]=InterNumKL(IntermediateSet,L(i,:));
    % Moreover we need to record the intersections of lines and IntermediateSet,
    % since when drawing BiGraph between lines and points we need it.
    if k==m
        LIntersection=[LIntersection,m];
    elseif k==n 
        LIntersection=[LIntersection,n];
    else 
        LIntersection=[LIntersection,k];
        mnSetOrNot=0;
    end
end
% the set which intersects all lines with n points should be dropped, since
% intersection number need both m and n intersection number occurs.
% if sum(ismember(LIntersection,m))~=tm mnSetOrNot=0; end
% if sum(ismember(LIntersection,n))~=tn mnSetOrNot=0; end
1;


% This function count the number of points both in point set and on line l.
% The parameter InterNumL return the number of intersection, and RowIdx
% return the index of the points in NewSet and the line l.
function[InterNumL,RowIdx]=InterNumKL(NewSet,l)
% Initialize the returned value.
RowIdx=[]; InterNumL=0;
lMat=cell2mat(l');
% The function ismember is pretty powerful, so just compare two matrix is enough.
IndexVector=ismember(NewSet,lMat,'rows');
InterNumL=sum(IndexVector);
RowIdx=find(IndexVector);