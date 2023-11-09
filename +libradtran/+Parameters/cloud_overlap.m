classdef cloud_overlap
    properties (SetAccess = protected)
        Label
    end
    methods
        function co = cloud_overlap(type)
            arguments
                type {mustBeMember(type, {'rand', 'maxrand', 'max', 'off'})}
            end
            co.Label = type;
        end
    end
end
