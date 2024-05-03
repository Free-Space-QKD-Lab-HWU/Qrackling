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
        Name = " ";
 
        ToolboxObj {nodes.mustBeToolboxObjorEmpty} = [];
        HasToolboxObj (1,1) logical = false;
    end
    properties(Constant=true, Hidden=true)
        % radius of the earth in m (used to compute shadowing)
        Earth_Radius = earthRadius()
    end

    methods
        function lla = LLA(Located_Object)
            %GETLLA return latitude, longitude and altitude as an nx3 array
            
            %if this object has a toolbox representation, use it to get
            %states
            if Located_Object.HasToolboxObj
                if isa(Located_Object.ToolboxObj,'matlabshared.satellitescenario.GroundStation')
                    lla = [Located_Object.ToolboxObj.Latitude,...
                           Located_Object.ToolboxObj.Longitude,...
                           Located_Object.ToolboxObj.Altitude];
                else
                lla = states(Located_Object.ToolboxObj,CoordinateFrame='geographic')';
                end

            end
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

        function ENUs = ComputeRelativeCoords(Located_Obj_1, Located_Obj_2)
            %%COMPUTERELATIVECOORDS compute the ENU coords of located
            %%object 1 relative to located object 2

                [Headings,Elevations,Ranges] = aer(Located_Obj_2.ToolboxObj,Located_Obj_1.ToolboxObj);
                [East,North,Up] = aer2enu(Headings',Elevations',Ranges');
                ENUs = [East,North,Up];

            %{
            DEPRECATED
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
            %}
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

           
                [Headings,Elevations,Distances]=aer(Located_Obj_2.ToolboxObj,Located_Obj_1.ToolboxObj);

            %{
            DEPRECATED
            %% get ENU of 1 from 2
            ENUs = ComputeRelativeCoords(Located_Obj_1, Located_Obj_2);

            %% compute heading and elevation from ground station
            [Headings, Elevations] = utilities.HeadingAndElevation(ENUs);

            %% transpose into row vectors
            Headings = Headings';
            Elevations = Elevations';

            %% if needed, compute distances
            Distances = utilities.Row2Norms(ENUs)';
            %}
        end

        function [X, Y, Z] = GetXYZ(Located_Object)
            %%GETXYZ return the position of the located object wrt to the
            %%central coordinate system of the earth
            %%(https://www.nosco.ch/mathematics/en/earth-coordinates.php#:~:text=The%20usual%20cartesian%20coordinate%20system%20associated%20with%20the,its%20positive%20direction%20is%20towards%20the%20north%20pole.)

                if isa(Located_Object.ToolboxObj,'matlabshared.satellitescenario.GroundStation')
                    %if ground station, get lat lon alt
                    lla = Located_Object.LLA;

                    %then use geometry to convert
                    Local_Radius = earthRadius + lla(3);
                    % convert to XYZ
                    X = Local_Radius .* cosd(lla(1)) .* cosd(lla(2));
                    Y = Local_Radius .* cosd(lla(1)) .* sind(lla(2));
                    Z = Local_Radius .* sind(lla(1));
                else
                xyz = states(Located_Object.ToolboxObj,CoordinateFrame='ecef');
                X = xyz(1,:);
                Y = xyz(2,:);
                Z = xyz(3,:);
                end
        end

        function ShadowFlag = IsEarthShadowed(Located_obj_1, Located_obj_2)
            %%ISEARTHSHADOWED return a flag which is true if the line of
            %%sight between these objects runs below the earth's surface
            %%and therefore the earth shadows their intervisibility

            %if either is a ground station, set visibility limit of the
            %underlying object to 0
            if isa(Located_obj_1,'nodes.Ground_Station')
                Located_obj_1.ToolboxObj.MinElevationAngle = 0;
            end
            if isa(Located_obj_2,'nodes.Ground_Station')
                Located_obj_2.ToolboxObj.MinElevationAngle = 0;
            end

            %then determine access
            AccessObj = access(Located_obj_1.ToolboxObj,...
                            Located_obj_2.ToolboxObj);

            ShadowFlag = ~ accessStatus(AccessObj);
            %{
            DEPRECATED
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
            %}
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

        function lat = Latitude(Located_Object)
            %%LATITUDE return location latitude, as a vector for a mobile
            %%location or as a scalar for a static location

                if isa(Located_Object.ToolboxObj,'matlabshared.satellitescenario.GroundStation')
                    lat = Located_Object.ToolboxObj.Latitude;
                else
                lla = states(Located_Object.ToolboxObj,CoordinateFrame='geographic');
                lat = lla(1,:)';
                end
        end

        function lon = Longitude(Located_Object)
            %%LONGITUDE return location longitude, as a vector for a mobile
            %%location or as a scalar for a static location

                if isa(Located_Object.ToolboxObj,'matlabshared.satellitescenario.GroundStation')
                    lon = Located_Object.ToolboxObj.Longitude;
                else
                lla = states(Located_Object.ToolboxObj,CoordinateFrame='geographic');
                lon = lla(2,:)';
                end
        end

        function alt = Altitude(Located_Object)
            %%ALTITUDE return location altitude (in m), as a vector for a mobile
            %%location or as a scalar for a static location

                if isa(Located_Object.ToolboxObj,'matlabshared.satellitescenario.GroundStation')
                    alt = Located_Object.ToolboxObj.Altitude;
                else
                lla = states(Located_Object.ToolboxObj,CoordinateFrame='geographic');
                alt = lla(3,:)';
                end
        end

        function n = N_Position(Located_Object)
            %%N_POSITION return the number of timesteps at which an object
            %%is simulated

                n = numel(Located_Object.Latitude);
        end
    end
end
