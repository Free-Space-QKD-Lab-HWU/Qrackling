function result = nativePathFrom(input_path)
% nativePathFrom
%
% Converts a user-specified path to a native format for the current OS.
% This includes expanding user-relative paths and normalizing separators.
%
% Syntax:
% result = namespace.utility.nativePathFrom(input_path)
%
% Inputs:
% input_path – (1×1) string or char, path to be converted to native format.
%
% Outputs:
% result – (1×1) string, path with separators matching the current OS.

    arguments
        input_path {mustBeText}
    end

    % Expand user-relative path (e.g., "~") to full path
    full_path = utilities.addUserPath(input_path);

    % Normalize path separators based on current OS
    switch filesep
        case "/"
            result = replace(full_path, "\", filesep);
        case "\"
            result = replace(full_path, "/", filesep);
    end

    % Validate that the path exists
    [filepath, ~, ~] = fileparts(result);
    assert(isfolder(filepath), 'Path does not exist');
end