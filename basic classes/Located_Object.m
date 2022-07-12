classdef (Abstract=true)Located_Object
    %LOCATED_OBJECT object containing latitude, longitude and altitude position data,
    %possibly for many time stamps

    properties(SetAccess=protected)
        Latitude(:,1){mustBeNumeric}=nan;                                  %N dimensional column vector containing latitude
        Longitude(:,1){mustBeNumeric}=nan;                                 %N dimensional column vector containing longitude
        Altitude(:,1){mustBeNumeric}=nan;                                  %N dimensional column vector containing altitude
        Location_Name{mustBeText}='';                                      %name of location
    end
    properties(SetAccess=protected,Hidden=true)
        N_Position{mustBeInteger,mustBePositive}=1;                        %number of entries in LLA_Array
    end
    properties(Constant=true,Hidden=true)
        Earth_Radius=earthRadius()                                         %radius of the earth in m (used to compute shadowing)
    end

    methods
        function LLA = GetLLA(Located_Object)
            %GETLLA return latitude, longitude and altitude as an nx3 array
            LLA = [Located_Object.Latitude,Located_Object.Longitude,Located_Object.Altitude];
        end

        function Located_Object=SetPosition(Located_Object,varargin)
            %%SETPOSITION set the position properties of a location object

            switch nargin
                case 2
                    %if 1 input, assume input is an nx3 array
                    LLA=varargin{1};
                    sz=size(LLA);%check dimensions of LLA
                    if ~sz(2)==3
                        error('LLA array must be nx3')
                    else
                        Located_Object.N_Position=sz(1);
                    end

                    Located_Object.Latitude=LLA(1);
                    Located_Object.Longitude=LLA(2);
                    Located_Object.Altitude=LLA(3);
                case 3
                    %if 2 inputs, assume input1 is an nx3 array and 2 is a
                    %name
                    LLA=varargin{1};
                    sz=size(LLA);%check dimensions of LLA
                    if ~sz(2)==3
                        error('LLA array must be nx3')
                    else
                        Located_Object.N_Position=sz(1);
                    end

                    Located_Object.Latitude=LLA(1);
                    Located_Object.Longitude=LLA(2);
                    Located_Object.Altitude=LLA(3);
                    Located_Object.Location_Name=varargin{2};
                case 4
                    %if 3 inputs, assume latitude, longitude and altitude
                    if ~AreSameSize(varargin{1},varargin{2},varargin{3})
                        error('latitude, longitude and altitude must be same sized vectors');
                    else
                        Located_Object.N_Position=numel(varargin{1});
                    end
                    Located_Object.Latitude=varargin{1};
                    Located_Object.Longitude=varargin{2};
                    Located_Object.Altitude=varargin{3};
                case 5
                    %if 4 inputs, assume lat,lon,alt and name
                    if ~AreSameSize(varargin{1},varargin{2},varargin{3})
                        error('latitude, longitude and altitude must be same sized vectors');
                    else
                        Located_Object.N_Position=numel(varargin{1});
                    end
                    Located_Object.Latitude=varargin{1};
                    Located_Object.Longitude=varargin{2};
                    Located_Object.Altitude=varargin{3};
                    Located_Object.Location_Name=varargin{4};
                otherwise
                    error('must provide latitude, longitude and altitude with optional location name separately')
            end
        end

        function ENUs=ComputeRelativeCoords(Located_Obj_1,Located_Obj_2)
            %%COMPUTERELATIVECOORDS compute the ENU coords of located
            %%object 1 relative to located object 2

            %% need to vary behaviour dependent on number of position data time stamps in each object
            if Located_Obj_1.N_Position==1&&Located_Obj_2.N_Position==1
                %1 location from each object
                ENUs=lla2enu(GetLLA(Located_Obj_1),GetLLA(Located_Obj_2),'ellipsoid');

            elseif Located_Obj_1.N_Position>1&&Located_Obj_2.N_Position==1
                % multiple locations from first object
                ENUs=zeros(Located_Obj_1.N_Position,3);
                LLA1=GetLLA(Located_Obj_1);
                for i=1:Located_Obj_1.N_Position
                    ENUs(i,:)=lla2enu(LLA1(i,:),GetLLA(Located_Obj_2),'ellipsoid');
                end

            elseif Located_Obj_1.N_Position==1&&Located_Obj_2.N_Position>1
                % multiple locations from second object
                ENUs=zeros(Located_Obj_2.N_Position,3);
                LLA2=GetLLA(Located_Obj_2);
                for i=1:Located_Obj_2.N_Position
                    ENUs(i,:)=lla2enu(GetLLA(Located_Obj_1),LLA2(i,:),'ellipsoid');
                end

            elseif Located_Obj_1.N_Position>1&&Located_Obj_2.N_Position>1
                % multiple locations from both objects
                if Location_Obj_1.N_Position~=Location_Obj_2.N_Position
                    error('location objects provided do not have same number of position entries')
                end

                ENUs=zeros(Located_Obj_2.N_Position,3);
                LLA1=GetLLA(Located_Obj_1);
                LLA2=GetLLA(Located_Obj_2);
                for i=1:Located_Obj_2.N_Position
                    ENUs(i,:)=lla2enu(LLA1(i,:),LLA2(i,:),'ellipsoid');
                end
            else
                error('can provide objects with the same number of position entries, and/or one with a single position entry')
            end

        end

        function Distance=ComputeDistanceBetween(Located_Obj_1,Located_Obj_2)
            %%COMPUTEDISTANCEBETWEEN return the distance(s) in m between
            %%the two located objects

            %compute relative coords
            ENUs=ComputeRelativeCoords(Located_Obj_1,Located_Obj_2);
            %take magnitude for distances
            Distance=Row2Norms(ENUs);
        end

        function [Headings,Elevations,Distances]=RelativeHeadingAndElevation(Located_Obj_1,Located_Obj_2)
            %%RELATIVEHEADINGANDELEVATION return the heading and elevation
            %%of object 1 relative to object 2
            %% get ENU of 1 from 2
            ENUs=ComputeRelativeCoords(Located_Obj_1,Located_Obj_2);

            %% compute heading and elevation from ground station
            [Headings,Elevations]=HeadingAndElevation(ENUs);

            %% transpose into row vectors
            Headings=Headings';
            Elevations=Elevations';

            %% if needed, compute distances
            Distances=Row2Norms(ENUs);
        end

        function XYZcoords=GetXYZ(Located_obj_1)
            %%GETXYZ return the position of the located object wrt to the
            %%central coordinate system of the earth
            %%(https://www.nosco.ch/mathematics/en/earth-coordinates.php#:~:text=The%20usual%20cartesian%20coordinate%20system%20associated%20with%20the,its%20positive%20direction%20is%20towards%20the%20north%20pole.)

            %find lat, lon, alt
            Latitude=Located_obj_1.Latitude; %#ok<*PROP>
            Longitude=Located_obj_1.Longitude;
            Altitude=Located_obj_1.Altitude;
            Local_Radius=(earthRadius+Altitude);
            % convert to XYZ
            X=Local_Radius.*cosd(Latitude).*cosd(Longitude);
            Y=Local_Radius.*cosd(Latitude).*sind(Longitude);
            Z=Local_Radius.*sind(Latitude);

            %output
            XYZcoords=[X,Y,Z];
        end

        function ShadowFlag=IsEarthShadowed(Located_obj_1,Located_obj_2)
            %%ISEARTHSHADOWED return a flag which is true if the line of
            %%sight between these objects runs below the earth's surface
            %%and therefore the earth shadows their intervisibility

            %% get the two XYZ positions of the two objects
            Pos_1=GetXYZ(Located_obj_1);
            Pos_2=GetXYZ(Located_obj_2);

            %% determine the minimum radius from earth's centre of the line between these two
            Dot_product=sum(Pos_1.*Pos_2,2);
            Lambda_min=(Row2Norms(Pos_1).^2-Dot_product)./(Row2Norms(Pos_1).^2+Row2Norms(Pos_2).^2-2.*Dot_product); %nondimensional parameter descrbing position of minimum radius point
            Pos_min=Pos_1.*(1-Lambda_min)+Pos_2.*Lambda_min;
            %check lambda for not being inside bounds
                %if Lambda_min is <0 this indicates the the first position
                %is the lowest radius
                %Pos_1 may be an array or a vector
                if isvector(Pos_1)
                Pos_min(Lambda_min<0,:)=ones(sum(Lambda_min<0),1)*Pos_1;
                else
                Pos_min(Lambda_min<0,:)=Pos_1(Lambda_min<0,:);
                end
                %if lambda_min>1 this indicates that the 2nd position is
                %the lowest radius
                if isvector(Pos_2)
                Pos_min(Lambda_min>1,:)=ones(sum(Lambda_min>1),1)*Pos_2;
                else
                Pos_min(Lambda_min>1,:)=Pos_2(Lambda_min>1,:);
                end

            %produce a located_object at this minimum point by converting
            %to spherical coords and then geographic coords
            R_min=Row2Norms(Pos_min);

            %% if R_min is less than earth radius, shadowing is present
            ShadowFlag=R_min<Located_obj_1.Earth_Radius;
        end

    end


end
