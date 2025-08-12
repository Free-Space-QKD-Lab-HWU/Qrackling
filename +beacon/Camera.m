classdef Camera
% Camera
%
% A camera (and included optics) used to detect pointing and tracking
% beacons.
% 
% Syntax:
% C = beacon.Camera(telescope, options)
%
% It is convention in CMOS and CCD cameras to record noise in terms of
% charge, in particular the charge on an electron (e-). Therefore SNR
% calculation etc. will need signal in terms of photons and photon rate,
% rather than power.

    properties (SetAccess=protected, GetAccess=public)
        telescope (1, 1) components.Telescope = []
        collecting_area (1, 1) double {mustBeNonnegative}
        % the physical size of the camera's detector area
        detector_diameter (1, 1) double {mustBeNonnegative} = 0.001
        % focal length (in m) of the lens focussing onto the camera's sensor
        focal_length (1, 1) double {mustBeNonnegative} = 0.0125;
        % the efficiency of the camera at collecting beacon light which arrives on a pixel
        quantum_efficiency  double {mustBeNonnegative,mustBeLessThanOrEqual(quantum_efficiency,1)} = 1;
        % exposure time for operation of the camera in s
        exposure_time (1, 1) double {mustBePositive} = 1;

        % the spectral width of the (assumed brick-wall) filter on the camera
        spectral_filter_width (1, 1) double {mustBeNonnegative} = 10;
        % noise (in coulombs) incurred by reading out a whole image
        readout_noise (1, 1) double = 13;
        % noise (in coulombs) incurred by exposing the camera per second
        dark_current_noise (1, 1) double = 125;
        % the maximum signal (in coulombs) a pixel can tolerate before saturating
        full_well_capacity (1, 1) double = 13500;
        % number of pixels in camera x and y directions
        pixels (1, 2) double {mustBePositive} = [1080, 1080];
    end

    properties (Dependent)
        %the full efficiency of telescope and camera
        total_efficiency (1, 1) double {mustBeScalarOrEmpty}

        %the wavelength in nm at which the camera is operating
        wavelength (1, 1) double {mustBeScalarOrEmpty}

        % the field of view of the imaging sensor through the telescope
        % (rads)
        fov (1, 1) double {mustBeScalarOrEmpty}
    end

    properties (Constant)
        h = 6.626E-34; %plank's constant in Js
        c = 2.998E8; %speed of light in m/s
    end

    methods
        function C = Camera(telescope, options)
            % Camera
            % 
            % Creates a camera object.
            %
            % Syntax:
            % C = beacon.Camera.Camera(telescope, options)
            %
            % Inputs:
            % telescope - scalar Telescope, telescope used to focus on
            % camera
            % 
            % Outputs:
            % C - scalar Camera

            arguments
                telescope components.Telescope
                options.quantum_efficiency = 1
                options.exposure_time =  0.001
                options.spectral_filter_width = 10
                options.detector_diameter = 1
                options.focal_length = 0.03
                options.readout_noise =  1.3E-11
                options.dark_current =  0
                options.full_well_capacity = 2E-9
                options.wavelength = telescope.wavelength
                options.pixels = [1080,1080]
            end

            C.telescope = telescope.setWavelength(options.wavelength);
            C.quantum_efficiency = options.quantum_efficiency;
            C.exposure_time = options.exposure_time;
            C.spectral_filter_width = options.spectral_filter_width;
            C.detector_diameter = options.detector_diameter;
            C.focal_length = options.focal_length;
            C.readout_noise = options.readout_noise;
            C.dark_current_noise = options.dark_current;
            C.full_well_capacity = options.full_well_capacity;
            C.pixels = options.pixels;
        end

        function area = get.collecting_area(Camera)
            % get.collecting_area
            % 
            % Returns collecting area of the camera, which is defined by
            % the area of the telescope used.
            %
            % Syntax:
            % area = Camera.collecting_area
            %
            % Inputs:
            % Camera - scalar Camera
            
            % 
            % Outputs:
            % area - scalar numeric, collecting area of camera in m^2


            area = Camera.telescope.collecting_area;
        end

        function fov = get.fov(Camera)
            % fov
            % 
            % Returns the field of view of the camera.
            %
            % Syntax:
            % fov = fov(Camera)
            %
            % Inputs:
            % Camera - scalar Camera
            % 
            % Outputs:
            % fov - scalar numeric, field of view of the camera in radians
            % (not steradians)

            %field of view of camera without attached telescope
            Camera_FOV = (Camera.detector_diameter/Camera.focal_length);
            %field of view of camera looking through telescope
            fov = Camera_FOV/Camera.telescope.magnification;

        end

        function wl = get.wavelength(Camera)
            % get.wavelength
            % 
            % Returns the wavelength of operation of the camera.
            %
            % Syntax:
            % wl = Camera.wavelength
            %
            % Inputs:
            % Camera - scalar Camera
            % 
            % Outputs:
            % wl - scalar numeric, wavelength of camera in nm
            wl = Camera.telescope.wavelength;
        end

        function E = photonEnergy(Camera)
            % photonEnergy
            % 
            % Returns the energy of a photon at the operation wavelength of
            % the camera.
            %
            % Syntax:
            % E = photonEnergy(Camera)
            %
            % Inputs:
            % Camera - scalar Camera
            % 
            % Outputs:
            % E - scalar numeric, energy of a photon in Joules.
            E = Camera.h*Camera.c./(Camera.wavelength*1E-9);
        end

        function te = get.total_efficiency(Camera)
            % totalEfficiency
            % 
            % Returns the end-to-end power efficiency of the camera
            %
            % Syntax:
            % te = totalEfficiency(Camera)
            %
            % Inputs:
            % Camera - scalar Camera
            % 
            % Outputs:
            % te - scalar numeric, efficiency in absolute units (0,1)
            te = Camera.quantum_efficiency*Camera.telescope.optical_efficiency;
        end

        function n = noise(Camera)
            % noise
            % 
            % Returns the background noise per pixel of the camera in
            % electrons (e-)
            %
            % Syntax:
            % n = noise(Camera)
            %
            % Inputs:
            % Camera - scalar Camera
            % 
            % Outputs:
            % n - scalar numeric, background noise per pixel in electrons
            n = sqrt(Camera.readout_noise^2 + (Camera.exposure_time*Camera.dark_current_noise)^2);
        end

        function [snr,snr_dB] = snr(Camera, input_power, external_noise)
            % snr
            % 
            % returns the signal to noise ratio of the camera tracking
            % image of a beacon.
            %
            % Syntax:
            % [snr,snr_dB] = snr(Camera, input_power, external_noise)
            %
            % Inputs:
            % Camera - scalar Camera
            % input_power - array numeric, received beacon power in W
            % external noise - array numeric (matching input_power shape),
            % noise power in W
            % 
            % Outputs:
            % snr - v numeric (matching input_power shape),
            % background noise per pixel in electrons
            %
            % In this function, to conform to standard practice for CMOS
            % cameras, we convert all sources of energy to photon count rates and
            % electron counts and count rates.

            %% Signal energy
            signal_energy = input_power * Camera.exposure_time * Camera.quantum_efficiency;
            signal_photons = signal_energy./Camera.photonEnergy;

            %simulate saturation of the well (pixel saturation)
            signal_photons_per_exposure = min(signal_photons,Camera.full_well_capacity);


            %% shot noise
            %shot noise goes as the square root of the incident photon rate
            shot_noise = sqrt(signal_photons_per_exposure);


            %% external noise (optional)
            if nargin == 3
                external_noise_photon_rate = external_noise / Camera.photonEnergy;
                external_noise_photons = external_noise_photon_rate ...
                    * Camera.exposure_time ...
                    * Camera.totalEfficiency;
            else
                external_noise_photons = 0;
            end


            %% compute SNR
            snr = signal_photons_per_exposure ./ sqrt(external_noise_photons.^2 + Camera.noise.^2 + shot_noise);
            snr_dB = 10*log10(snr);

        end
    end
end
