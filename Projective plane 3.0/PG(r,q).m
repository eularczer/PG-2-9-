clear all; clearvars; 


%% Set up global values.
% P and L are the points set and line set respectively.
global P; global L;

% D is the dimension of vector space implemented for projective space. 
% q is the finite field size, and p,h are its prime power factors.
% NumP, and NumL are the number of points and lines.  
global D; global p; global h; global q; global NumP; global NumL;

% Set D=3 as the projective plane dimension using vector space. Subsequent research may have D=4.
D=3;

% AG is the sign for affine space. If DAG=0, it is projective space. 
% If AG=1, it is affine space; if AG=2, it is dual affine space.
global AG;

% Line-type (m,n) set, and K is the size of this set. 
global m; global n; global K;


%% Set up configurations.
Configuration();


%% Generate the points.
GenPoints();


%% Genetrate the lines.
GenLines()


%% Search the intersection set type (m,n).

% Calculate the number m intersecting and n intersecting lines.
global tm; global tn;
tm=(n*(q^2+q+1)-K*(q+1))/(n-m); tn=(K*(q+1)-m*(q^2+q+1))/(n-m);
% Through a point in the TypemnSet, rhom is the number of m intersection
% lines through this point, and rhon is n intersection respectively.
global rhom; global rhon;
% Through a point out of the TypemnSet, sigmam is the number of m intersection
% lines through this point, and sigman is n intersection respectively.
global sigmam; global sigman;
rhom=(n*(q+1)-K-q)/(n-m); rhon=(K+q-m*(q+1))/(n-m); 
sigmam=(n*(q+1)-K)/(n-m); sigman=(K-m*(q+1))/(n-m);

%AllTypemnSet=GenmnSetOldV2();
%AllTypemnSet=GenAll3pointsSet();
AllTypemnSet=GenmnSet();


%% Transform the hypergraph of (P,L) to bipartite graph. 
BiGraph=HypertoBiGraph();


%% Remove automorphisms from AllTypemnSet.
% TypemnSet=NoAutoTypemnSet(BiGraph,AllTypemnSet);


