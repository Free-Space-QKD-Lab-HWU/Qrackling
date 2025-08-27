classdef LocatedObject
% LocatedObject
%
% Represents a physical object with latitude, longitude, altitude, and time
% data, possibly for multiple timestamps.
%
% Syntax:
% obj = nodes.LocatedObject()

    properties (SetAccess = protected)
        % latitude - latitude in degrees
        latitude (:, 1) {mustBeNumeric} = []

        % longitude - longitude in degrees
        longitude (:, 1) {mustBeNumeric} = []

        % altitude - altitude in meters
        altitude (:, 1) {mustBeNumeric} = []

        % use_sat_comms_toolbox - flag for toolbox integration
        use_sat_comms_toolbox {mustBeNumericOrLogical} = false

        % n_position - number of position entries
        n_position {mustBeInteger, mustBePositive} = 1

        % time - timestamp array
        time (:, 1) datetime = datetime.empty()
    end

    properties (SetAccess=public)
        % name - identifier for the location
        name = 'Unnamed Location'
    end

    properties (Constant = true, Hidden = true)
        % earth_radius - radius of Earth in meters
        earth_radius = earthRadius()
    end


    methods
        function lla = getLla(obj)
        % getLla
        %
        % Return latitude, longitude, and altitude as an n-by-3 array.
        %
        % Syntax:
        % lla = obj.getLla()
        %
        % Output:
        % lla - numeric array [latitude, longitude, altitude]

            lla = [obj.latitude, obj.longitude, obj.altitude];
        end


        function obj = setPosition(obj, options)
        % setPosition
        %
        % Set the position properties of a LocatedObject.
        %
        % Syntax:
        % obj = obj.setPosition(options)
        %
        % Inputs:
        % options.LLA      - [lat, lon, alt] vector
        % options.Latitude - scalar or vector latitude
        % options.Longitude - scalar or vector longitude
        % options.Altitude - scalar or vector altitude
        % options.Name     - string name

            arguments
                obj
                options.LLA {mustBeNumeric} = []
                options.Latitude {mustBeNumeric} = []
                options.Longitude {mustBeNumeric} = []
                options.Altitude {mustBeNumeric} = []
                options.Name
            end

            if ~isempty(options.LLA)
                obj.latitude = options.LLA(1);
                obj.longitude = options.LLA(2);
                obj.altitude = options.LLA(3);
                obj.n_position = numel(options.LLA(1));
                return
            end

            if all(~isempty([options.Latitude, options.Longitude, options.Altitude]))
                obj.latitude = options.Latitude;
                obj.longitude = options.Longitude;
                obj.altitude = options.Altitude;
                obj.n_position = numel(options.Latitude);
                return
            end

            error('Failed to initialise object: LLA or latitude, longitude, altitude vectors incorrect format');
        end


        function enus = computeRelativeCoords(obj1, obj2)
        % computeRelativeCoords
        %
        % Compute ENU coordinates of obj1 relative to obj2.
        %
        % Syntax:
        % enus = obj1.computeRelativeCoords(obj2)
        %
        % Output:
        % enus - n-by-3 array of ENU coordinates

            if obj1.n_position == 1 && obj2.n_position == 1
                enus = lla2enu(obj1.getLla(), obj2.getLla(), 'ellipsoid');
                return
            end

            if obj1.n_position > 1 && obj2.n_position == 1
                enus = zeros(obj1.n_position, 3);
                lla1 = obj1.getLla();
                for i = 1:obj1.n_position
                    enus(i, :) = lla2enu(lla1(i, :), obj2.getLla(), 'ellipsoid');
                end
                return
            end

            if obj1.n_position == 1 && obj2.n_position > 1
                enus = zeros(obj2.n_position, 3);
                lla2 = obj2.getLla();
                for i = 1:obj2.n_position
                    enus(i, :) = lla2enu(obj1.getLla(), lla2(i, :), 'ellipsoid');
                end
                return
            end

            if obj1.n_position > 1 && obj2.n_position > 1
                if obj1.n_position ~= obj2.n_position
                    error('Location objects must have same number of position entries');
                end
                enus = zeros(obj2.n_position, 3);
                lla1 = obj1.getLla();
                lla2 = obj2.getLla();
                for i = 1:obj2.n_position
                    enus(i, :) = lla2enu(lla1(i, :), lla2(i, :), 'ellipsoid');
                end
                return
            end

            error('Invalid input: must provide matching or singleton position entries');
        end


        function distance = computeDistanceBetween(obj1, obj2)
        % computeDistanceBetween
        %
        % Compute the distance(s) in meters between two LocatedObjects.
        %
        % Syntax:
        % distance = obj1.computeDistanceBetween(obj2)
        %
        % Output:
        % distance - numeric array of distances in meters

            enus = obj1.computeRelativeCoords(obj2);
            distance = utilities.row2Norms(enus)';
        end


        function [headings, elevations, distances] = relativeHeadingAndElevation(obj1, obj2)
        % relativeHeadingAndElevation
        %
        % Compute heading, elevation, and distance of obj1 relative to obj2.
        %
        % Syntax:
        % [headings, elevations, distances] = obj1.relativeHeadingAndElevation(obj2)
        %
        % Outputs:
        % headings   - azimuth angles (degrees)
        % elevations - elevation angles (degrees)
        % distances  - slant ranges (meters)

            enus = obj1.computeRelativeCoords(obj2);
            [headings, elevations] = utilities.headingAndElevation(enus);
            headings = headings';
            elevations = elevations';
            distances = utilities.row2Norms(enus)';
        end


        function [x, y, z] = getXyz(obj)
        % getXyz
        %
        % Convert geographic coordinates to Earth-centered Cartesian XYZ.
        %
        % Syntax:
        % [x, y, z] = obj.getXyz()
        %
        % Outputs:
        % x, y, z - Cartesian coordinates in meters

            local_radius = earthRadius + obj.altitude;
            x = local_radius .* cosd(obj.latitude) .* cosd(obj.longitude);
            y = local_radius .* cosd(obj.latitude) .* sind(obj.longitude);
            z = local_radius .* sind(obj.latitude);
        end


        function shadowed = isEarthShadowed(obj1, obj2)
        % isEarthShadowed
        %
        % Determine whether the line-of-sight between two objects is obstructed
        % by the Earth.
        %
        % Syntax:
        % shadowed = obj1.isEarthShadowed(obj2)
        %
        % Output:
        % shadowed - logical array indicating shadowing

            [x1, y1, z1] = obj1.getXyz();
            pos1 = [x1, y1, z1];

            [x2, y2, z2] = obj2.getXyz();
            pos2 = [x2, y2, z2];

            dot_product = sum(pos1 .* pos2, 2);
            lambda_min = (utilities.row2Norms(pos1).^2 - dot_product) ...
                ./ (utilities.row2Norms(pos1).^2 + utilities.row2Norms(pos2).^2 - 2 .* dot_product);

            pos_min = pos1 .* (1 - lambda_min) + pos2 .* lambda_min;

            if isvector(pos1)
                pos_min(lambda_min < 0, :) = ones(sum(lambda_min < 0), 1) * pos1;
            else
                pos_min(lambda_min < 0, :) = pos1(lambda_min < 0, :);
            end

            if isvector(pos2)
                pos_min(lambda_min > 1, :) = ones(sum(lambda_min > 1), 1) * pos2;
            else
                pos_min(lambda_min > 1, :) = pos2(lambda_min > 1, :);
            end

            r_min = utilities.row2Norms(pos_min);
            shadowed = r_min < obj1.earth_radius;
        end


        function direction_vector = computeDirection(obj1, obj2)
        % computeDirection
        %
        % Compute a normalized ENU direction vector from obj2 to obj1.
        %
        % Syntax:
        % direction_vector = obj1.computeDirection(obj2)
        %
        % Output:
        % direction_vector - n-by-3 array of unit vectors

            enu_vector = obj1.computeRelativeCoords(obj2);
            direction_vector = enu_vector ./ utilities.row2Norms(enu_vector);
        end
    end
end