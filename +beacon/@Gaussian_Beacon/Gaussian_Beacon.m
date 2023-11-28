classdef Gaussian_Beacon < beacon.Beacon
    %Gaussian_Beacon a pointing beacon with a gaussian intensity distribution

    properties
        %the 1-sigma angle at which the gaussian intensity distribution diverges
        Divergence_Half_Angle (1,1) double {mustBeNonnegative}
    end

    methods
        function Gaussian_Beacon = Gaussian_Beacon(Telescope, Power, ...
            Wavelength, Power_Efficiency, Pointing_Jitter, Divergence_Half_Angle)
            %%Gaussian_Beacon Construct an instance of this class
            arguments
                Telescope
                Power
                Wavelength
                Power_Efficiency = 1
                Pointing_Jitter = 1E-3
                Divergence_Half_Angle = Telescope.FOV / 2
            end

            %construct abstract beacon class
            Gaussian_Beacon@beacon.Beacon(Telescope, Power, Wavelength, ...
                Power_Efficiency, Pointing_Jitter);

            %% check to see if flat top beacon half angle is provided, if not use telescope
            % p=inputParser();
            % p.KeepUnmatched=true;
            % parse(p,varargin{:})
            % addParameter(p,'Divergence_Half_Angle',Gaussian_Beacon.Telescope.FOV/2);
            % parse(p,varargin{:})
            % Gaussian_Beacon.Divergence_Half_Angle = p.Results.Divergence_Half_Angle;

            Gaussian_Beacon.Divergence_Half_Angle = Divergence_Half_Angle;
        end

        function Loss = GetAPTLoss(Gaussian_Beacon, Camera)
        %Get the loss (absolute, i.e. the fraction of transmitted power)
        % at an angle off the optical axis of the beacon

            %% compute intensity distribution function at this angle
            Downlink_APT_Loss = Gaussian_Beacon.Divergence_Half_Angle ^ 2 ...
                / ( Gaussian_Beacon.Divergence_Half_Angle ^ 2 ...
                   + Gaussian_Beacon.Pointing_Jitter ^ 2 );
            Uplooking_APT_Loss = 1 - exp( ...
                -(Camera.FOV) .^ 2 ...
                ./ (8 * Camera.Telescope.Pointing_Jitter .^ 2) );
            %take product
            Loss = Downlink_APT_Loss .* Uplooking_APT_Loss;
        end

        function [GeoLoss,GeoSpotDiameter] = GetGeoLoss(Gaussian_Beacon, Range, Camera)
        %%GETGEOLOSS Get the loss incurred by the spreading of the beacon beam
        %relative to the receiver camera area. Value is a unitless ratio <1

            %output should always be row vector. convert range to row if column
            if iscolumn(Range)
                Range = Range';
            end

            GeoSpotDiameter = 2 * Gaussian_Beacon.Divergence_Half_Angle * Range;

            GeoLoss = ( sqrt(pi) / 8 ) ...
                * Camera.Collecting_Area ...
                ./ ((GeoSpotDiameter / 2) .^ 2);
        end
    end
end
