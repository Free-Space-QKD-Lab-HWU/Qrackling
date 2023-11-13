function file_path = inputHasDopData(lrt_input_file_path)
    arguments
        lrt_input_file_path {mustBeFile}
    end

    [keys, data] = libradtran.readInputFile(lrt_input_file_path);
    is_key = contains(keys, 'mc_basename');

    assert(any(is_key), [ ...
        'mc_basename is not specified in input file, could not ', ...
        'find file containing degree of polarisation data']);

    % index of 'output_file' in keys should be location of max in is_key
    [~, idx] = max(is_key);
    file_path = [data{idx-1}, '.rad.spc'];

    assert(isfile(file_path), 'No file found');

end
