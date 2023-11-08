classdef DetectorPresetBuilder
    % Class to build a detector preset (DetectorPreset.m).
    %
    % # Example of making a preset and saving it
    % MyDetector = detectorPresetBuilder() ...
    %     .addName('My Detector') ...
    %     .addDarkCountRate(10) ...
    %     .addDeadTime(35e-9) ...
    %     .addJitterHistogram(jitter_histogram, 1e-12) ...
    %     .addDetectorEfficiencyArray(wavelengths, efficiencies);
    % MyDetector.makeDetectorPreset()
    % MyDetector.writePreset('path/to/save/preset/to.mat')

    properties(SetAccess=protected, GetAccess=protected)
        preset
    end

    methods

        function builder = addName(builder, Name)
            % Add a name to a preset
            arguments
                builder detectors.DetectorPresetBuilder
                Name {mustBeText}
            end
            builder.preset.Name = Name;
        end

        function builder = addDarkCountRate(builder, DarkCountRate)
            % Add a dark count rate to a preset
            arguments
                builder detectors.DetectorPresetBuilder
                DarkCountRate { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(DarkCountRate, 0)}
            end

            builder.preset.Dark_Count_Rate = DarkCountRate;
        end

        function builder = addDeadTime(builder, DeadTime)
            % Add a detector dead time (reset time) to a preset
            arguments
                builder detectors.DetectorPresetBuilder
                DeadTime {mustBeNumeric, mustBeGreaterThanOrEqual(DeadTime, 0)}
            end

            builder.preset.Dead_Time = DeadTime;
        end

        function builder = addJitterHistogram(builder, Histogram, BinWidth)
            % Add a detector jitter histogram to a preset.
            % Histogram should be an array and BinWidth should be a double (
            % probably 1 ps (1e-12) or something similar)
            arguments
                builder detectors.DetectorPresetBuilder
                Histogram { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(Histogram, 0)}
                BinWidth {mustBeNumeric, mustBeGreaterThanOrEqual(BinWidth, 0)}
            end

            builder.preset.Jitter_Histogram = Histogram;
            builder.preset.Histogram_Bin_Width = BinWidth;
        end

        function builder = addDetectorEfficiencyArray(...
                builder, Wavelengths, Efficiencies)
            % Add an array of possible wavelengths and corresponding 
            % efficiencies for a detector to a preset
            arguments
                builder detectors.DetectorPresetBuilder
                Wavelengths
                Efficiencies { ...
                    mustBeGreaterThanOrEqual(Efficiencies, 0) ...
                    mustBeLessThanOrEqual(Efficiencies, 1)}
            end
            assert( ...
                sum((size(Wavelengths) == size(Efficiencies))) == 2, ...
                ['Wavelengths ( ', inputname(2), ' ) and Efficiencies ( ', ...
                inputname(3), ' ) do not have matching shapes.', newline, ...
                char(9), 'Shapes: ', mat2str(size(Wavelengths)), ' and ', ...
                mat2str(size(Efficiencies))] ...
            )

            builder.preset.Wavelength_Range = Wavelengths;
            builder.preset.Efficiencies = Efficiencies;
        end

        function preset = makeDetectorPreset(builder)
            % Only way of accessing the "preset" property. This way only valid
            % DetectorPreset objects can be created
            fields = fieldnames(DetectorPreset);
            for i = 1:numel(fields)
                field = fields{i};
                value = builder.preset.(field);
                assert(~isempty(value), ...
                    [field, ' is empty and must contain a value.']);
            end
            preset = builder.preset;
        end

        function writePreset(builder, outputPath)
            % Write the preset contained within the builder to a file specified
            % by outputPath. This calls makeDetectorPreset() ensuring that the
            % requirements for a valid detector preset have been met.
            outputPath = adduserpath(outputPath);
            new_preset = builder.makeDetectorPreset();
            save(outputPath, 'new_preset');
        end

        function preset = loadPreset(builder, presetFilePath)
            arguments
                builder detectors.DetectorPresetBuilder
                presetFilePath {mustBeFile}
            end
            % Load a preset from presetFilePath. The loaded preset is contained
            % within the builder and validated with makeDetectorPreset()
            preset = load(presetFilePath).preset;
            builder.preset = preset;
            preset = builder.makeDetectorPreset();
        end

        function presetBuilder = BuildPresetFromDetector(builder, name, detector)
            % Build a preset from a name and a Detector object.
            arguments
                builder detectors.DetectorPresetBuilder
                name {mustBeText}
                detector Detector
            end

            presetBuilder = DetectorPresetBuilder() ...
                .addName(name) ...
                .addDarkCountRate(detector.Dark_Count_Rate) ...
                .addDeadTime(detector.Dead_Time) ...
                .addJitterHistogram(detector.Jitter_Histogram, detector.Histogram_Bin_Width) ...
                .addDetectorEfficiencyArray(detector.Wavelength_Range, detector.Efficiencies);
        end

    end
end
