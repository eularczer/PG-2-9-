clear all; clearvars; 


%% Set up global values.
% P and L are the points set and line set respectively.
global P; global LCell; global L;

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
% Some auxiliary stable global parameters.
% tm,tn denotes the total number of m,n intersection lines respectively.
global tm; global tn; 
% Fixing a point inside or outside K, rho, sigma repectively denote the
% type m,n intersections lines passing through it.
global rhom; global rhon; global sigmam; global sigman;
    
%AllTypemnSet=GenmnSetOldV2();
%AllTypemnSet=GenAll3pointsSet();
AllTypemnSet=GenmnSet();


%% Transform the hypergraph of (P,L) to bipartite graph. 
BiGraph=HypertoBiGraph();


%% Remove automorphisms from AllTypemnSet.
% TypemnSet=FinallyNoAutomorphism(BiGraph,AllTypemnSet);


