function in_path = adduserpath(in_path)

    delim = '/';
    if isunix
        home = getenv('HOME');
    else
        home = getenv('USERPROFILE');
        delim = '\';
    end

    if ~isempty(home)
        idx = 1;
        if startsWith(in_path, '~/')
            idx = 1;
        end
        n = numel(in_path);
        in_path = strjoin(...
            {home, ...
            extractAfter(in_path(idx:n), 1)}, ...
            delim);
    end

    in_path = replace(in_path, [delim, delim], delim);

end
