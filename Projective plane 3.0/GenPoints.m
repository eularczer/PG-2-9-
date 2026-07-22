% Generate the points totalP of projective plane, i.e. 1-dim subspace. 
function GenPoints()
    
    % The parameters of proejctive plane.
    global P; global L; global D; global p; global h;
    
    % totalP is the matrix of points needed to be generated.
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
        % Every 1-dim subspace is seen as a point in PG, so pick the representative.
        % EquP is to contain them.
        EquP=OneDimSubspace(totalP(1,:));
        P(r,:)=totalP(1,:); r=r+1;
        % Then we remove this 1-dim subspace from totalP.
        RowIdx=find(ismember(totalP,EquP,'rows'))';
        totalP(RowIdx,:)=[];
    end
    
    
    %% If the plane is an affine plane, then remove the infinite points. Else do nothing.
    global AG;
    if AG==1
        P(P(:,1)==0,:)=[];
    end
end