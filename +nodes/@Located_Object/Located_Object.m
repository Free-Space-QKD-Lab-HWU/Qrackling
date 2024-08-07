%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22


% To-DO
% - Add velocity calculations
%   - Satellite toolbox already returns velocities to us, just needs a coord transform
%   - Would be convenient to have a function that can calculated the relative
%       velocity between two objects, especially useful for apparent satellite
%       motion relative to a ground station

%classdef (Abstract=true)Located_Object
classdef Located_Object
    %object containing latitude, longitude and altitude position data,
    %possibly for many time stamps

    properties(SetAccess=protected)
        Latitude (:,1) {mustBeNumeric} = [];
        Longitude (:,1) {mustBeNumeric} = [];
        Altitude (:,1) {mustBeNumeric} = [];
        Velocity_East (:,1) {mustBeNumeric} = [];
        Velocity_North (:,1) {mustBeNumeric} = [];
        Velocity_Up (:,1) {mustBeNumeric} = [];
        Location_Name = "";
        useSatCommsToolbox{mustBeNumericOrLogical} = false;
        % Length of Latitude, Longitude, Altitude arrays
        % (must all be same length)
        N_Position{mustBeInteger, mustBePositive} = 1;
    end
    properties(Constant=true, Hidden=true)
        % radius of the earth in m (used to compute shadowing)
        Earth_Radius = earthRadius()
    end

    methods
        function LLA = GetLLA(Located_Object)
            %GETLLA return latitude, longitude and altitude as an nx3 array
            LLA = [Located_Object.Latitude, ...
                Located_Object.Longitude, ...
                Located_Object.Altitude];
        end

        function Located_Object = SetPosition(Located_Object, options)
            %%SETPOSITION set the position properties of a location object

            %disp(nargin);

            %if ~(nargin > 1 && nargin < 6)
            %    error('Recieved:\t%d arguments\n\tExpected [1 -> 6] as input (1 positional, 4 optional)');
            %end

            arguments
                Located_Object
                options.LLA {mustBeNumeric} = []
                options.Latitude {mustBeNumeric} = []
                options.Longitude {mustBeNumeric} = []
                options.Altitude {mustBeNumeric} = []
                options.Name
            end

            if ~isempty(options.LLA)
                Located_Object.Latitude  = options.LLA(1);
                Located_Object.Longitude = options.LLA(2);
                Located_Object.Altitude  = options.LLA(3);
                Located_Object.N_Position = numel(options.LLA(1));
                return
            end

            if all(~isempty([options.Latitude, options.Longitude, options.Altitude]))
                Located_Object.Latitude  = options.Latitude;
                Located_Object.Longitude = options.Longitude;
                Located_Object.Altitude  = options.Altitude;
                Located_Object.N_Position = numel(options.Latitude);
                return
            end

            error('Failed to initialise object: LLA or latitude, longitude altitude vectors incorrect format');

            % if initialised == true
            %     return
            % else
            %     error('Failed to initialise object: LLA or latitude, longitude altitude vectors incorrect format');
            % end
        end

        function Located_Object = SetVelocities(Located_Object, velEast, velNorth, velUp)
            Located_Object.Velocity_East = velEast;
            Located_Object.Velocity_North = velNorth;
            Located_Object.Velocity_Up = velUp;
        end

        function ENUs = ComputeRelativeCoords(Located_Obj_1, Located_Obj_2)
            %%COMPUTERELATIVECOORDS compute the ENU coords of located
            %%object 1 relative to located object 2

            % optionally we can go directly from satelliteCommunicationsToolbox
            % objects like ground stations and satellites directly to relative
            % coordinates. By default it emits azimuth, elevation and range
            % which can be converted into ENU

            %1 location from each object
            if Located_Obj_1.N_Position == 1 && Located_Obj_2.N_Position == 1
                ENUs = lla2enu(GetLLA(Located_Obj_1), ...
                    GetLLA(Located_Obj_2), ...
                    'ellipsoid');
                return
            end

            % multiple locations from first object
            if Located_Obj_1.N_Position > 1 && Located_Obj_2.N_Position == 1
                ENUs = zeros(Located_Obj_1.N_Position, 3);
                LLA1 = GetLLA(Located_Obj_1);

                for i = 1:Located_Obj_1.N_Position
                    ENUs(i,:)=lla2enu(LLA1(i,:), ...
                        GetLLA(Located_Obj_2), ...
                        'ellipsoid');
                end
                return;
            end

            % multiple locations from second object
            if Located_Obj_1.N_Position == 1 && Located_Obj_2.N_Position > 1
                ENUs = zeros(Located_Obj_2.N_Position, 3);
                LLA2 = GetLLA(Located_Obj_2);

                for i = 1:Located_Obj_2.N_Position
                    ENUs(i,:) = lla2enu(GetLLA(Located_Obj_1), ...
                        LLA2(i,:), ...
                        'ellipsoid');
                end
                return;
            end

            % multiple locations from both objects
            if Located_Obj_1.N_Position > 1 && Located_Obj_2.N_Position > 1
                if Location_Obj_1.N_Position ~= Location_Obj_2.N_Position
                    error('location objects provided do not have same number of position entries')
                end

                ENUs = zeros(Located_Obj_2.N_Position, 3);
                LLA1 = GetLLA(Located_Obj_1);
                LLA2 = GetLLA(Located_Obj_2);

                for i = 1:Located_Obj_2.N_Position
                    ENUs(i,:) = lla2enu(LLA1(i,:), ...
                        LLA2(i,:), ...
                        'ellipsoid');
                end
                return;
            end

            error('can provide objects with the same number of position entries, and/or one with a single position entry')
            ENUs = nan;
        end

        function Distance = ComputeDistanceBetween(Located_Obj_1, Located_Obj_2)
            %%COMPUTEDISTANCEBETWEEN return the distance(s) in m between
            %%the two located objects

            %compute relative coords
            ENUs = ComputeRelativeCoords(Located_Obj_1, Located_Obj_2);
            %take magnitude for distances
            Distance = utilities.Row2Norms(ENUs)';
        end

        function [Headings, Elevations, Distances] = RelativeHeadingAndElevation(Located_Obj_1, ...
                Located_Obj_2)
            %%RELATIVEHEADINGANDELEVATION return the heading and elevation
            % [H, E, D] == [Headings, Elevations, Distances]
            %%of object 1 relative to object 2
            %% get ENU of 1 from 2
            ENUs = ComputeRelativeCoords(Located_Obj_1, Located_Obj_2);

            %% compute heading and elevation from ground station
            [Headings, Elevations] = utilities.HeadingAndElevation(ENUs);

            %% transpose into row vectors
            Headings = Headings';
            Elevations = Elevations';

            %% if needed, compute distances
            Distances = utilities.Row2Norms(ENUs)';
        end

        function [X, Y, Z] = GetXYZ(Loc_obj)
            %%GETXYZ return the position of the located object wrt to the
            %%central coordinate system of the earth
            %%(https://www.nosco.ch/mathematics/en/earth-coordinates.php#:~:text=The%20usual%20cartesian%20coordinate%20system%20associated%20with%20the,its%20positive%20direction%20is%20towards%20the%20north%20pole.)

            Local_Radius = earthRadius + Loc_obj.Altitude;
            % convert to XYZ
            X = Local_Radius .* cosd(Loc_obj.Latitude) .* cosd(Loc_obj.Longitude);
            Y = Local_Radius .* cosd(Loc_obj.Latitude) .* sind(Loc_obj.Longitude);
            Z = Local_Radius .* sind(Loc_obj.Latitude);
        end

        function ShadowFlag = IsEarthShadowed(Located_obj_1, Located_obj_2)
            %%ISEARTHSHADOWED return a flag which is true if the line of
            %%sight between these objects runs below the earth's surface
            %%and therefore the earth shadows their intervisibility

            %% get the two XYZ positions of the two objects
            [X1,Y1,Z1] = GetXYZ(Located_obj_1);
            Pos_1=[X1,Y1,Z1];

            [X2,Y2,Z2] = GetXYZ(Located_obj_2);
            Pos_2=[X2,Y2,Z2];
            %% determine the minimum radius from earth's centre of the line between these two
            Dot_product = sum(Pos_1 .* Pos_2,2);
            Lambda_min = (utilities.Row2Norms(Pos_1).^2 ...
                - Dot_product) ./ ...
                (utilities.Row2Norms(Pos_1).^2 ...
                + utilities.Row2Norms(Pos_2).^2 ...
                - 2 .* Dot_product);

            Pos_min = Pos_1 .* (1 - Lambda_min) + Pos_2 .* Lambda_min;
            %check lambda for not being inside bounds
            %if Lambda_min is <0 this indicates the the first position
            %is the lowest radius
            %Pos_1 may be an array or a vector
            if isvector(Pos_1)
                Pos_min(Lambda_min<0,:) = ones(sum(Lambda_min<0),1) * Pos_1;
            else
                Pos_min(Lambda_min<0,:) = Pos_1(Lambda_min<0,:);
            end
            %if lambda_min>1 this indicates that the 2nd position 9is
            %the lowest radius
            if isvector(Pos_2)
                Pos_min(Lambda_min>1,:) = ones(sum(Lambda_min>1),1) * Pos_2;
            else
                Pos_min(Lambda_min>1,:) = Pos_2(Lambda_min>1,:);
            end

            %produce a located_object at this minimum point by converting
            %to spherical coords and then geographic coords
            R_min = utilities.Row2Norms(Pos_min);

            %% if R_min is less than earth radius, shadowing is present
            ShadowFlag = R_min < Located_obj_1.Earth_Radius;
        end

        function Direction_Vector = ComputeDirection(Located_Obj_1,Located_Obj_2)
            %%COMPUTEDIRECTION compute a normalised (2-norm = 1) ENU direction
            %%vector representing the direction of Located_Obj_1 from
            %%Located_Onj_2

            %% first compute full vector between them in ENU space
            ENU_Vector = ComputeRelativeCoords(Located_Obj_1,Located_Obj_2);

            %% then normalise
            Direction_Vector = ENU_Vector./utilities.Row2Norms(ENU_Vector);
        end

    end
end
