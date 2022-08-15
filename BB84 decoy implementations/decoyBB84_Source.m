classdef decoyBB84_Source < Source
    %decoyBB84_Source a source ready for decoy BB84


    methods
        function decoyBB84_Source = decoyBB84_Source(Wavelength)
            %decoyBB84_Source Construct an instance of this class

            %construct a source object
            decoyBB84_Source=decoyBB84_Source@Source(Wavelength,...
                'Mean_Photon_Number',[0.8,0.1,0],...
                'State_Prep_Error',0.01,...
                'State_Probabilities',[0.7,0.2,0.1]);
        end

    end
end