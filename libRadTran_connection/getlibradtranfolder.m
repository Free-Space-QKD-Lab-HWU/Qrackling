function location = getlibradtranfolder(path)

    location = adduserpath(path=path);
    disp(location);

    if isunix
        delim = '/';
    else
        delim = '\';
    end

    assert(...
        isdir(location), ...
        ['''', location, '''', ' is not a valid path'] ...
    );

    assert(...
        isfile([location, delim, 'bin', delim, 'uvspec']), ...
        ['LibRadTran not found at ', '''', location, ''''] ...
    );

end

function in_path = adduserpath(varargin)
    p = inputParser;
    addParameter(p, 'path', '');
    parse(p, varargin{:});

    in_path = p.Results.path;

    if isunix
        home = getenv('HOME');
    else
        home = getenv('USERPROFILE');
    end

    if ~isempty(home)
        idx = startsWith(in_path, '~');
        n = numel(in_path);
        in_path = [...
            home, ...
            extractAfter(in_path(idx:n), 1)...
        ];
    end

end
