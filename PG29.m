clear;

% Construct all the points on PG(2,2). All the points in the planes are 1
% row and 3 column vectors in the linear space.
P=zeros(2^3-1,3); NumVer=size(P,1);
for i=1:NumVer
    % change the decimal to binary or others. temps are the different
    % format of the generated point.
    temp=dec2base(i,2); temp=sprintf('%03s', temp);
    for j=1:3
        P(i,j)=str2num(temp(j));
    end
end

% Find all the lines in the projective plane. By theory we know the number
% of lines is the same as NumVer, and the points on a line is q+1. 
L_NumVer=2+1; L=[]; r=1; % r is the global row index to fill in the line set.
for i=1:NumVer
    % i is the base point, and j is the directional point. We need to
    % refine directional point to remove repeated generating lines.
    SecondPoint=[i+1:NumVer];
    for j=1:i
        RowIdx=find(ismember(P, LinearSpan(P(i,:),P(j,:)), 'rows'));
        for k=1:length(RowIdx)
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
    end
    % In the process we also need to remove repeated generating lines
    % during the generating even after removing them from the former base point.
    while ~length(SecondPoint)==0
        % Linear span the line and find the other points on the line.
        RowIdx = find(ismember(P, LinearSpan(P(i,:),P(SecondPoint(1),:)), 'rows'))
        % Adding the other points to the line record.
        L(r,1)=i; L(r,2)=SecondPoint(1); L(r,1:L_NumVer)=[L(r,1:2),RowIdx']; r=r+1;
        % Removing the repeated generated line in next turns.
        SecondPoint(1)=[];
        for k=1:length(RowIdx)
            SecondPoint(SecondPoint==RowIdx(k))=[];
        end
    end    
    % Those are the code without removing repeated generated lines.
%     for j=1:length(SecondPoint)
%         % Linear span the line and find the other points on the line.
%         RowIdx = find(ismember(P, LinearSpan(P(i,:),P(SecondPoint(j),:)), 'rows'));
%         % Adding the other points to the line record.
%         L(r,1)=i; L(r,2)=SecondPoint(j); L(r,1:L_NumVer)=[L(r,1:2),RowIdx']; r=r+1;
%     end    
end

% Find the intersection set type (m,n)








