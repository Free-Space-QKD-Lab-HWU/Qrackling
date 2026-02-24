classdef FlatTopBeacon < beacon.Beacon
% FlatTopBeacon
%
% Implements an optical tracking beacon with a uniform power distribution
% over its field of illumination.
% 
% Syntax:
% FTB = FlatTopBeacon(telescope, power, wavelength, options)
%
% FlatTopBeacon inherits from Beacon, but modifies the geo and apt loss
% methods. Field of illumination is set by the telescope FOV.

    properties
        % The half-angle at which the uniform intensity distribution drops
        % to 0.
        limit_half_angle (1,1) double {mustBeNonnegative}
    end

    methods
        function FTB = FlatTopBeacon(telescope, power, wavelength, options)
                % FlatTopBeacon
                % 
                % Constructs a flat top beacon object
                %
                % Syntax:
                % FTB = FlatTopBeacon(telescope, power, wavelength, options)
                %
                % Inputs:
                % telescope - scalar Telescope, the telescope supporting
                % the beacon. Sets the field of illumination.
                % power - scalar numeric, the beacon optical power.
                % wavelength - scalar numeric, the wavelength of the
                % beacon.
                
                % 
                % Outputs:
                % FTB - scalar FlatTopBeacon

            arguments
                telescope components.Telescope
                power
                wavelength
                options.limit_half_angle = []
            end
            
            %% construct abstract beacon class
            FTB@beacon.Beacon(telescope, power, wavelength);

            % set half-angle if specified, otherwise use telescope FOV
            if ~isempty(options.limit_half_angle)
            FTB.limit_half_angle = options.limit_half_angle;
            else
            FTB.limit_half_angle = FTB.telescope.fov;
            end
        end

        function loss = aptLoss(FlatTopBeacon, Camera)
                % getAPTLoss(FlatTopBeacon, Camera)
                % 
                % Overload the aptLoss method to be specific to a flat top
                % beacon. In this case, loss only occurs when pointing is
                % outside of the field of illumination, at which point it
                % is 100% loss.
                %
                % Syntax:
                % loss = getAPTLoss(FlatTopBeacon, Camera)
                %
                % Inputs:
                % FlatTopBeacon - scalar FlatTopBeacon.
                % Camera - scalar Camera, the receiving camera.
                
                % 
                % Outputs:
                % loss - scalar numeric, in absolute units (0,1)

            %% compute intensity distribution function at this angle
            Downlink_APT_Loss = 1-exp(-(FlatTopBeacon.limit_half_angle).^2./(8*FlatTopBeacon.pointing_jitter.^2));
            Uplooking_APT_Loss= 1-exp(-(Camera.fov).^2./(8*Camera.telescope.pointing_jitter.^2));
            %take product 
            loss = Downlink_APT_Loss.*Uplooking_APT_Loss;

        end

        function [geoLoss,geo_spot_diameter] = geoLoss(FlatTopBeacon, range, camera)
            % getGeoLoss
            %
            % Calculates the geometric loss incurred due to the spreading of the beacon beam.
            % The loss is returned in units of m^-2 and accounts for the beam divergence
            % over a given range and the collecting area of the camera.
            %
            % Syntax:
            % [GeoLoss, GeoSpotDiameter] = beacon.FlatTopBeacon.GetGeoLoss(FlatTopBeacon, Range, Camera)
            %
            % Inputs:
            % FlatTopBeacon - scalar Beacon, contains beacon parameters
            % including telescope diameter and beam divergence.
            % Range - numeric vector, distances over which the beam
            % propagates.
            % Camera - scalar Camera, contains camera parameters including
            % collecting area.
            %
            % Outputs:
            % geoLoss - 1xN double (matching size of Range), geometric loss at
            % each range due to beam spreading in absolute units (0,1)
            % geoSpotDiameter - 1xN double (matching size of Range),
            % diameter of the beam spot in m.
        
        %output should always be row vector. convert range to row if column
        if iscolumn(range)
            range = range';
        end


        geo_spot_diameter = FlatTopBeacon.telescope.diameter + (2*FlatTopBeacon.limit_half_angle*range);
        geoLoss = camera.collecting_area./((pi/4)*geo_spot_diameter.^2);
        end
    end
end
