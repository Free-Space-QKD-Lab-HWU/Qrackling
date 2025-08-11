% GaussianBeacon
%
% A pointing beacon with a Gaussian intensity distribution.
% This object models a beacon whose intensity falls off with angle
% according to a Gaussian profile.
%
% Syntax:
% Output = beacon.GaussianBeacon(Input1, Input2, …)
%
% The GaussianBeacon inherits from the abstract Beacon class and adds
% divergence modeling based on a 1-sigma Gaussian spread.

classdef GaussianBeacon < beacon.Beacon


    %% Properties

    properties
        % The 1-sigma angle at which the Gaussian intensity distribution diverges
        divergence_half_angle (1, 1) double {mustBeNonnegative}
    end


    %% Methods

    methods

        function gaussian_beacon = GaussianBeacon(telescope, power, wavelength, options)
            % GaussianBeacon
            %
            % Constructs a GaussianBeacon object with specified telescope,
            % power, wavelength, and optional parameters.
            %
            % Syntax:
            % Output = beacon.GaussianBeacon(telescope, power, wavelength, options)
            %
            % Inputs:
            % telescope - (1x1) object, the telescope used for transmission.
            % power - (1x1) double, transmitted power in watts.
            % wavelength - (1x1) double, wavelength of the beacon in meters.
            % options - (1x1) struct, optional parameters including:
            %   power_efficiency - (1x1) double, efficiency factor.
            %   pointing_jitter - (1x1) double, angular jitter in radians.
            %   divergence_half_angle - (1x1) double, 1-sigma divergence angle.
            %
            % Outputs:
            % GaussianBeacon – (1x1) object, constructed beacon instance.
            arguments
                telescope
                power
                wavelength
                options.power_efficiency = 1
                options.pointing_jitter = 1e-3
                options.divergence_half_angle = telescope.fov / 2
            end

            % Construct abstract beacon class
            gaussian_beacon@beacon.Beacon(telescope, power, wavelength, ...
                "Power_Efficiency", options.power_efficiency, ...
                "Pointing_Jitter", options.pointing_jitter);

            gaussian_beacon.divergence_half_angle = options.divergence_half_angle;

        end

        function loss = aptLoss(gaussian_beacon, camera)
            % getAptLoss
            %
            % Computes the loss (absolute fraction of transmitted power)
            % at an angle off the optical axis of the beacon.
            %
            % Syntax:
            % loss = beacon.gaussianBeacon.getAptLoss(camera)
            %
            % Inputs:
            % camera - (1x1) object, receiver camera with FOV and telescope.
            %
            % Outputs:
            % loss – (1x1) double, fraction of power received.
            %% Compute intensity distribution function at this angle

            downlink_apt_loss = (2 * gaussian_beacon.divergence_half_angle) ^ 2 ...
                / ( (2 * gaussian_beacon.divergence_half_angle) ^ 2 ...
                + gaussian_beacon.pointing_jitter ^ 2 );

            uplooking_apt_loss = 1 - exp( ...
                -(camera.FOV) .^ 2 ...
                / (8 * camera.telescope.pointing_jitter .^ 2) );

            % Take product
            loss = downlink_apt_loss .* uplooking_apt_loss;

        end

        function [geo_loss, geo_spot_diameter] = geoLoss(gaussian_beacon, range, camera)
            % getGeoLoss
            %
            % Computes the geometric loss due to beam spreading relative
            % to the receiver camera area. Value is a unitless ratio < 1.
            %
            % Syntax:
            % [geo_loss, geo_spot_diameter] = beacon.gaussianBeacon.getGeoLoss(range, camera)
            %
            % Inputs:
            % range - (1xN) double, distance from beacon to receiver.
            % camera - (1x1) object, receiver camera with collecting area.
            %
            % Outputs:
            % geo_loss – (1xN) double, fraction of power received.
            % geo_spot_diameter – (1xN) double, beam diameter at range.

            %% Ensure range is row vector
            if iscolumn(range)
                range = range';
            end

            geo_spot_diameter = 2 * gaussian_beacon.divergence_half_angle * range;

            geo_loss = (sqrt(pi) / 8) ...
                * camera.collecting_area ...
                / (pi * (geo_spot_diameter / 2) .^ 2);

        end

    end

end