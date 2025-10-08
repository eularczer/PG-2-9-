% Generate the points totalP of projective plane. Then we quotient the
% equivalent relation to get the final points set. 
function GenPoints()
% Pass some parameters to generate the points.
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