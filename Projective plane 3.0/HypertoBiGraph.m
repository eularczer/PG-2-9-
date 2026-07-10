% This function transforms hypergraph to bipartite graph (S,T), which takes
% S as the points set and T the edges set, and the incidence of point line
% is shown as a line between S and T.
function[BiGraph]=HypertoBiGraph()
global P; global L;

% To construct the graph we need to set an offset for point points and
% lines point. 
Offset=size(P,1);

% We use graph(s,t) to construct the graph, since s,t is approriate
% for the bipartite graph. s is the point points, t is line points.
s=[]; t=[];
% First we scan the lines and find the points in the line.
for i=1:size(L,1)
    l=L(i,:);
    % Then we scan the points in the line l and find the point in P, and
    % add a connection between them.
    for j=1:size(l,2)
        s=[s,find(ismember(P,cell2mat(l(j)),'row'))];
        t=[t,i+Offset]; % for example, the second line (i=2) is added size(l,2) times.
    end
end
BiGraph=graph(s,t);
plot(BiGraph);


