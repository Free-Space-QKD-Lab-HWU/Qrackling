classdef wc_file
    properties (SetAccess = protected)
        Type
        File
    end
    methods
        function wc = wc_file(type, file)
            arguments
                type {mustBeMember(type, {'1D', 'ipa_files', 'moments'})}
                file {mustBeFile}
            end
            wc.Type = type;
            wc.File = file;
        end
    end
end
