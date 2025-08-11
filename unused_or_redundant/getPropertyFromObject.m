function property = getPropertyFromObject(obj, target)
    % Get the property from "obj" that is the same type/class as stated in the target string "target"
    %
    % Syntax:
    % property = getPropertyFromObject(obj, target)
    %
    % Description:
    % Searches the properties of the input object and returns the first property
    % whose value matches the specified class name.

    arguments
        obj
        target {mustBeText}
    end

    props = properties(obj);

    % Check which properties match the target class
    checks = cellfun(@(prop) isa(obj.(prop), target), props, 'UniformOutput', true);

    if ~any(checks)
        error('utilities:getPropertyFromObject', ...
              'No property of type %s in %s', target, inputname(1));
    end

    % Return the first matching property
    property = obj.(props{find(checks, 1)});
end