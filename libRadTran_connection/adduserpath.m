function in_path = adduserpath(in_path)

    delim = '/';
    if isunix
        home = getenv('HOME');
    else
        home = getenv('USERPROFILE');
        delim = '\';
    end

    if ~isempty(home)
        idx = startsWith(in_path, '~');
        n = numel(in_path);
        in_path = strjoin(...
            {home, ...
            extractAfter(in_path(idx:n), 1)}, ...
            delim);
    end

end
