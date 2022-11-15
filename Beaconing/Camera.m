classdef Camera
    %CAMERA a camera (and included optics) used to detect pointing and tracking beacons

    properties (SetAccess=protected, GetAccess=public)
        Collecting_Area (1,1) double {mustBeNonnegative}                        %the optics area which collects beacon light, usually the telescope effective area
        Efficiency (1,1) double {mustBeNonnegative,mustBeLessThanOrEqual(Efficiency,1)}=1; %the efficiency of the camera at collecting beacon light
        Noise (1,1) double {mustBeNonnegative}=1E-9;                            %the intrinsic noise (W) in the whole camera which affects SNR
    end

    methods
        function C = Camera(Collecting_Area,varargin)
            %CAMERA Construct an instance of a beacon camera
            
            %% using inputParser
            p=inputParser();
            addRequired(p,'Collecting_Area');
            addParameter(p,'Efficiency',1);
            addParameter(p,'Noise',1E-9);
            parse(p,Collecting_Area,varargin{:})
            %get outputs
            C.Collecting_Area = p.Results.Collecting_Area;
            C.Efficiency = p.Results.Efficiency;
            C.Noise = p.Results.Noise;
        end
    end
end