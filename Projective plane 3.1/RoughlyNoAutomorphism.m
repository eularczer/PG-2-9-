%% RoughlyNoAutomorphism removes automorphism of (m,n) set in advance. 
function [IntermediateSet,RemainingSet,SearchedLIndex]=RoughlyNoAutomorphism(IntermediateSet,RemainingSet,SearchedLIndex)
% Configurations.
global m; global n; global L; global D;

%% The most inefficient way, find all (m,n) sets.
% return;

%% Inefficiently, add just one point.
% IntermediateSet=RemainingSet(1,:); RemainingSet=RemainingSet([2:end],:); SearchedLIndex=zeros(0,2); return;

%% Directly set a line L{1} as the type n line, add n points and remove others in this line.
IntermediateSet=reshape(L(1,[1:n],:),n,D);
% ExcludingIndex is to record the points excluded from RemainingSet.
ExcludedPIndex=find(ismember(RemainingSet,reshape(L(1,:,:),[],D),'rows'));
RemainingSet(ExcludedPIndex',:)=[];
SearchedLIndex=[SearchedLIndex;[1,n]];

% We cannot directly set line 2 to have m points after deciding line 1. 
% Since in PG(2,9), 3 non-collinear points not in a line can be in a baer subplane PG(2,3) 
% or not, which are not isomorphic. 

% Set line 2 to be an n line. Since rhon>1 always holds (not set it as m line since m can be 1).
% Add points even if it will deduce nonisomorphism.
IntermediateSet=[IntermediateSet;reshape(L(2,[2:n],:),[],D)];
ExcludedPIndex=find(ismember(RemainingSet,reshape(L(2,:,:),[],D),'rows'));
RemainingSet(ExcludedPIndex',:)=[]; 
SearchedLIndex=[SearchedLIndex;[2,n]];

