clear all; clearvars; 

%% Basic settings for projective linear spaces.
% P and L are the points set and line set respectively.
global P; global L;
% Set D=3 as the projective plane dimension using vectors. Subsequent research may have D=4.
% Set p as the character of a finite field, and h as the power. 
% NumP, and NumL are the points and lines in a projective space, and in
% projective plane, they are the same. (In general projective planes, to
% calculate NumL we need to calculate number of PGL matrix.)
global D; global p; global h; global NumP; global NumL; global q;
D=3; p=3; h=2;
% First set q as the p^h inorder to simplify the results.
q=p^h; NumP=(q^D-1)/(q-1); NumL=NumP;

%% If the plane is affine plane, AG=1. Not implmented for D>3 since affine space is complicated.
global AG;
AG=0;
if AG==1 && D==3
    NumP=q^(D-1); NumL=q^(D-1)+q;
end

%% If the plane is dual affine plane, DAG=1. Not implmented for D>3.
global DAG;
DAG=0; % We do not need to do any dual, since directly remove a point x in P and remove all lines incident with x is ok.

%% Generate the points.
GenPoints();

%% Genetrate the lines.
GenLines()

%% Settings for the intersection set.
% Set m,n, for some fixed number to test the function.
global m; global n; global K; m=1; n=4;
% K is the size of TypemnSet. 
% In fact, K can only have two possible values after the assignment m,n. 
K=28; %m=1,n=3,K=9,7 is always a test set in PG(2,4); and (m,n)=(1,4), K=13 in PG(2,9).

% After the setting of K, we can calculate the number of line which
% intersects TypemnSet with m points and n points.
global tm; global tn;
tm=(n*(q^2+q+1)-K*(q+1))/(n-m); tn=(K*(q+1)-m*(q^2+q+1))/(n-m);

% Calculate the number of m intersection lines and n intersection lines.
% Fixing a point in the TypemnSet, rhom is the number of m intersection
% lines through this point, and rhon is n intersection respectively.
global rhom; global rhon;
% Fixing a point out of the TypemnSet, sigmam is the number of m intersection
% lines through this point, and sigman is n intersection respectively.
global sigmam; global sigman;
rhom=(n*(q+1)-K-q)/(n-m); rhon=(K+q-m*(q+1))/(n-m); 
sigmam=(n*(q+1)-K)/(n-m); sigman=(K-m*(q+1))/(n-m);

%% Search the intersection set type (m,n).
%AllTypemnSet=GenmnSetOldV2();
%AllTypemnSet=GenAll3pointsSet();
AllTypemnSet=GenmnSet();

%% Transform the hypergraph of (P,L) to bipartite graph. 
BiGraph=HypertoBiGraph();

%% Remove automorphisms from AllTypemnSet.
% TypemnSet=NoAutoTypemnSet(BiGraph,AllTypemnSet);


