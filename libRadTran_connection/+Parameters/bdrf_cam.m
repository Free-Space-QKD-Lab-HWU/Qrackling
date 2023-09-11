classdef bdrf_cam
    properties (SetAccess = protected)
        Variable
        Value
    end
    methods
        function cam = bdrf_cam(var, val)
            arguments
                var {mustBeMember(var, {'pcl', 'sal', 'u10', 'uphi'})}
                val {mustBeNumeric}
            end
            cam.Variable = var;
            cam.Value = val;
        end
    end
end
