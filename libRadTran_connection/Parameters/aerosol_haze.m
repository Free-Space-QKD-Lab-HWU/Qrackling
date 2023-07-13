classdef aerosol_haze
    enumeration
       Rural ('Rural type aerosols'),
       Maritime ('Maritime type aerosols'),
       Urban ('Urban type aerosols'),
       Tropospheric ('Tropospheric type aerosols')
    end

    properties
        Label
    end

    methods
        function haze = aerosol_haze(model)
            haze.Label = model;
        end
    end

end
