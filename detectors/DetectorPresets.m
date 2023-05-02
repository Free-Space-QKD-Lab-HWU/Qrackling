classdef DetectorPresets

    enumeration
        Excelitas ('Excelitas.mat')
        Hamamatsu ('Hamamatsu.mat')
        LaserComponents ('LaserComponents.mat')
        MicroPhotonDevices ('MicroPhotonDevices.mat')
        PerkinElmer ('PerkinElmer.mat')

        % Set PresetLoader to a detectorPresetBuilder in the case of Custom 
        % detectors. In this case LoadPreset **MUST** be supplied with a path.
        % Alternatively, PresetLoader could be used as a detectorPresetBuilder 
        % to build a detector at the call site.
        Custom (@detectorPresetBuilder)
    end

    properties(SetAccess = immutable)
        PresetLoader
    end

    methods

        function preset = DetectorPresets(PresetLoader)
            preset.PresetLoader = PresetLoader;
        end

        function preset = LoadPreset(Preset, varargin)

            if nargin > 1
                assert(nargin <= 2, 'Arguments to LoadPreset should be a path');
                Path = varargin{1};

                assert(Preset == DetectorPresets.Custom, strjoin([newline, ...
                    'Can not override DetectorPresets.', string(Preset), ...
                    '. Use DetectorPresets.Custom.', ...
                    'LoadPreset("~/path/to/detector.mat") in this case'], ''));

                % This should never fail
                assert(isa(Preset.PresetLoader, 'function_handle'), ...
                    ['Object { ', inputname(1), ': DetectorPresets.PresetLoader } ', ...
                    'must be a function handle when set to DetectorPresets.Custom']);

                preset = Preset.PresetLoader().loadPreset(Path);
                return
            end

            preset = detectorPresetBuilder().loadPreset(Preset.PresetLoader);
        end

    end

end
