classdef DPS_Source < Source
    %DPS_Source a source ready for DPS

    methods
        function DPS_Source = DPS_Source(Wavelength)
            % Construct an instance of this class

            %construct a source object
            DPS_Source=DPS_Source@Source(Wavelength,...
                'Mean_Photon_Number',0.06,...
                'State_Prep_Error',0.01);
        end
    end
end