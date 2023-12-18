classdef output_file
    properties (SetAccess = protected)
        File
    end
    methods
        function out = output_file(file)
            arguments
                file {mustBeText}
            end
            delim = '/';
            if ispc
                delim = '\';
            end

            elems = strsplit(file, delim);
            if numel(elems)>1
            path = strjoin(elems(1:end-1), delim);
            else
            path = elems{1};
            end
            assert(numel(elems) ~= numel(path), ...
                'Not a valid file path')
            out.File = file;
        end
    end
end
