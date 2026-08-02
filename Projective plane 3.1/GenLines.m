% Generate all the lines in the projective plane. 
function GenLines()
    % The configurations. 
    % LCell is easy to see in workplace, while L is not since it is 3D matrix.
    global P; global LCell; global D; global p; global h; global NumP; global q;
    
    % The number of lines is the same as NumVer. The points in a line is q+1. 
    % r is the global row index to fill in the line set.
    % Every line can be generated in \binom{q+1}{2} ways, but here only needs one.
    L_NumP=q+1; LCell={}; r=1;
    for i=1:NumP
        % i is the base point index, and j is the directional point index. 
        % SecondPoint contains the index of the points.
        % This forloop is to remove points in the already generated line.
        SecondPoint=[i+1:NumP];
        for j=1:i
            % RowIdx is a row vector all the time, so to avoid size(RowIdx,2)
            % returns 1 even when it is empty, we use length to control the loop.
            RowIdx=find(ismember(P,TwoDimSubspace(P(i,:),P(j,:)),'rows'))';
            % Here we cannot directly set SecondPoint(RowIdx,:)=[], since the
            % elements in the RowIdx is the row index of P, but not the row 
            % index of SecondPoint.
            for k=1:length(RowIdx)
                SecondPoint(SecondPoint==RowIdx(k))=[];
            end
        end
        % After searching for a non-repeated line's second point, generate it.
        while ~isempty(SecondPoint)
            % Linear span the line and find the other points on the line.
            RowIdx = find(ismember(P,TwoDimSubspace(P(i,:),P(SecondPoint(1),:)), 'rows'));
            % Add the other points to the line.
            for k=1:length(RowIdx)
                LCell{r,k}=P(RowIdx(k),:);
            end        
            % Remove the points in this line from the possible second points.
            for k=1:length(RowIdx)
                % This SecondPoint==RowIdx(k) returns the index of repeated
                % index RowIdx(k) in SecondPoint. 
                SecondPoint(SecondPoint==RowIdx(k))=[];
            end
            r=r+1;
        end 
    end
    
    %% If the plane is dual affine plane, then remove one point and all lines incident with it.
    global AG;
    if AG==2
        % The removed point is x, which is assigned to be the first point. 
        x=P(1,:);
        % Remove the point x in P.
        P=P(2:end,:);
        % Remove the lines contain x. Use a matrix to record the line position.
        RemovePos=[];
        for i=1:size(LCell,1)
            if ~isempty(find(ismember(cell2mat(LCell(i,:)'),x,'rows')))
                RemovePos=[RemovePos,i];
            end
        end
        LCell(RemovePos,:)=[];
    end
    
    % Change the lines of cell format to 3D matrix format. It is faster
    % than LCell.
    NumL=size(LCell,1);
    global L;
    L = permute(reshape(cell2mat(LCell), NumL, D, L_NumP), [1, 3, 2]);
end