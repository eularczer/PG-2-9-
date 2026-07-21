%% HypertoBiGraph transforms hypergraph to bipartite graph (S,T).
% S is the point set and T the edge set, and the incidence of point line
% is shown as a line between S and T.
function[BiGraph]=HypertoBiGraph()
    % Configurations.
    global P; global L;

    % Set an offset for points P and lines L.
    Offset=size(P,1);    
    % Use graph (s,t) to construct the graph. s means points P, t lines L. 
    s=[]; t=[];
    % First scan the lines and find the points in the line.
    for i=1:size(L,1)
        l=squeeze(L(i,:,:));
        % Then scan the line l and find the points in P having connection with it.
        for j=1:size(l,1)
            s=[s,find(ismember(P,l(j,:),'row'))];
            t=[t,i+Offset]; % for example, the second line (i=2) is added size(l,2) times.
        end
    end
    BiGraph=graph(s,t);
    plot(BiGraph);
end


