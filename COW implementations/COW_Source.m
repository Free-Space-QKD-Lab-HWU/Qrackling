classdef COW_Source < Source
    %COW_Source a source with details required for COW

    properties
        Mean_Photon_Number{mustBeScalarOrEmpty,mustBePositive}=0.06;    % average number of photons per pulse for each state
        Extinction_Ratio{mustBeScalarOrEmpty,mustBePositive}=20;   % probability of each state
        Decoy_Probability{mustBeScalarOrEmpty,mustBePositive}=0.155;
    end
    properties(SetAccess=protected)
        Protocol='COW';
    end

    methods
        function COW_Source = COW_Source(Wavelength,MPN,extinction_ratio,decoy_prob)
            % Construct an instance of this class

            %construct a transmitter object
            COW_Source=COW_Source@Source(Wavelength);
            %set given properties
            if nargin>1
                COW_Source.Mean_Photon_Number=MPN;
                if nargin>2
                    COW_Source.extinction_ratio=extinction_ratio;
                    if nargin>3
                        COW_Source.decoy_prob=decoy_prob;
                    end
                end
            end
        end
    end
end