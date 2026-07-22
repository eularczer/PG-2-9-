% The function is to generate 1-dim subspace when input one vectors, and
% returns back q vectors including [0,0,...,0].
function [w]=OneDimSubspace(v)
    % The configurations.
    global p; global h; global q; global D;
    % Depending on the vector space dimension, span the 2-dim vector subspace, 
    % If u=[0], then it is a 1-dim vector space including [0,0,...,0].
    if p==2 && h==1
        for i=0:p^h-1
            for j=1:D
                w(i+1,j)=PosAdditionGF2(0,PosMultiplicationGF2(i,v(j)));
            end
        end
    elseif p==2 && h==2
        for i=0:p^h-1
            for j=1:D
                w(i+1,j)=PosAdditionGF4(0,PosMultiplicationGF4(i,v(j)));
            end
        end
    elseif p==2 && h==3
        for i=0:p^h-1
            for j=1:D
                w(i+1,j)=PosAdditionGF8(0,PosMultiplicationGF8(i,v(j)));
            end
        end
    elseif p==3 && h==1
        for i=0:p^h-1
            for j=1:D
                w(i+1,j)=PosAdditionGF3(0,PosMultiplicationGF3(i,v(j)));
            end
        end  
    elseif p==3 && h==2
        for i=0:p^h-1
            for j=1:D
                w(i+1,j)=PosAdditionGF9(0,PosMultiplicationGF9(i,v(j)));
            end
        end
    else disp('Not construct this type of projective plane yet');
    end
end


%% Addition and Multiplication table.
% PosAdditionGF2 is to add each position with the element in GF(2).
function[sum]=PosAdditionGF2(a,b)
    AddTable=[0,1;1,0];
    sum=AddTable(a+1,b+1);
end
% PosMultiplicationGF2 is to multiply each position with the element in GF(2).
% [0,0;
%  0,1] is the multiplication table with row/column in order 0,1,...,q-1. 
% Using the multiplication table can avoid to write a lot of if, elseif.
function [product]=PosMultiplicationGF2(a,b)    
    MulTable=[0,0;0,1]; 
    product=MulTable(a+1,b+1);
end

% In GF(4) it is more complicated, since it has 0,1,2,3 where 2 is
% the primitive element \alpha in the field extension F_2(\alpha)\approx
% F_2[x]/<x^2+x+1>. 0=0, 1=1, 2=\alpha, 3=\alpha+1.
% [0,1,2,3;
%  1,0,3,2;
%  2,3,0,1;
%  3,2,1,0] is the addition table in GF(4).
function[sum]=PosAdditionGF4(a,b)
    AddTable=[0,1,2,3;1,0,3,2;2,3,0,1;3,2,1,0];
    sum=AddTable(a+1,b+1);
end
% [0,0,0,0;
%  0,1,2,3;
%  0,2,3,1;
%  0,3,1,2] is the multiplication table.
function [product]=PosMultiplicationGF4(a,b)    
    MulTable=[0,0,0,0; 0,1,2,3; 0,2,3,1; 0,3,1,2];
    product=MulTable(a+1,b+1);
end

% GF(8)\approx F_2[x]/<x^3+x+1>. 2=\alpha, 4=alpha^2, 5=\alpha^2+1, 6=\alpha^2+\alpha.
function [sum]=PosAdditionGF8(a,b)    
    AddTable=[0,1,2,3,4,5,6,7; 1,0,3,2,5,4,7,6; 2,3,0,1,6,7,4,5; 3,2,1,0,7,6,5,4;
        4,5,6,7,0,1,2,3; 5,4,7,6,1,0,3,2; 6,7,4,5,2,3,0,1; 7,6,5,4,3,2,1,0];
    sum=AddTable(a+1,b+1);
end
function [product]=PosMultiplicationGF8(a,b)    
    MulTable=[0,0,0,0,0,0,0,0; 0,1,2,3,4,5,6,7; 0,2,4,6,3,1,7,5; 0,3,6,5,7,4,1,2;
        0,4,3,7,6,2,5,1; 0,5,1,4,2,7,3,6; 0,6,7,1,5,3,2,4; 0,7,5,2,1,6,4,3];
    product=MulTable(a+1,b+1);
end

% GF(3) is trivial.
function[sum]=PosAdditionGF3(a,b)
    AddTable=[0,1,2;1,2,0;2,0,1];
    sum=AddTable(a+1,b+1);
end
function [product]=PosMultiplicationGF3(a,b)    
    MulTable=[0,0,0;0,1,2;0,2,1]; 
    product=MulTable(a+1,b+1);
end

% GF(9)\approx F_3[x]/<x^2+1>, 3=\alpha, 6=2\alpha.
function[sum]=PosAdditionGF9(a,b)
    AddTable=[0,1,2,3,4,5,6,7,8; 1,2,0,4,5,3,7,8,6; 2,0,1,5,3,4,8,6,7; 3,4,5,6,7,8,0,1,2;
        4,5,3,7,8,6,1,2,0; 5,3,4,8,6,7,2,0,1; 6,7,8,0,1,2,3,4,5; 7,8,6,1,2,0,4,5,3; 8,6,7,2,0,1,5,3,4];
    sum=AddTable(a+1,b+1);
end
function [product]=PosMultiplicationGF9(a,b)    
    MulTable=[0,0,0,0,0,0,0,0,0; 0,1,2,3,4,5,6,7,8; 0,2,1,6,8,7,3,5,4; 0,3,6,2,5,8,1,4,7;
        0,4,8,5,6,1,7,2,3; 0,5,7,8,1,3,4,6,2; 0,6,3,1,7,4,2,8,5; 0,7,5,4,2,6,8,3,1; 0,8,4,7,3,2,5,1,6]; 
    product=MulTable(a+1,b+1);
end
