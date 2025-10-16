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
%% Calculation table in PG(D,2)
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
%% Calculation table in PG(D,4)
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
%% Calculation table in PG(D,3)
elseif p==3 && h==1
    % If v is empty, then do the multiplication to u to remove repeated points 
    % in totalPoints.
    if isempty(v)
        for i=1:p^h-1
            for j=1:D
                w(i,j)=PosMultiplicationGF3(i,u(1,j));
            end
        end
    % If both are vectors, then span two points to form a line. The method
    % of spanning is by fixing one vector u and adding i times v.
    else
        for i=1:NumPOnL-2
            for j=1:dim
                w(i,j)=PosAdditionGF3(u(1,j),PosMultiplicationGF3(i,v(1,j)));              
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
                    AllRepOfP(j)=PosMultiplicationGF3(k,w(i,j));
                end
                w=[w;AllRepOfP];
            end
        end
    end
%% Calculation table in PG(D,9)
elseif p==3 && h==2
    % If v is empty, then do the multiplication to u to remove repeated points 
    % in totalPoints.
    if isempty(v)
        for i=1:p^h-1
            for j=1:D
                w(i,j)=PosMultiplicationGF9(i,u(1,j));
            end
        end
    % If both are vectors, then span two points to form a line. The method
    % of spanning is by fixing one vector u and adding i times v.
    else
        for i=1:NumPOnL-2
            for j=1:dim
                w(i,j)=PosAdditionGF9(u(1,j),PosMultiplicationGF9(i,v(1,j)));              
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
                    AllRepOfP(j)=PosMultiplicationGF9(k,w(i,j));
                end
                w=[w;AllRepOfP];
            end
        end
    end
end



%% Calculation in finite field GF(2)
function[sum]=PosAdditionGF2(a,b)
sum=0;
if max(a)>1 || max(b)>1 || min(a)<0 || min(b)<0 disp('something wrong with input when adding in GF(2)'); return; end
% Construct an addition table
if a==0 && b==0 sum=0;
elseif a==0 && b==1 sum=1;
elseif a==1 && b==0 sum=1;
elseif a==1 && b==1 sum=0;
end

%% Calculation in finite field GF(4)
% This function calculate the sum of two numbers in finite field GF(4). 
% In GF(4), 0 and 1 have the intital meaning in GF(2), but 2,3 means the
% algebraic elements over GF(2). We define the irrducible function as
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
% Construct an multiplication table
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

%% Calculation in finite field GF(3)
function[sum]=PosAdditionGF3(a,b)
sum=0;
if max(a)>2 || max(b)>2 || min(a)<0 || min(b)<0 disp('something wrong with input when adding in GF(3)'); return; end
% Construct an addition table
if a==0 && b==0 sum=0;
elseif a==0 && b==1 sum=1;
elseif a==0 && b==2 sum=2;
elseif a==1 && b==0 sum=1;
elseif a==1 && b==1 sum=2;
elseif a==1 && b==2 sum=0;
elseif a==2 && b==0 sum=2;
elseif a==2 && b==1 sum=0;
elseif a==2 && b==2 sum=1;
end

% This function calculate the multiplication rule in finite field GF(3).
function[product]=PosMultiplicationGF3(a,b)
product=0;
if max(a)>2 || max(b)>2 || min(a)<0 || min(b)<0 disp('something wrong with input when multiplying in GF(4)'); return; end
% Construct a multiplication table
if a==0 && b==0 product=0;
elseif a==0 && b==1 product=0;
elseif a==0 && b==2 product=0;
elseif a==1 && b==0 product=0;
elseif a==1 && b==1 product=1;
elseif a==1 && b==2 product=2;
elseif a==2 && b==0 product=0;
elseif a==2 && b==1 product=2;
elseif a==2 && b==2 product=1;
end

%% Calculation in finite field GF(9)
% This function calculate the sum of two numbers in finite field GF(9). 
% In GF(9), 0,1,2 have the intital meaning in GF(3), but 3,4,5,6,7,8 means the
% algebraic elements over GF(3). We define the irrducible function as
% x^2+1, and quotient it from F_3[x]. "3" represents \alpha, and "4" is
% \alpha+1, and "5" is \alpha+2, and "6" is 2\alpha, and "7" is 2\alpha+1,
% and "8" is 2\alpha+2.
function[sum]=PosAdditionGF9(a,b)
sum=0;
if max(a)>8 || max(b)>8 || min(a)<0 || min(b)<0 disp('something wrong with input when adding in GF(9)'); return; end
% Construct an addition table
if a==0
    if b==0 sum=0; elseif b==1 sum=1; elseif b==2 sum=2;
    elseif b==3 sum=3; elseif b==4 sum=4; elseif b==5 sum=5;
    elseif b==6 sum=6; elseif b==7 sum=7; elseif b==8 sum=8; end
elseif a==1
    if b==0 sum=1; elseif b==1 sum=2; elseif b==2 sum=0;
    elseif b==3 sum=4; elseif b==4 sum=5; elseif b==5 sum=3;
    elseif b==6 sum=7; elseif b==7 sum=8; elseif b==8 sum=6; end
