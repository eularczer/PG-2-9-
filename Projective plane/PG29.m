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

% Generate the points.
GenPoints();

% Genetrate the lines.
GenLines()



% Set m,n, for some fixed number to test the function.
global m; global n; global K; m=1; n=3; 
% K is the size of TypemnSet.
% In fact, K can only have two possible values after the assignment m,n. 
K=9; 
% Calculate the number of m intersection lines and n intersection lines.
% Fixing a point in the TypemnSet, rhom is the number of m intersection
% lines through this point, and rhon is n intersection respectively.
global rhom; global rhon;
% Fixing a point out of the TypemnSet, sigmam is the number of m intersection
% lines through this point, and sigman is n intersection respectively.
global sigmam; global sigman;
% First set q as the p^h inorder to simplify the results.
q=p^h;
rhom=(n*(q+1)-K-q)/(n-m); rhon=(K+q-m*(q+1))/(n-m); 
sigmam=(n*(q+1)-K)/(n-m); sigman=(K-m*(q+1))/(n-m);



% Find the intersection set type (m,n).
AllTypemnSet=GenmnSet();
%AllTypemnSet=GenAll3pointsSet();



% Transform the hypergraph of (P,L) to bipartite graph and show it. 
BiGraph=HypertoBiGraph();



% Remove automorphisms from AllTypemnSet.
% TypemnSet=NoAutoTypemnSet(BiGraph,AllTypemnSet);


