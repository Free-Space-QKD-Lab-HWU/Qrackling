function output = runlibRadtran(filename, parameters, quiet, output_path)

    delim = newline;
    if ispc
        delim = [char(13), char(10)];
    end

    formatAll = ...
        @(params) ...
        cellfun(@(param) format_tag(param), params, UniformOutput=false);

    filename = adduserpath(filename);
    lrtinputs = strjoin(formatAll(parameters), delim);

    fd = fopen(filename, 'w');
    written_bytes = fprintf(fd, lrtinputs);
    assert(written_bytes > 0, 'Nothing written, something has gone wrong');

    output_param = ''
    for i = 1:numel(parameters)
        p = parameters{i};
        if isa(p, 'Variable')
            if strcmp(p.Parent, 'output_file')
                output_param = p.Value;
                break
            end
        end
    end

    output_file = '';

    if ~isempty(output_path)
        output_file = output_path;
        callstr = strjoin({'uvspec < ', filename, output_file});
    end

    if ~isempty(output_param)
        output_file = output_param;
        callstr = strjoin({'uvspec < ', filename});
    end

    assert(~isempty(output_file), 'No output set');

    if ~isempty(output_path) & ~isempty(output_param)
        disp('Value of output_path ignored.');
    end
    output_file = adduserpath(output_file);

    lrtdir = getlibradtranfolder('~/libRadtran-2.0.4');
    if isunix
        curdir = cd([lrtdir, '/examples/']);
        if quiet == true
            [~,~] = system(strjoin({'uvspec < ', filename, ' > ', output_path}));
        else
            info = system(strjoin({'uvspec < ', filename, ' > ', output_path}));
        end
        curdir = cd(curdir);
    end

    output.inputfile = filename;
    output.outputfile = output_file;

end
