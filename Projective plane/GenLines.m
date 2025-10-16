% Generate all the lines in the projective plane. 
function GenLines()
% Pass some global parameters.
global P; global L; global D; global p; global h; global NumP;

% By theory we know the number of lines is the same as NumVer, and the points 
% on a line is q+1. r is the global row index to fill in the line set.
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
        % Here we cannot directly set SecondPoint(RowIdx,:)=[], since the
        % elements in the RowIdx is not the row of SecondPoint but the
        % row index of P which is the elements in SecondPoint.
        for k=1:length(RowIdx)
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
    end
    % In the process we also need to remove repeated generating lines
    % during the generating even after removing them from the former base point.
    while ~isempty(SecondPoint)
        % Linear span the line and find the other points on the line.
        RowIdx = find(ismember(P,LinearSpan(P(i,:),P(SecondPoint(1),:)), 'rows'));
        % Adding the other points to the line record via transforming the index into points.
        L{r,1}=P(i,:); L{r,2}=P(SecondPoint(1),:); 
        for k=1:length(RowIdx)
            L{r,2+k}=P(RowIdx(k),:);
        end        
        % Removing the repeated generated line in next turns.
        for k=1:length(RowIdx)
            % This SecondPoint==RowIdx(k) returns the index of repeated
            % index RowIdx(k) in SecondPoint. Since maybe some index in
            % RowIdx(k) which needs to be removed is already removed.
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
        SecondPoint(1)=[];
        r=r+1;
    end 
end