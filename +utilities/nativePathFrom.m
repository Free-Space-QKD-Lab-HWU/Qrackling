function result = nativePathFrom(input_path)
    arguments
        input_path {mustBeText}
    end

    full_path = utilities.addUserPath(input_path);

    switch filesep
    case "/"
        result = replace(full_path, "\", filesep);
    case "\"
        result = replace(full_path, "/", filesep);
    end

    [filepath, ~, ~] = fileparts(result);
    disp(filepath)
    assert(isfolder(filepath), 'Path does not exist');

end
