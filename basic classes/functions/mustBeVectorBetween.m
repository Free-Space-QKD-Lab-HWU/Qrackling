function mustBeVectorBetween(X,lims)
%% a validation function which checks that the input is a numeric vector and that all of its elements lie between or on

%validate limits
assert(lims(1)<lims(2),'lims must be a 2-vector where the first entry is strictly less than the last');

%validate input
assert(isnumeric(X),'Input must be numeric');
assert(isvector(X),'Input must be a vector');
assert(all(X)>=lims(1),'All input elements must be greater than or equal to lims(1)')
assert(all(X)<=lims(2),'All input elements must be less than or equal to lims(2)')