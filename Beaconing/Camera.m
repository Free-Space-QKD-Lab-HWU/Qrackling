classdef Camera
    %CAMERA a camera (and included optics) used to detect pointing and tracking beacons

    properties (SetAccess=protected, GetAccess=public)
        Telescope (1,1) Telescope =[];
        Collecting_Area (1,1) double {mustBeNonnegative}                        %the optics area which collects beacon light, usually the telescope effective area
        Detection_Efficiency (1,1) double {mustBeNonnegative,mustBeLessThanOrEqual(Detection_Efficiency,1)}=1; %the efficiency of the camera at collecting beacon light
        Noise (1,1) double {mustBeNonnegative}=1E-9;                            %the intrinsic noise (W) in the whole camera which affects SNR
        Spectral_Filter_Width (1,1) double {mustBeNonnegative}=10;              %the spectral width of the (assumed brick-wall) filter on the camera
        FOV (1,1) double {mustBeNonnegative}                                    %field of view of the camera plus optics, in radians
        Total_Efficiency (1,1) double {mustBeNonnegative,mustBeLessThanOrEqual(Total_Efficiency,1)}=1 %efficiency from telescope aperture to detected power in camera
    end

    methods
        function C = Camera(Telescope,varargin)
            %CAMERA Construct an instance of a beacon camera
            
            %% using inputParser
            p=inputParser();
            addRequired(p,'Telescope');
            addParameter(p,'Detection_Efficiency',1);
            addParameter(p,'Noise',1E-9);
            addParameter(p,'Spectral_Filter_Width',10);
            parse(p,Telescope,varargin{:})
            %get outputs
            C.Telescope = p.Results.Telescope;
            C.Detection_Efficiency = p.Results.Detection_Efficiency;
            C.Noise = p.Results.Noise;
            C.Spectral_Filter_Width = p.Results.Spectral_Filter_Width;
        end

        function Collecting_Area = get.Collecting_Area(Camera)
            %%GETCOLLECTINGAREA overload get function to get collecting area
            %%from the telescope object owned by camera

            Collecting_Area = Camera.Telescope.Collecting_Area;
        end

        function FOV = get.FOV(Camera)
            %%GETCOLLECTINGAREA overload get function to get collecting area
            %%from the telescope object owned by camera

            FOV = Camera.Telescope.FOV;
        end

        function Total_Efficiency = get.Total_Efficiency(Camera)
            %%GETTOTALEFFICIENCY overload the get function to return the total
            %%efficiency of the camera
                 Total_Efficiency = Camera.Detection_Efficiency*Camera.Telescope.Optical_Efficiency;
        end
    end
end