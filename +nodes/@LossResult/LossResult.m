classdef LossResult
    properties (SetAccess = protected)
        unit
        kind
        geometric
        optical
        apt
        turbulence
        atmospheric
    end
    methods
        function result = LossResult(unit, kind, options)

            arguments
                unit {mustBeMember(unit, ["percent", "decibel"])}
                kind {mustBeMember(kind, ["beacon", "qkd"])}
                options.geometric
                options.optical
                options.apt
                options.turbulence
                options.atmospheric
            end

            result.unit = unit;
            result.kind = kind;

            for fieldname = fieldnames(options)'
                switch fieldname{1}
                case "geometric"
                    result.geometric = options.geometric;
                case "optical"
                    result.optical = options.optical;
                case "apt"
                    result.apt = options.apt;
                case "turbulence"
                    result.turbulence = options.turbulence;
                case "atmospheric"
                    result.atmospheric = options.atmospheric;
                end
            end

        end
    end
end
