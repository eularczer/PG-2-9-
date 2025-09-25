clear all; clearvars; 

% Construct all the points on PG(2,2). All the points in the planes are 1
% row and 3 column vectors in the linear space.
global P; global L;
% Set D=3 as the projective plane dimension using vectors. Subsequent research may have D=4.
% Set p as the character of a finite field, and h as the power. 
% NumP, and NumL are the points and lines in a projective space, and in
% projective plane, they are the same. (In general projective planes, to
% calculate NumL we need to calculate number of PGL matrix.)
global D; global p; global h; global NumP; global NumL;
D=3; p=2; h=2; NumP=((p^h)^D-1)/(p^h-1); NumL=NumP;

% Generate the points totalP of projective plane. Then we quotient the
% equivalent relation to get the final points set. NumP is the number of
% points after the quotient, but at the beginning weneed to construct more.
totalP=zeros((p^h)^D-1,D); 
for i=1:(p^h)^D-1
    % The generating uses module arithmetic in general.
    for j=1:D
        totalP(i,j)=floor(mod(i,(p^h)^(D+1-j))/(p^h)^(D-j));
    end
end
% Then we remove the equivalent points from totalP to get global points P.
% r is the global row index to fill in the points set.
r=1;
while ~isempty(totalP)
    % Every time after finding a equivalent points set, add one of them to P.
    % EquP is to contain them.
    EquP=LinearSpan(totalP(1,:),[]);
    P(r,:)=totalP(1,:); r=r+1;
    % Then we remove all the equivalent points in totalP. Attention for the
    % ismember function, the index of first slot EquP should be returned,
    % so the first inputs should be EquP. 
    RowIdx=find(ismember(totalP,EquP,'rows'))';
    totalP(RowIdx,:)=[];
end

% Find all the lines in the projective plane. By theory we know the number
% of lines is the same as NumVer, and the points on a line is q+1. 
% r is the global row index to fill in the line set.
L_NumVer=p^h+1; L={}; r=1; NumVer=NumP;
for i=1:NumVer
    % i is the base point, and j is the directional point. We need to
    % refine directional point to remove repeated generating lines.
    % SecondPoint contains the index of the points.
    SecondPoint=[i+1:NumVer];
    for j=1:i
        % RowIdx is a row vector all the time, so to avoid size(RowIdx,2)
        % returns 1 even when it is empty, we use length to control the loop.
        RowIdx=find(ismember(P,LinearSpan(P(i,:),P(j,:)),'rows'))';
        for k=1:length(RowIdx)
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
    end
    % In the process we also need to remove repeated generating lines
    % during the generating even after removing them from the former base point.
    while ~isempty(SecondPoint)
        % Linear span the line and find the other points on the line.
        RowIdx = find(ismember(P,LinearSpan(P(i,:),P(SecondPoint(1),:)), 'rows'));
        % Adding the other points to the line record via adding index.
        % Transfer the index to the matrix.
        L{r,1}=P(i,:); L{r,2}=P(SecondPoint(1),:); 
        for k=1:length(RowIdx)
            L{r,2+k}=P(RowIdx(k),:);
        end
        r=r+1;
        % Removing the repeated generated line in next turns.
        SecondPoint(1)=[];
        for k=1:length(RowIdx)
            % This SecondPoint==RowIdx(k) returns the index of repeated
            % index RowIdx(k) in SecondPoint. Since maybe some index in
            % RowIdx(k) which needs to be removed is already removed.
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
    end 
end

% Set m,n,k, for some fixed number to test the function.
global m; global n; global K; m=1; n=4; K=7; 

% Find the intersection set type (m,n).
AllTypemnSet=GenmnSet();
%AllTypemnSet=GenAll3pointsSet();

% Transform the hypergraph of (P,L) to bipartite graph and show it. 
BiGraph=HypertoBiGraph();

% Remove automorphisms from AllTypemnSet.
TypemnSet=NoAutoTypemnSet(BiGraph,AllTypemnSet);


