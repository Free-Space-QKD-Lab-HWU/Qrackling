function mustBeSubclassOf(x,class)
%a validation function which returns only if x is an eventual subclass of
%the specified class
assert(ismember(class,superclasses(x)))