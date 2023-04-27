classdef (Abstract) Surface
    %SURFACE model for the surface of a satellite
    
    properties (SetAccess = protected)
        Area                                                                    %surface area in m^2
    end
    
    methods
        function obj = Surface(Area)
            %SURFACE Construct a surface object from its area
            obj = SetArea(obj,Area);
        end

        function Surface = SetArea(Surface, Area)
            Surface.Area = Area;
        end

    end
    methods (Abstract = true)
        Reflected_Light_Proportion = GetReflectedLightProportion(Surface, Wavelength, Incoming_Angle, Outgoing_Angle)
    
    end
end

