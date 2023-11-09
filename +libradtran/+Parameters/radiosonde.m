classdef radiosonde
    properties (SetAccess = protected)
        File
    end
    methods
        function radio = radiosonde(file)
            arguments
                file {mustBeFile}
            end
            radio.File = file;
        end
    end
end
