classdef raman
    properties (SetAccess = protected)
        Label
    end
    methods
        function r = raman(label)
            arguments
                label {mustBeMember(label, {'original'})}
            end
        end
    end
end
