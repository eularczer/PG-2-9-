clear;

% Construct all the points on PG(2,2). All the points in the planes are 1
% row and 3 column vectors in the linear space.
global P; global L;
% Set D=3 as the projective plane. Subsequent research may have D=4.
% Set p as the character of a finite field, and h as the power. 
% NumP, and NumL are the points and lines in a projective space, and in
% projective plane, they are the same. (In general projective planes, to
% calculate NumL we need to calculate number of PGL matrix.)
global D; global p; global h; global NumP; global NumL;
D=3; p=2; h=1; NumP=((p^h)^D-1)/(p^h-1); NumL=NumP;

% Generate the points P of projective plane. 
P=zeros(NumP,D); NumVer=size(P,1);
for i=1:NumVer
    % change the decimal to binary or others. TempFormat are the different
    % format of the generated point.
    TempFormat=dec2base(i,2); TempFormat=sprintf('%03s', TempFormat);
    for j=1:D
        P(i,j)=str2num(TempFormat(j));
    end
end

% Find all the lines in the projective plane. By theory we know the number
% of lines is the same as NumVer, and the points on a line is q+1. 
L_NumVer=p^h+1; L={}; r=1; % r is the global row index to fill in the line set.
for i=1:NumVer
    % i is the base point, and j is the directional point. We need to
    % refine directional point to remove repeated generating lines.
    SecondPoint=[i+1:NumVer];
    for j=1:i
        RowIdx=find(ismember(P, LinearSpan(P(i,:),P(j,:)), 'rows'));
        for k=1:length(RowIdx)
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
    end
    % In the process we also need to remove repeated generating lines
    % during the generating even after removing them from the former base point.
    while ~length(SecondPoint)==0
        % Linear span the line and find the other points on the line.
        RowIdx = find(ismember(P, LinearSpan(P(i,:),P(SecondPoint(1),:)), 'rows'));
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
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
    end 
end

% Set m,n,k, for some fixed number to test the function.
global m; global n; global K; m=1; n=3; K=3; 

% Find the intersection set type (m,n).
%AllTypemnSet=GenmnSet();
%AllTypemnSet=GenAll3pointsSet();

% Transform the hypergraph of (P,L) to bipartite graph and show it. 
%BiGraph=HypertoBiGraph();

% Remove automorphisms from AllTypemnSet.
%TypemnSet=NoAutoTypemnSet(BiGraph,AllTypemnSet);


