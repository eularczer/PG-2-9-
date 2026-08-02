%% FinallyNoAutomorphism remove the isomorphic structure in AllTypemnSet.
% AllTypemnSet removes the graph isomorphism. BiGraph is the incidence structure.
function[NoAutoTypemnSet]=FinallyNoAutomorphism(BiGraph,AllTypemnSet)  
    % K is the size of TypemnSet.
    % NumP and NumL is set as an offset to put linepoints in bipartite graph Bigraph.
    global K; global P; global NumP; global NumL;
    
    % Find the index of every point in AllTypemnSet. 
    % Use a cell SubBiGraph to restore the graph Type (m,n).
    SubBiGraph={};
    for i=1:size(AllTypemnSet,1)
        CannonicalmnSet=AllTypemnSet(i,:);
        % RemainingPL is the restricted points in SubBiGraph.
        RemainingPL=[];    
        % Add all the index of points in AllTypemnSet to RemainingPL.
        for j=1:K
            RemainingPL=[RemainingPL,find(ismember(P, CannonicalmnSet{j}, 'rows'))];
        end    
        % Add all the linepoints to subgraph as nodes. 
        RemainingPL=[RemainingPL,NumP+[1:NumL]];
        % Check whether the new graph is automorphic to someone in old class.
        TempGrpah=subgraph(BiGraph,RemainingPL);
        if CheckAuto(SubBiGraph,TempGrpah)==0
            SubBiGraph(end+1)={TempGrpah};
        end
    end
    
    % Finally output the generated nonisomorphic graph.
    NoAutoTypemnSet=SubBiGraph;
end



% CheckAuto can check whether two graphs are isomorphic.
% SubBiGraph is the Cannonical graph, NewSubgraph is the tested one.
function[AutoOrNot]=CheckAuto(SubBiGraph,NewSubgraph)
    if size(SubBiGraph,2)==0
        AutoOrNot=0;
        return;
    else
        for i=1:size(SubBiGraph,2)
            if isisomorphic(SubBiGraph{i},NewSubgraph) AutoOrNot=1; return; end
        end
        AutoOrNot=0;
    end
end


