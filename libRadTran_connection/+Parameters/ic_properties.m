classdef ic_properties
    properties (SetAccess = protected)
        Label
        option
    end
    methods
        function ic = ic_properties(label, options)
            arguments
                label {mustBeMember(label,  {...
                    'fu',       'echam4', 'key',      'yang',      'baum', ...
                    'baum_v36', 'hey',    'yang2013', 'filename'})}
                options.Interpolate bool = false
            end
            ic.Label = label;

            ic.option = '';
            if options.Interpolate == true
                ic.option = 'Interpolate';
            end
        end
    end
end
