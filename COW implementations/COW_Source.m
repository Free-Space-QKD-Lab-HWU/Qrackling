classdef COW_Source < Source
    %COW_Source a source ready for COW


    methods
        function COW_Source = COW_Source(Wavelength)
            % Construct an instance of this class
                

            %% decoy probability describes a 2-state probability set
            decoy_prob=0.155;
            State_Probabilities=[1-decoy_prob,decoy_prob];
            %construct a transmitter object
            COW_Source=COW_Source@Source(Wavelength,...
                'Mean_Photon_Number',0.06,...
                'State_Prep_Error',0.01,...
                'State_Probabilities',State_Probabilities);
        end
    end
end