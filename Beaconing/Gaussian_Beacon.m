classdef Gaussian_Beacon < Beacon
    %Gaussian_Beacon a pointing beacon with a gaussian intensity distribution

    properties
        %the 1-sigma angle at which the gaussian intensity distribution diverges
        Divergence_Half_Angle (1,1) double {mustBeNonnegative}
    end

    methods
        function Gaussian_Beacon = Gaussian_Beacon(Power,...
                                                   Wavelength,...
                                                   Divergence_Half_Angle)
            %%Gaussian_Beacon Construct an instance of this class
            
            %construct abstract beacon class
            Gaussian_Beacon@Beacon(Power,Wavelength);
            %then implement Gaussian_Beacon properties
            Gaussian_Beacon.Divergence_Half_Angle = Divergence_Half_Angle;
        end

        function Loss = GetAPTLoss(Gaussian_Beacon, Angle)
        %Get the loss (absolute, i.e. the fraction of transmitted power)
        % at an angle off the optical axis of the beacon


            %% compute intensity distribution function at this angle
            Loss = 1/sqrt(2*pi*Gaussian_Beacon.Divergence_Half_Angle)*...
                exp(0.5*(Angle/Gaussian_Beacon.Divergence_Half_Angle).^2);
        end

        function GeoLoss = GetGeoLoss(Gaussian_Beacon, Range, Camera)
        %%GETGEOLOSS Get the loss incurred by the spreading of the beacon beam
        %relative to the receiver camera area. Value is a unitless ratio <1

        GeoLoss = Camera.Collecting_Area./(pi*(Gaussian_Beacon.Divergence_Half_Angle*Range).^2);
        end
    end
end