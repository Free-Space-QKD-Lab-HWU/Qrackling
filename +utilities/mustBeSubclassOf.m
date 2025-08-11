function mustBeSubclassOf(x, superclass)
    % a validation function which returns only if x is an eventual subclass of
    % the specified class
    %
    % Syntax:
    % mustBeSubclassOf(x, superclass)
    %
    % Description:
    % Throws an error if x is not a subclass of the specified superclass.

    assert(ismember(superclass, superclasses(x)), ...
        [char(class(x)), ' is not a subclass of ', char(superclass)]);
end