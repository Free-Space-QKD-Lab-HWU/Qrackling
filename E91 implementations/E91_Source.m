classdef E91_Source < Source
    %BB84_Transmitter a transmitter with details required for BB84

    properties(SetAccess=protected,Abstract=false)
        g2{mustBeScalarOrEmpty}=0.01;                                         %second order autocorrelation function [g^2(0)] (for a single-photon source this should be zero)
        Mean_Photon_Number{mustBeScalarOrEmpty,mustBePositive}=0.01;          %average number of photons per pulse
        State_Prep_Error{mustBeScalarOrEmpty,mustBeNonnegative}=0.01;         %convolution of errors due to state preparation (as a fraction)
    end

    methods
        function E91_Source = E91_Source(Wavelength,MPN,g2,State_Prep_Error)
            %BB84_Transmitter Construct an instance of this class

            %construct a transmitter object
            E91_Source=E91_Source@Source(Wavelength);
            %set given properties
            if nargin>1
                E91_Source.Mean_Photon_Number=MPN;
                if nargin>2
                    E91_Source.g2=g2;
                    if nargin>3
                        E91_Source.State_Prep_Error=State_Prep_Error;
                    end
                end
            end
        end
    end

end