classdef earth_radius
   properties
        Value
   end
   methods
        function radius = earth_radius(val)
            arguments
                val {mustBeNumeric}
            end
            radius.Value = val;
        end
   end
end
