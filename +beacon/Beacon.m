% Beacon
%
% Description of optical beacon for pointing and tracking as part of a 
% Qrackling SatQKD simulation.
% 
% Syntax:
% b = beacon.Beacon(Telescope, Power, Wavelength, options)

classdef(Abstract) Beacon


    properties
        % optical power sent by the beacon in W.
        power (1,1) double {mustBeNonnegative}

        % Wavelength of the optical signal in nm.
        wavelength (1,1) double {mustBeNonnegative}

        % Efficiency of the power conversion to laser light.
        power_efficiency (1,1) double { ...
            mustBeNonnegative, ...
            mustBeLessThanOrEqual(power_efficiency,1)} = 1;

        % Total efficiency including laser and telescope.
        total_efficiency (1,1) double { ...
            mustBeNonnegative, ...
            mustBeLessThanOrEqual(total_efficiency,1)}

        % Pointing jitter of beacon (i.e. coarse pointing precision).
        pointing_jitter (1,1) double {mustBeNonnegative}

        % Telescope which beacon uses.
        telescope (1,1) components.Telescope = [];
    end

    methods
        function Beacon = Beacon(telescope, power, wavelength, options)
            % Beacon
            %
            % Create an optical beacon model.
            % 
            % Syntax:
            % b = Beacon(telescope, power, wavelength, options)

            arguments
                telescope (1,1) components.Telescope
                power (1,1) {mustBeNonnegative}
                wavelength (1,1) {mustBeNonnegative}
                options.power_efficiency = 1
                options.pointing_jitter = 1E-3
            end

            Beacon.power = power;
            Beacon.wavelength = wavelength;
            Beacon.power_efficiency = options.power_efficiency;
            Beacon.pointing_jitter = options.pointing_jitter;

            % Set properties of contained telescope.
            telescope = setWavelength(telescope, wavelength);
            telescope = setPointingJitter(telescope, options.pointing_jitter);
            Beacon.telescope = telescope;
        end
    end
    methods (Abstract = true)
        aptLoss = aptLoss(Beacon, angle)
        % aptLoss
        % 
        % return the loss (absolute, i.e. the fraction of transmitted power)
        % at an angle off the optical axis of the beacon
        %
        % Syntax:
        % aptLoss = aptLoss(Beacon, angle)
        %
        % Inputs:
        % Beacon (1,1)
        % angle (arbitrary shape)
        %
        % Outputs:
        % aptLoss (shape same as angle) in absolute units in (0,1)

        [geoLoss,geoSpotDiameter] = geoLoss(Beacon, range, Camera)
        % geoLoss
        % 
        % return the loss incurred by the spreading of the beacon beam relative
        % to the size of the receiver camera. Also returns the diameter of
        % geometrically spread spot (used to compute turbulence loss).
        %
        % Syntax:
        % [geoLoss,geoSpotDiameter] = geoLoss(Beacon, range, Camera)
        %
        % Inputs:
        % Beacon (1,1)
        % range (arbitrary shape) distance from transmitter to receiver in
        % m, must be non-negative
        % Camera (1,1)
        % 
        % Outputs:
        % geoLoss (shape same as range) in absolute units in (0,1)
        % geoSpotDiameter (shape same as range) 1-$\sigma$ diameter of
        % geometrically spread spot in m 
        % 
        % GeoLoss is a unitless ratio, geoSpotDiameter is the spot diameter
        % at the receiver in m.
        % 
        % Must take at least vector angle input and produce the same shaped
        % output of intensity values.
    end

    methods
        function pointing_jitter =  get.pointing_jitter(Beacon)
        % get.pointing_jitter
        % 
        % Return the pointing jitter of the contained telescope.
        %
        % Syntax:
        % pointing_jitter =  get.pointing_jitter(Beacon)
        %
        % Inputs:
        % Beacon (1,1)
        % 
        % Outputs:
        % pointing_jitter (1,1) in radians root-mean-square
            pointing_jitter = Beacon.telescope.pointing_jitter;
        end

        function total_efficiency = get.total_efficiency(Beacon)
        % get.total_efficiency
        % 
        % Return the end-to-end power efficiency of the beacon.
        %
        % Syntax:
        % total_efficiency = get.total_efficiency(Beacon)
        %
        % Inputs:
        % Beacon (1,1)
        % 
        % Outputs:
        % total_efficiency (1,1) in absolute units in (0,1)
            total_efficiency = ...
                Beacon.telescope.optical_efficiency ...
                * Beacon.power_efficiency;
        end
    end
end
