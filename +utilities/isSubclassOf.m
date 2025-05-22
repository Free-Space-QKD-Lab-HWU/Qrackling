function x = isSubclassOf(x,superclass)
%a validation function which returns only if x is an eventual subclass of
%the specified class
x=ismember(superclass,[superclasses(x);class(x)]);