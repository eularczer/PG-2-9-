% This function add up the two vectors in the finite field.
% The output should be a set of vectors which excludes input u,v. 
function[w]=LinearSpan(u,v)
% Calculate u+v in finite field of PG(D-1,q)
% First we introduce some global variables to pick the variable.
global D; global p; global h;
% NumPOnL is calculated in projective plane that the number of points on a
% line, since we have line and point regularities. 
NumPOnL=p^h+1;
% dim is to record how many positional additional to make. w should be a
% matrix whose rows compose a point. And it totally has NumPOnL-2 points as
% the generating points on a line.
dim=D; w=zeros(1,dim);

% We need to change the addition and multiplication table when needed.
% This is multiplication in PG(2,2)
if p==2 && h==1
    % If v is empty, then do the multiplication to u to remove repeated points 
    % in totalPoints.
    if isempty(v)
        for i=1:p^h-1
            for j=1:D
                w(i,j)=PosMultiplicationGF4(i,u(1,j));
            end
        end
    % If both are vectors, then span two points to form a line. The method
    % of spanning is by fixing one vector u and adding i times v.
    else
        for i=1:NumPOnL-2
            for j=1:dim
                w(i,j)=PosAdditionGF2(u(1,j),v(1,j));
            end
        end
    end 
% This is calculation in PG(2,4)
elseif p==2 && h==2
    % If v is empty, then do the multiplication to u to remove repeated points 
    % in totalPoints.
    if isempty(v)
        for i=1:p^h-1
            for j=1:D
                w(i,j)=PosMultiplicationGF4(i,u(1,j));
            end
        end
    % If both are vectors, then span two points to form a line. The method
    % of spanning is by fixing one vector u and adding i times v.
    else
        for i=1:NumPOnL-2
            for j=1:dim
                w(i,j)=PosAdditionGF4(u(1,j),PosMultiplicationGF4(i,v(1,j)));              
            end
        end
        % After generating some points representation for the line, we need 
        % to extend them to the all possible points representation since for
        % example L(010,001) can be 012 which is not in the cannonical
        % representation in P.
        AllRepOfP=[];
        % i is the point in w being found all the representations. k is the
        % multiplication coefficient, j is the column of position for a
        % point of dimension D=3.
        for i=1:NumPOnL-2
            for k=2:p^h-1
                for j=1:dim
                    AllRepOfP(j)=PosMultiplicationGF4(k,w(i,j));
                end
                w=[w;AllRepOfP];
            end
        end
    end
end



% PositionalAdditionGF4 calculates the sum of two numbers in finite field GF(2).
function[sum]=PosAdditionGF2(a,b)
sum=0;
if max(a)>1 || max(b)>1 || min(a)<0 || min(b)<0 disp('something wrong with input when adding in GF(2)'); return; end
% Construct an addition table
if a==0 && b==0 sum=0;
elseif a==0 && b==1 sum=1;
elseif a==1 && b==0 sum=1;
elseif a==1 && b==1 sum=0;
end



% This function calculate the sum of two numbers in finite field GF(4). 
% In GF(4), 0 and 1 have the intital meaning in GF(2), but 2,3 means the
% algebraic elements on GF(2). We define the irrducible function as
% x^2+x+1, and quotient it from F_2[x]. "2" represents \alpha, and "3"
% represents \alpha+1.
function[sum]=PosAdditionGF4(a,b)
sum=0;
if max(a)>3 || max(b)>3 || min(a)<0 || min(b)<0 disp('something wrong with input when adding in GF(4)'); return; end
% Construct an addition table
if a==0 && b==0 sum=0;
elseif a==0 && b==1 sum=1;
elseif a==0 && b==2 sum=2;
elseif a==0 && b==3 sum=3;
elseif a==1 && b==0 sum=1;
elseif a==1 && b==1 sum=0;
elseif a==1 && b==2 sum=3;
elseif a==1 && b==3 sum=2;
elseif a==2 && b==0 sum=2;
elseif a==2 && b==1 sum=3;
elseif a==2 && b==2 sum=0;
elseif a==2 && b==3 sum=1;
elseif a==3 && b==0 sum=3;
elseif a==3 && b==1 sum=2;
elseif a==3 && b==2 sum=1;
elseif a==3 && b==3 sum=0;
end



% This function calculate the multiplication rule in finite field GF(4).
function[product]=PosMultiplicationGF4(a,b)
product=0;
if max(a)>3 || max(b)>3 || min(a)<0 || min(b)<0 disp('something wrong with input when multiplying in GF(4)'); return; end
% Construct an addition table
if a==0 && b==0 product=0;
elseif a==0 && b==1 product=0;
elseif a==0 && b==2 product=0;
elseif a==0 && b==3 product=0;
elseif a==1 && b==0 product=0;
elseif a==1 && b==1 product=1;
elseif a==1 && b==2 product=2;
elseif a==1 && b==3 product=3;
elseif a==2 && b==0 product=0;
elseif a==2 && b==1 product=2;
elseif a==2 && b==2 product=3;
elseif a==2 && b==3 product=1;
elseif a==3 && b==0 product=0;
elseif a==3 && b==1 product=3;
elseif a==3 && b==2 product=1;
elseif a==3 && b==3 product=2;
end