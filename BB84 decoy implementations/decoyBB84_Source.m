classdef decoyBB84_Source < Source
    %BB84_Transmitter a transmitter with details required for BB84

    properties
        Mean_Photon_Number{mustBeNonnegative,mustBeVector}=[0.8 0.1 0];    % average number of photons per pulse for each state
        State_probability{mustBePositive,mustBeVector}=[0.7 0.2 0.1];   % probability of each state
        State_Prep_Error{mustBeScalarOrEmpty,mustBeNonnegative}=0.01;          % convolution of errors due to state preparation (as a fraction)
    end
    properties(SetAccess=protected)
        Protocol='decoyBB84';
    end

    methods
        function decoyBB84_Source = decoyBB84_Source(Wavelength,MPN,State_probability,State_Prep_Error)
            %decoyBB84_Transmitter Construct an instance of this class

            %construct a transmitter object
            decoyBB84_Source=decoyBB84_Source@Source(Wavelength);
            %set given properties
            if nargin>1
                decoyBB84_Source=SetDiameter(decoyBB84_Source,Diameter);
                if nargin>2
                    decoyBB84_Source.Mean_Photon_Number=MPN;
                    if nargin>3
                        %check probabilities add to 1
                        if ~sum(State_probability)==1
                            error('state probability vector must total 1');
                        end
                        decoyBB84_Source.State_probability=State_probability;
                        if nargin>4
                            decoyBB84_Source.State_Prep_Error=State_Prep_Error;
                        end
                    end
                end
            end
        end

    end
end