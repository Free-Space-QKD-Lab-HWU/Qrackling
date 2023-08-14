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
            for f = fieldnames(options)'
                s.(f{1}) = options.(f{1});
            end
        end
    end
end
