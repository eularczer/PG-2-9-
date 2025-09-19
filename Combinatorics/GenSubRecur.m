% This function is to form all subsets based on the given whole set.
function[AllSubR]=GenSubRecur(u)
% u is the whole set and we need to generate all subsets of it. So we need
% to remove repeated elements.
u=unique(u);
% AllSub is used as a global variable to receive the all subsets output in
% the recursive function.
global AllSub;
AllSub={};
% Then we successively discuss whether some element in u is in the subset or
% not.
ElementwiseGen([],u);
AllSubR=AllSub;


% IntermediateSet is the subsets during the undone process. RemainingSet is
% the remaining discussion set from u. ClassifiedSet is the final subset.
function ElementwiseGen(IntermediateSet,RemainingSet)
global AllSub;
% If the Remaingset just has zero or one element, then just return it by
% discussion this element only.
size=length(RemainingSet);
if size<=1
    % Since we do not know how many subsets are there (pretending not to
    % know 2^n), we need to operate on the global variable. And there is no
    % non-recursively efficient method to find all subsets when n is large
    % if we do not use n many for-loops.
%     if not(RemainingSet(1)==3) % We test the case we forbid the subset containing 3.
%         AllSub=[AllSub,{[IntermediateSet,RemainingSet]}];
%     end
    AllSub=[AllSub,{[IntermediateSet,RemainingSet]}];
    AllSub=[AllSub,{IntermediateSet}];
else
%     if not(RemainingSet(1)==3)
%         ElementwiseGen([IntermediateSet,RemainingSet(1)],RemainingSet(2:size));
%     end
    ElementwiseGen([IntermediateSet,RemainingSet(1)],RemainingSet(2:size));
    ElementwiseGen(IntermediateSet,RemainingSet(2:size));
end










