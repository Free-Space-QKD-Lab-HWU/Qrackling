classdef Flat_Top_Beacon < beacon.Beacon
    %Flat_Top_Beacon a pointing beacon with a uniform intensity distribution

    properties
        %the half-angle at which the uniform intensity distribution drops to 0
        Limit_Half_Angle (1,1) double {mustBeNonnegative}
    end

    methods
        function Flat_Top_Beacon = Flat_Top_Beacon(telescope, Power,...
                                                   Wavelength,...
                                                   Limit_Half_Angle)
            arguments
                telescope components.Telescope
                Power
                Wavelength
                Limit_Half_Angle = telescope.FOV/2
            end
            %%Gaussian_Beacon Construct an instance of this class
            
            %construct abstract beacon class
            Flat_Top_Beacon@beacon.Beacon(telescope, Power, Wavelength);

            %% check to see if flat top beacon half angle is provided, if not use telescope
            % p=inputParser();
            % p.KeepUnmatched=true;
            % parse(p,varargin{:});
            % addParameter(p,'Limit_Half_Angle',Flat_Top_Beacon.Telescope.FOV/2);
            % parse(p);
            %Flat_Top_Beacon.Limit_Half_Angle = p.Results.Limit_Half_Angle;
            Flat_Top_Beacon.Limit_Half_Angle = Limit_Half_Angle;
        end

        function Loss = GetAPTLoss(Flat_Top_Beacon, Camera)
        %Get the loss (absolute, i.e. the fraction of transmitted power)
        % at an angle off the optical axis of the beacon


            %% compute intensity distribution function at this angle
            Downlink_APT_Loss = 1-exp(-(Flat_Top_Beacon.Limit_Half_Angle).^2./(8*Flat_Top_Beacon.Pointing_Jitter.^2));
            Uplooking_APT_Loss= 1-exp(-(Camera.FOV).^2./(8*Camera.Telescope.Pointing_Jitter.^2));
            %take product
            Loss = Downlink_APT_Loss.*Uplooking_APT_Loss;

        end

        function [GeoLoss,GeoSpotDiameter] = GetGeoLoss(Flat_Top_Beacon, Range, Camera)
        %%GETGEOLOSS Get the loss incurred by the spreading of the beacon beam
        %value is returned as a value in m^-2
        
                %output should always be row vector. convert range to row if column
        if iscolumn(Range)
            Range = Range';
        end
        GeoSpotDiameter = (2*Flat_Top_Beacon.Limit_Half_Angle*Range);

            disp("WHAT ARE THE SIZES OF THESE THINGS")
            size(Range)
            size(Camera.Collecting_Area)
            size(GeoSpotDiameter)

        GeoLoss = Camera.Collecting_Area./((pi/4)*GeoSpotDiameter.^2);
        end
    end
end
