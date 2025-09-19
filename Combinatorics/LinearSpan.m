% This function add up the two vectors in the finite field.
% The output should be a set of vectors but should include input u,v. 
function[w]=LinearSpan(u,v)
% Calculate u+v in finite field of PG(2,2)
dim=length(u); w=zeros(1,dim);
for i=1:dim
    w(i)=AdditionGF2(u(i),v(i));
end











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