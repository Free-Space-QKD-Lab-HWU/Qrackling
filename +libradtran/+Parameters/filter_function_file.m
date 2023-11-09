classdef filter_function_file
    properties
        File
        option
    end
    methods
        function f = filter_function_file(file, options)
            arguments
                file {mustBeFile}
                options.Normalize bool = false
            end

            f.File = file;

            f.option = '';
            if options.Normalize == true
                f.option = 'normalize';
            end

        end
    end
end
