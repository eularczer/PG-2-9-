% This function add up the two vectors in the finite field.
% The output should be a set of vectors but should exclude input u,v. 
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
for i=1:NumPOnL-2
    for j=1:dim
        w(i,j)=AdditionGF2(u(j),v(j));
    end
end
% for j=1:dim
%     w(j)=AdditionGF2(u(j),v(j));
% end




% This function calculate the sum of two numbers in finite field GF(2)
function[sum]=AdditionGF2(a,b)
sum=0;
if max(a)>1 || max(b)>1 || min(a)<0 || min(b)<0 disp('something wrong with input when addition in GF(2)'); return; end
% Construct an additional table
if a==0 && b==0 sum=0;
elseif a==0 && b==1 sum=1;
elseif a==1 && b==0 sum=1;
elseif a==1 && b==1 sum=0;
end



% This function calculate the sum of two numbers in finite field GF(4)
function[sum]=AdditionGF4(a,b)
sum=0;
if max(a)>1 || max(b)>1 || min(a)<0 || min(b)<0 disp('something wrong with input when addition in GF(2)'); return; end
% Construct an additional table
if a==0 && b==0 sum=0;
elseif a==0 && b==1 sum=1;
elseif a==1 && b==0 sum=1;
elseif a==1 && b==1 sum=0;
end