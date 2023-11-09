classdef ic_file
    properties (SetAccess = protected)
        Type
        File
    end
    methods
        function ic = ic_file(type, file)
            arguments
                type {mustBeMember(type, {'ic', 'wc'})}
                file {mustBeFile}
            end
            ic.Type = type;
            ic.File = file;
        end
    end
end
