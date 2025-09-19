clear;
% Generate a symmetric matrix with diagonal 0 for the graph. 
A=rand(10)>0.7; A=A-diag(diag(A)); A=triu(A)+triu(A)';

% Generate the names for the vertices
names={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};

% Generate the graph with no loops and plot it.
G=graph(A,names(1:size(A))); figure, plot(G), title('The Graph G for Spanning Tree');

% Breadth first search for the graph. Start with the point name A. It can also be set to B or others. 
% The edge has endpoints set s and t.
B=['A']; s=['']; t=[''];
for i=1:size(A)
    if i>length(B) 
        disp('The graph is not connected');
        break; % terminate the immediate while or for loop
    end
    % Search the graph from the point i, which is the endpoint B(i).
    N=neighbors(G,B(i));
    l=length(N);
    if l~=0
        for j=1:l
            % if N(j) has been searched in B, then ignore it.
            if ~ismember(N(j),B)
                s=[s,B(i)]; t=[t,N(j)];
                B=[B,N(j)];
            end
        end
    end
    % i
    % length(B)
end
% plot the constructed tree
if ~isempty(s)
    SPTree=graph(s,t);
    figure, plot(SPTree), title('Breadth First Search');
end

% Depth first search for the graph. Start with the point name 'A'. It can also be set to 'B' or others. 
% The edge has endpoints set u and v.
D=['A']; u=['']; v=['']; i=1;
while i>0
    % Transform cell to matrix and find a new node to search.
    N=neighbors(G,D(i)); N=setdiff(N,D);
    if ~isempty(N)
       N=setdiff(N,D);
       u=[u,D(i)]; v=[v,N(1)];
       D=[D,N(1)];
       i=i+1;
    else 
    i=i-1;
    end
end
% Plot the constructed spanning tree
if ~isempty(u)
    SPTree=graph(u,v);
    figure, plot(SPTree), title('Depth First Search');
end




