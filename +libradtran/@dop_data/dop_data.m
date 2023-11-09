classdef dop_data
    properties (SetAccess = protected)
        file_path string
    end

    methods
        function dop_data = dop_data(lrt_input_file)
            arguments
                lrt_input_file {mustBeFile}
            end
            [keys, data] = libRadtran.read_input_file(lrt_input_file);

            is_key = contains(keys, 'mc_basename');
            assert(any(is_key) && (sum(is_key) == 1), 'No output specified');

            % index of 'output_file' in keys should be location of max in is_key
            [~, idx] = max(is_key);
            dop_data.file_path = [data{idx-1}, '.rad.spc'];
            assert(isfile(dop_data.file_path), 'Not a file');
        end
    end
end
