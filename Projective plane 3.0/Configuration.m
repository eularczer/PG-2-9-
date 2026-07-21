%% Configuration for PG(r,q), especially PG(2,q), with coefficients for the line-type (m,n) set.
function Configuration()
    
    % Set p as the character of a finite field, and h as the power. 
    global p; global h; global AG; global D; global q;
    
    % Line-type (m,n) set with size K (K is calculated by m,n).
    global m; global n; global K;
    
    % Create an input dialog box
    prompt = {'Over finite field q:', 'Affine space or dual space or not','m','n','K'};  % Prompt strings
    dlgtitle = 'The Configuration';  % Dialog title
    dims = [1,50];  % Input field size [rows cols]
    % m=1,n=3,K=9,7 is always a test set in PG(2,4), which are ; 
    % (m,n)=(1,4), K=13 in PG(2,9) is a baer subplane. K=28 is the unital.
    definput = {'9','0','1','4','28'};  
    
    % Show the dialog and get user input (returns a cell array of strings)
    answer=inputdlg(prompt, dlgtitle, dims, definput);
    %answer={'4','0','1','3','9'}; % To test the speed by defaulting the window.
    
    %% Setup for the projective space.
    q=str2double(answer{1});  % Finite field type;
    q_factors=factor(q); 
    p=q_factors(1); h=length(q_factors); 
    
    AG=str2double(answer{2});  % Dual affine space or not.
    
    
    %% Setup for intersection set.
    % m=1,n=3,K=9,7 is always a test set in PG(2,4); and (m,n)=(1,4), K=13 in PG(2,9).
    m=str2double(answer{3}); n=str2double(answer{4}); K=str2double(answer{5});
    
    
    %% Calculate number of points and lines.
    % NumP, NumL mean the number of points and lines respectively.
    global NumP; global NumL;
    NumP=(q^D-1)/(q-1); NumL=(q^D-1)*(q^D-q)/((q^2-1)*(q^2-q));
    
    % If AG=1, the plane is affine plane. Not implmented for D>3 since affine space is complicated.
    if AG==1 && D==3
        NumP=q^(D-1); NumL=q^(D-1)+q;
    end
    
    % If AG=2, then when generating lines, a point and all incidence lines will be deleted.
    if AG==1 && D==3
        NumP=q^D-1; NumL=q^(D-1);
    end

    %% Calculate the auxiliary stable parameters.
    % tm,tn denotes the total number of m,n intersection lines respectively.
    global tm; global tn;
    tm=(n*(q^2+q+1)-K*(q+1))/(n-m); tn=(K*(q+1)-m*(q^2+q+1))/(n-m);
    % Fixing a point in the TypemnSet, rhom is the number of m intersection
    % lines through this point, and rhon is n intersection respectively.
    global rhom; global rhon;
    % Fixing a point out of the TypemnSet, sigmam is the number of m intersection
    % lines through this point, and sigman is n intersection respectively.
    global sigmam; global sigman;
    rhom=(n*(q+1)-K-q)/(n-m); rhon=(K+q-m*(q+1))/(n-m); 
    sigmam=(n*(q+1)-K)/(n-m); sigman=(K-m*(q+1))/(n-m);
end