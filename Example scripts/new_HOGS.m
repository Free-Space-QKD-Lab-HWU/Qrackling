function hogs = new_HOGS(wavelength)
    arguments
        wavelength {mustBeMember(wavelength, [785, 808, 1550])}
    end
    assert( ismember(wavelength, [785,808,1550] ), ...
        'Wavelength must be one of the intended channels, 780, 808 or 1550 (nm)');

    telescope = components.Telescope( ...
        0.7, ...
        'Pointing_Jitter', 1e-6,...
        'Optical_Efficiency', (1-0.3^2)*10^(-1.1/10),...
        'Focal_Length', 8.4,...
        'Eyepiece_Focal_Length', 0.076);


    filter_file = '~/Projects/QKD_Sat_Link/adaptive_optics/Example Data/spectral filters';
    %Detector
    switch wavelength
        case 785
            channel_wavelength = 785;
            repetition_rate = 1E8;
            time_gate = 2E-9;
            spectral_filter = SpectralFilter('input_file',[filter_file, filesep(),'FBH780-10.xlsx']);

        case 808
            channel_wavelength = 808;
            repetition_rate = 1E8;
            time_gate = 2E-9;
            spectral_filter = SpectralFilter('input_file',[filter_file, filesep(),'FBH850-10.xlsx']);

        case 1550
            channel_wavelength = 1550;
            repetition_rate = 1;
            time_gate = 1;
            spectral_filter = SpectralFilter('input_file',[filter_file, filesep(),'FBH1550-12.xlsx']);
    end

    detector = components.Detector( channel_wavelength, repetition_rate, ...
        time_gate, spectral_filter, ...
        "Preset", components.loadPreset("Excelitas") );


    camera_telescope = components.Telescope( 0.4, ...
        'Wavelength', 685, ...
        'Optical_Efficiency', 1 - 0.39^2, ...
        'Focal_Length', 2.72, ...
        'Pointing_Jitter', 1e-3);

    exposure_time = 0.01;
    spectral_filter_width = 10;
    camera = AC4040(camera_telescope, exposure_time, spectral_filter_width);

    beacon_power = 40E-3;
    beacon_wavelength = 850;
    beacon_pointing_precision = 1E-6;
    beacon_beam_divergence = 0.0070;
    beacon_telescope = SetWavelength(telescope, beacon_wavelength);
    beacon_telescope = SetFOV(beacon_telescope, beacon_beam_divergence);
    beacon_efficiency = 1;
    gaussian_beacon = beacon.Gaussian_Beacon( ...
        beacon_telescope, beacon_power, beacon_wavelength,...
        "Power_Efficiency", beacon_efficiency, "Pointing_Jitter", beacon_pointing_precision);

    sky_brightness = '~/Projects/QKD_Sat_Link/adaptive_optics/Example Data/orbit modelling resources/background count rate files/Errol_Experimental_Sky_Brightness_Store.mat';

    hogs = nodes.Ground_Station(telescope,...
        'Detector', detector,...
        'Camera', camera, ...
        'Beacon', gaussian_beacon, ...
        'Sky_Brightness_Store_Location', sky_brightness, ...
        'LLA', [55.909723, -3.319995,10],...
        'name', 'Heriot Watt');

        %'Beacon', HOGSBeacon,...
end
