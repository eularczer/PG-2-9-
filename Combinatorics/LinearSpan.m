% This function add up the two vectors in the finite field
function[w]=LinearSpan(u,v)

% Calculate u+v in finite field of PG(2,2)
dim=length(u); w=zeros(1,dim);
for i=1:dim
    w(i)=Addition_GF2(u(i),v(i));
end











% This function calculate the sum of two numbers in finite field GF(2)
function[sum]=Addition_GF2(a,b)
% Construct an additional table
if a==0 && b==0 sum=0;
elseif a==0 && b==1 sum=1;
elseif a==1 && b==0 sum=1;
elseif a==1 && b==1 sum=0;
end