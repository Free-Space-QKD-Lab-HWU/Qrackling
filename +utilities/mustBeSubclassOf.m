function mustBeSubclassOf(x,superclass)
%a validation function which returns only if x is an eventual subclass of
%the specified class
assert(ismember(superclass,superclasses(x)),[char(class(x)),' is not a subclass of ',char(superclass)])