clear all; clearvars; 

%% Basic settings for linear spaces.
% P and L are the points set and line set respectively.
global P; global L;
% Set D=3 as the projective plane dimension using vectors. Subsequent research may have D=4.
% Set p as the character of a finite field, and h as the power. 
% NumP, and NumL are the points and lines in a projective space, and in
% projective plane, they are the same. (In general projective planes, to
% calculate NumL we need to calculate number of PGL matrix.)
global D; global p; global h; global NumP; global NumL;
D=4; p=3; h=2;
% First set q as the p^h inorder to simplify the results.
q=p^h; NumP=(q^D-1)/(q-1); NumL=NumP;

%% Generate the points.
GenPoints();

%% Genetrate the lines.
GenLines()

%% Settings for the intersection set.
% Set m,n, for some fixed number to test the function.
global m; global n; global K; m=1; n=4;
% K is the size of TypemnSet. 
% In fact, K can only have two possible values after the assignment m,n. 
K=13; %m=1,n=3,K=9,7 is always a test set in PG(2,4).

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
%AllTypemnSet=GenmnSet();

%% Transform the hypergraph of (P,L) to bipartite graph. 
BiGraph=HypertoBiGraph();

%% Remove automorphisms from AllTypemnSet.
% TypemnSet=NoAutoTypemnSet(BiGraph,AllTypemnSet);


