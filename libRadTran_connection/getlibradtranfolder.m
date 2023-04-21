function location = getlibradtranfolder(path)

    location = adduserpath(path);

    delim = '/';
    if ~isunix
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
