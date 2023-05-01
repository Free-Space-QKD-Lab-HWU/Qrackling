classdef detectorPresetBuilder

    properties(SetAccess=protected, GetAccess=protected)
        preset = DetectorPreset
    end

    methods

        function builder = addName(builder, Name)
            arguments
                builder detectorPresetBuilder
                Name {mustBeText}
            end
            builder.preset.Name = Name;
        end

        function builder = addDarkCountRate(builder, DarkCountRate)
            arguments
                builder detectorPresetBuilder
                DarkCountRate { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(DarkCountRate, 0)}
            end

            builder.preset.Dark_Count_Rate = DarkCountRate;
        end

        function builder = addDeadTime(builder, DeadTime)
            arguments
                builder detectorPresetBuilder
                DeadTime {mustBeNumeric, mustBeGreaterThanOrEqual(DeadTime, 0)}
            end

            builder.preset.Dead_Time = DeadTime;
        end

        function builder = addJitterHistogram(builder, Histogram, BinWidth)
            arguments
                builder detectorPresetBuilder
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
            arguments
                builder detectorPresetBuilder
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

            builder.preset.Efficiencies_Wavelengths = Wavelengths;
            builder.preset.Efficiencies_Values = Efficiencies;
        end

        % Only way of accessing the "preset" property. This way only valid
        % DetectorPreset objects can be created
        function preset = makeDetectorPreset(builder)
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
            outputPath = adduserpath(outputPath);
            preset = builder.makeDetectorPreset()
            save(outputPath, 'preset');
        end

        function preset = loadPreset(builder, presetFilePath)
            preset = load(presetFilePath).preset;
            builder.preset = preset;
            preset = builder.makeDetectorPreset();
        end

    end
end
