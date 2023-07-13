classdef aerosol_angstrom
    properties
        Alpha {mustBeNumeric}
        Beta {mustBeNumeric}
    end

    methods
        function angstrom = aerosol_angstrom(Alpha, Beta)
            arguments
                Alpha {mustBeNumeric}
                Beta {mustBeNumeric}
            end

            angstrom.Alpha = Alpha;
            angstrom.Beta = Beta;
        end
    end
end
