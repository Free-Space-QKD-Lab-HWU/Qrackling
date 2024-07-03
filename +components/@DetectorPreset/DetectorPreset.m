classdef DetectorPreset

    properties
        Name {mustBeText} = ''
        Dark_Count_Rate { ...
            mustBeNumeric, ...
            mustBeGreaterThanOrEqual(Dark_Count_Rate, 0)}
        Dead_Time {mustBeNumeric, mustBeGreaterThanOrEqual(Dead_Time, 0)}

        Jitter_Histogram { ...
            mustBeNumeric, ...
            mustBeGreaterThanOrEqual(Jitter_Histogram, 0)}
        Histogram_Bin_Width {mustBeNumeric, mustBePositive}

        Wavelength_Range {mustBeNumeric}
        Efficiencies { ...
            mustBeNumeric, ...
            mustBeGreaterThanOrEqual(Efficiencies, 0) ...
            mustBeLessThanOrEqual(Efficiencies, 1)}
    end

    methods

        function detector = into_detector(preset, options)

            arguments
                preset components.DetectorPreset
                options.n {mustBeGreaterThanOrEqual(options.n, 1)} = 1
            end

            if isscalar(preset)
                wavelength = preset.Wavelength_Range(1);
                clock_rate = 1e6;
                time_gate_width = 1e-9;
                filter_spectral = components.IdealBPFilter(wavelength, 1);

                detector = components.Detector(wavelength, clock_rate, time_gate_width, ...
                                              filter_spectral, "Preset", preset );
                return
            end

            n = numel(preset);
            detector =  components.Detector.empty(0, n);

            for i = 1:n
                wavelength = preset(i).Wavelength_Range(i);
                clock_rate = 1e6;
                time_gate_width = 1e-9;
                filter_spectral = components.IdealBPFilter(wavelength, 1);

                detector(i) = components.Detector(wavelength, clock_rate, time_gate_width, ...
                                              filter_spectral, "Preset", preset(i) );
            end

        end

    end

end
