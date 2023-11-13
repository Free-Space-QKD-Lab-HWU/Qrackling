function path = addUserPath(in_path)
    if isunix
        home = getenv('HOME');
    else
        home = getenv('USERPROFILE');
    end

    delim = filesep();

    if ~isempty(home)
        idx = 1;
        if startsWith(in_path, '~/')
            idx = 1;
        end
        n = numel(in_path);
        in_path = strjoin({ home, extractAfter(in_path(idx:n), 1) }, delim);
    end

    path = replace(in_path, [delim, delim], delim);
end
