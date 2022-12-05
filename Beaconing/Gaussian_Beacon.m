classdef Gaussian_Beacon < Beacon
    %Gaussian_Beacon a pointing beacon with a gaussian intensity distribution

    properties
        %the 1-sigma angle at which the gaussian intensity distribution diverges
        Divergence_Half_Angle (1,1) double {mustBeNonnegative}
    end

    methods
        function Gaussian_Beacon = Gaussian_Beacon(Power,...
                                                   Wavelength,...
                                                   Divergence_Half_Angle,...
                                                   varargin)
            %%Gaussian_Beacon Construct an instance of this class
            
            %construct abstract beacon class
            Gaussian_Beacon@Beacon(Power,Wavelength,varargin{:});
            %then implement Gaussian_Beacon properties
            Gaussian_Beacon.Divergence_Half_Angle = Divergence_Half_Angle;
        end

        function Loss = GetAPTLoss(Gaussian_Beacon, Camera)
        %Get the loss (absolute, i.e. the fraction of transmitted power)
        % at an angle off the optical axis of the beacon


            %% compute intensity distribution function at this angle
            Downlink_APT_Loss = Gaussian_Beacon.Divergence_Half_Angle^2/(Gaussian_Beacon.Divergence_Half_Angle^2+Gaussian_Beacon.Pointing_Jitter^2);
            Uplooking_APT_Loss= 1-exp(-(Camera.FOV).^2./(8*Camera.Telescope.Pointing_Jitter.^2));
            %take product
            Loss = Downlink_APT_Loss.*Uplooking_APT_Loss;
        end

        function GeoLoss = GetGeoLoss(Gaussian_Beacon, Range, Camera)
        %%GETGEOLOSS Get the loss incurred by the spreading of the beacon beam
        %relative to the receiver camera area. Value is a unitless ratio <1

        GeoLoss = (sqrt(pi)/8)*Camera.Collecting_Area./((Gaussian_Beacon.Divergence_Half_Angle*Range).^2);
        end
    end
end