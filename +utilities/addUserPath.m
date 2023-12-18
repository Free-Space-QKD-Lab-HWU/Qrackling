function path = addUserPath(in_path)
    if isunix
        home = getenv('HOME');
    else
        home = getenv('USERPROFILE');
    end
    
    if isstring(in_path)
        in_path = char(in_path);
    end
    
    delim = filesep();

    if startsWith(in_path, '~')
        idx = 2;
        n = numel(in_path);
        in_path = strjoin({ home, extractAfter(in_path(idx:n), 1) }, delim);
    end

    path = replace(in_path, [delim, delim], delim);
end
