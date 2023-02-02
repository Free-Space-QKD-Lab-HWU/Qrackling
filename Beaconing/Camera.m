classdef Camera
    %CAMERA a camera (and included optics) used to detect pointing and tracking beacons

    %% NOTE:
    % it is convention in CMOS and CCD cameras to record noise in terms of
    % charge, in particular the charge on an electron (e-). Therefore SNR
    % calculation etc. will need signal in terms of photons and photon rate,
    % rather than power. We then operate on the assumption of 100% absorption so
    % that every incident photon creates a single electron charge in the CMOS
    % gate.

    properties (SetAccess=protected, GetAccess=public)
        Telescope (1,1) Telescope =[];
        Collecting_Area (1,1) double {mustBeNonnegative}                        %the optics area which collects beacon light, usually the telescope effective area
        Detector_Diameter (1,1) double {mustBeNonnegative}=0.001                %the physical size of the camera's detector area
        Focal_Length (1,1) double {mustBeNonnegative}=0.0125;                   %focal length (in m) of the lens focussing onto the camera's sensor
        Quantum_Efficiency (1,1) double {mustBeNonnegative,mustBeLessThanOrEqual(Quantum_Efficiency,1)}=1; %the efficiency of the camera at collecting beacon light which arrives on a pixel
        Exposure_Time (1,1) double {mustBePositive} = 1;                    %exposure time for operation of the camera in s


        Spectral_Filter_Width (1,1) double {mustBeNonnegative}=10;              %the spectral width of the (assumed brick-wall) filter on the camera

        Readout_Noise (1,1) double = 1.3E-11;                                   %noise equivalent power (in J per exposure) incurred by reading out a whole image
        Dark_Current_Noise (1,1) double = 0;                                    %noise equivalent power (in J per exposure per s) incurred by exposing the camera per second
        Full_Well_Capacity (1,1) double = 2E-9;                                 %the maximum signal power the camera can tolerate per pixel (in J) before saturating
        %% TODO rescale this full well capacity to account for the test data being over several pixels
    end

    methods
        function C = Camera(Telescope,varargin)
            %CAMERA Construct an instance of a beacon camera
            
            %% using inputParser
            p=inputParser();
            addRequired(p,'Telescope');
            addParameter(p,'Quantum_Efficiency',1);
            addParameter(p,'Exposure_Time', 0.001);
            addParameter(p,'Spectral_Filter_Width',10);
            addParameter(p,'Detector_Diameter',1);
            addParameter(p,'Focal_Length',0.03);
            addParameter(p,'Readout_Noise', 1.3E-11);
            addParameter(p,'Dark_Current', 0);
            addParameter(p,'Full_Well_Capacity',2E-9);
            parse(p,Telescope,varargin{:})
            %get outputs
            C.Telescope = p.Results.Telescope;
            C.Quantum_Efficiency = p.Results.Quantum_Efficiency;
            C.Exposure_Time = p.Results.Exposure_Time;
            C.Spectral_Filter_Width = p.Results.Spectral_Filter_Width;
            C.Detector_Diameter = p.Results.Detector_Diameter;
            C.Focal_Length = p.Results.Focal_Length;
            C.Readout_Noise = p.Results.Readout_Noise;
            C.Dark_Current_Noise = p.Results.Dark_Current;
        end

        function Collecting_Area = get.Collecting_Area(Camera)
            %%GETCOLLECTINGAREA overload get function to get collecting area
            %%from the telescope object owned by camera

            Collecting_Area = Camera.Telescope.Collecting_Area;
        end

        function Actual_FOV = FOV(Camera)
            %% FOV field of view of the camera plus optics, in radians

            %field of view of camera without attached telescope
            Camera_FOV = (Camera.Detector_Diameter/Camera.Focal_Length);
            %field of view of camera looking through telescope
            Actual_FOV = Camera_FOV/Camera.Telescope.Magnification;

        end

        function Total_Efficiency = Total_Efficiency(Camera)
            %%GETTOTALEFFICIENCY efficiency from telescope aperture to detected power in camera
                 Total_Efficiency = Camera.Quantum_Efficiency*Camera.Telescope.Optical_Efficiency;
        end

        function Noise = Noise(Camera)
            %the intrinsic noise (in J) in an exposure which affects SNR
            Noise = Camera.Readout_Noise + Camera.Exposure_Time*Camera.Dark_Current_Noise;
        end

        function [SNR,SNR_dB] = SNR(Camera, InputPower, ExternalNoisePower)
            %% calculate the SNR of a single pixel tracking image, where all power from a beacon is incident on a single pixel.
            
            % Int his function, to conform to standard practice for CMOS
            % cameras, we convert all sources of energy to photon count rates and
            % electron counts and count rates
            

            %% Signal energy
            Signal_Energy = InputPower * Camera.Exposure_Time * Camera.Quantum_Efficiency;
            %simulate saturation of the well (pixel saturation)
            Signal_Photons_Per_Exposure = min(Signal_Energy,Camera.Full_Well_Capacity);

            %% Internal noise
            Internal_Noise_Energy = Camera.Noise;

            %% external noise (optional)
            if nargin == 3
                ExternalNoiseEnergy = ExternalNoisePower * Camera.Exposure_Time;
            end


            %% compute SNR
            SNR = Signal_Photons_Per_Exposure ./ (ExternalNoiseEnergy + Internal_Noise_Energy);
            SNR_dB = 10*log10(SNR);

        end
    end
end