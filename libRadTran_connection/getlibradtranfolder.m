function location = getlibradtranfolder(path)


    if isunix
        delim = '/';
    else
        delim = '\';
    end

    location = adduserpath(path, delim);
    disp(location);

    % assert(...
    %     isdir(location), ...
    %     ['''', location, '''', ' is not a valid path'] ...
    % );

    % assert(...
    %     isfile([location, delim, 'bin', delim, 'uvspec']), ...
    %     ['LibRadTran not found at ', '''', location, ''''] ...
    % );

end

function in_path = adduserpath(in_path, delimiter)

    if isunix
        home = getenv('HOME');
    else
        home = getenv('USERPROFILE');
    end

    if ~isempty(home)
        idx = startsWith(in_path, '~');
        n = numel(in_path);
        in_path = strjoin(...
            {home, ...
            extractAfter(in_path(idx:n), 1)}, ...
            delimiter);
    end

    in_path = in_path(1:end-1);

end
