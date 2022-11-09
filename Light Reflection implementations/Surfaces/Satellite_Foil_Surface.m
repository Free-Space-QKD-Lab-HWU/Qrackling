classdef Satellite_Foil_Surface < Surface
    %%SATELLITE_FOIL_SURFACE a class implementing the surface properties used in
    %%Gozzard, Walsh, Weinhold: "Vulnerability of Satellite Quantum Key
    %%Distribution to Disruption from Ground-Based Lasers"
properties(Constant)
        Reflection_Correction_Factor=3/(2*pi*(2-2^(1/4)));                                     %the correction factor which ensures that reflection from a surface conserves energy
        Reflectance = 0.3;
end


    methods
        function Satellite_Foil_Surface = Satellite_Foil_Surface(Area)
            %%SATELLITE_FOIL_SURFACE constructor

            %% construct surface
            Satellite_Foil_Surface@Surface(Area);
        end
        function RLP = GetReflectedLightProportion(Satellite_Foil_Surface, ~, Incoming_Angle, Outgoing_Angle)
            %%GETREFLECTEDLIGHTPOLLUTION return the light reflected off a
            %%satellite surface

           
            %angle of reflection
            Reflection_Angle = Incoming_Angle - Outgoing_Angle;
            %cosine of half angle of reflection
            cos_half_angle_of_reflection=cosd(Reflection_Angle/2);

            %reflectivity=normal reflectivity* (cos(half angle))^1/2 * correction factor
            RLP=Satellite_Foil_Surface.Reflectance*cos_half_angle_of_reflection.^(1/2)*[Satellite_Foil_Surface.Reflection_Correction_Factor];
        end
    end
end