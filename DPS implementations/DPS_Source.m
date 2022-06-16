classdef DPS_Source < Source
    %DPS_Source a sourc with details required for DPS

    properties
        Mean_Photon_Number{mustBeScalarOrEmpty,mustBePositive}=0.06;    % average number of photons per pulse for each state
        Extinction_Ratio{mustBeScalarOrEmpty,mustBePositive}=20;   % probability of each state

    end
    properties(SetAccess=protected)
        Protocol='DPS';
    end

    methods
        function DPS_Source = DPS_Source(Wavelength,MPN,extinction_ratio,decoy_prob)
            % Construct an instance of this class

            %construct a source object
            DPS_Source=DPS_Source@Source(Wavelength);
            %set given properties
            if nargin>1
                DPS_Source.Mean_Photon_Number=MPN;
                if nargin>2
                    DPS_Source.extinction_ratio=extinction_ratio;
                    if nargin>3
                        DPS_Source.decoy_prob=decoy_prob;
                    end
                end
            end
        end
    end
end