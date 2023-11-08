classdef wc_properties
    properties (SetAccess = protected)
        Property
        Interpolate matlab.lang.OnOffSwitchState
    end
    methods
        function wc = wc_properties(property, options)
            arguments
                property {mustBeMember(property, {'hu', 'echam4', 'mie', 'filename'})}
                options.interpolate matlab.lang.OnOffSwitchState
            end
            wc.Property = property;
            for f = fieldnames(options)'
                wc.(f{1}) = options.(f{1});
            end
        end
    end
end
