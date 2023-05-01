classdef DetectorPresets

    enumeration
        Excelitas ('Excelitas.mat')
        Hamamatsu ('Hamamatsu.mat')
        LaserComponents ('LaserComponents.mat')
        MicroPhotonDevices ('MicroPhotonDevices.mat')
        PerkinElmer ('PerkinElmer.mat')
        Custom ('')
    end

    properties(SetAccess = immutable)
        preset_location
    end

    methods

        function preset = DetectorPresets(preset_location)
            preset.preset_location = preset_location;
        end

        function preset = LoadPreset(det_preset, varargin)
            p = inputParser();
            addParameter(p, 'customPath', '');
            parse(p, varargin{:});

            preset_path = det_preset.preset_location;
            if det_preset == DetectorPresets.Custom
                assert(~isempty(p.Results.customPath), ...
                    ['Attempting to use custom (user defined) detector ', ...
                    'without supplying a path to a "DetectorPreset"']);
                preset_path = p.Results.customPath;
            end

            preset = detectorPresetBuilder().loadPreset(preset_path);
        end

    end

end
