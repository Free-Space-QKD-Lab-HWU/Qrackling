classdef source
    properties (SetAccess = protected)
        Type
        File
        Unit
    end
    methods
        function s = source(type, options)
            arguments
                type {mustBeMember(type, {'solar', 'thermal'})}
                options.File {mustBeFile}
                options.Unit {mustBeMember(options.Unit, {'per_nm', 'per_cm-1'})}
            end

            s.Type= type;

            if contains(fieldnames(options), 'File')
                s.File = adduserpath(options.File);
            end

            if contains(fieldnames(options), 'Unit')
                s.Unit = options.Unit;
            end

        end
    end
end