elseif a==2
    if b==0 sum=2; elseif b==1 sum=0; elseif b==2 sum=1;
    elseif b==3 sum=5; elseif b==4 sum=3; elseif b==5 sum=4;
    elseif b==6 sum=8; elseif b==7 sum=6; elseif b==8 sum=7; end
elseif a==3
    if b==0 sum=3; elseif b==1 sum=4; elseif b==2 sum=5;
    elseif b==3 sum=6; elseif b==4 sum=7; elseif b==5 sum=8;
    elseif b==6 sum=0; elseif b==7 sum=1; elseif b==8 sum=2; end
elseif a==4 
    if b==0 sum=4; elseif b==1 sum=5; elseif b==2 sum=3;
    elseif b==3 sum=7; elseif b==4 sum=8; elseif b==5 sum=6;
    elseif b==6 sum=1; elseif b==7 sum=2; elseif b==8 sum=0; end
elseif a==5 
    if b==0 sum=5; elseif b==1 sum=3; elseif b==2 sum=4;
    elseif b==3 sum=8; elseif b==4 sum=6; elseif b==5 sum=7;
    elseif b==6 sum=2; elseif b==7 sum=0; elseif b==8 sum=1; end
elseif a==6
    if b==0 sum=6; elseif b==1 sum=7; elseif b==2 sum=8;
    elseif b==3 sum=0; elseif b==4 sum=1; elseif b==5 sum=2;
    elseif b==6 sum=3; elseif b==7 sum=4; elseif b==8 sum=5; end
elseif a==7
    if b==0 sum=7; elseif b==1 sum=8; elseif b==2 sum=6;
    elseif b==3 sum=1; elseif b==4 sum=2; elseif b==5 sum=0;
    elseif b==6 sum=4; elseif b==7 sum=5; elseif b==8 sum=3; end
elseif a==8
    if b==0 sum=8; elseif b==1 sum=6; elseif b==2 sum=7;
    elseif b==3 sum=2; elseif b==4 sum=0; elseif b==5 sum=1;
    elseif b==6 sum=5; elseif b==7 sum=3; elseif b==8 sum=4; end
end


% This function calculate the multiplication rule in finite field GF(9).
function[product]=PosMultiplicationGF9(a,b)
product=0;
if max(a)>8 || max(b)>8 || min(a)<0 || min(b)<0 disp('something wrong with input when multiplying in GF(9)'); return; end
% Construct a multiplication table
if a==0
    if b==0 product=0; elseif b==1 product=0; elseif b==2 product=0;
    elseif b==3 product=0; elseif b==4 product=0; elseif b==5 product=0;
    elseif b==6 product=0; elseif b==7 product=0; elseif b==8 product=0; end
elseif a==1
    if b==0 product=0; elseif b==1 product=1; elseif b==2 product=2;
    elseif b==3 product=3; elseif b==4 product=4; elseif b==5 product=5;
    elseif b==6 product=6; elseif b==7 product=7; elseif b==8 product=8; end
elseif a==2
    if b==0 product=0; elseif b==1 product=2; elseif b==2 product=1;
    elseif b==3 product=6; elseif b==4 product=8; elseif b==5 product=7;
    elseif b==6 product=3; elseif b==7 product=5; elseif b==8 product=4; end
elseif a==3
    if b==0 product=0; elseif b==1 product=3; elseif b==2 product=6;
    elseif b==3 product=2; elseif b==4 product=5; elseif b==5 product=8;
    elseif b==6 product=1; elseif b==7 product=4; elseif b==8 product=7; end
elseif a==4 
    if b==0 product=0; elseif b==1 product=4; elseif b==2 product=8;
    elseif b==3 product=5; elseif b==4 product=6; elseif b==5 product=1;
    elseif b==6 product=7; elseif b==7 product=2; elseif b==8 product=3; end
elseif a==5 
    if b==0 product=0; elseif b==1 product=5; elseif b==2 product=7;
    elseif b==3 product=8; elseif b==4 product=1; elseif b==5 product=3;
    elseif b==6 product=4; elseif b==7 product=6; elseif b==8 product=2; end
elseif a==6
    if b==0 product=0; elseif b==1 product=6; elseif b==2 product=3;
    elseif b==3 product=1; elseif b==4 product=7; elseif b==5 product=4;
    elseif b==6 product=2; elseif b==7 product=8; elseif b==8 product=5; end
elseif a==7
    if b==0 product=0; elseif b==1 product=7; elseif b==2 product=5;
    elseif b==3 product=4; elseif b==4 product=2; elseif b==5 product=6;
    elseif b==6 product=8; elseif b==7 product=3; elseif b==8 product=1; end
elseif a==8
    if b==0 product=0; elseif b==1 product=8; elseif b==2 product=4;
    elseif b==3 product=7; elseif b==4 product=3; elseif b==5 product=2;
    elseif b==6 product=5; elseif b==7 product=1; elseif b==8 product=6; end
end
