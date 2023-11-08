classdef raman
    properties (SetAccess = protected)
        Label
        state matlab.lang.OnOffSwitchState
    end
    methods
        function r = raman(state, options)
            arguments
                state matlab.lang.OnOffSwitchState
                options.label {mustBeMember(options.label, {'original'})}
            end
            r.state = state;
            if numel(fieldnames(options)) > 0
                r.Label = options.label;
            end
        end
    end
end
