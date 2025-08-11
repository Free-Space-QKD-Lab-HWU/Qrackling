function x = isSubclassOf(x, superclass)
    % a validation function which returns only if x is an eventual subclass of
    % the specified class
    %
    % Syntax:
    % result = isSubclassOf(x, superclass)
    %
    % Description:
    % Returns true if the input object x is a subclass (or instance) of the
    % specified superclass name.

    x = ismember(superclass, [superclasses(x); class(x)]);
end