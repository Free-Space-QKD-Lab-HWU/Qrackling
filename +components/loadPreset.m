function result = loadPreset(preset)
    arguments (Input)
        preset {mustBeMember( preset, { ...
            'Excelitas', 'Hamamatsu', ...
            'LaserComponents', 'MicroPhotonDevices', ...
            'PerkinElmer', 'ID_Qube_NIR', ...
            'QuantumOpus1550_RoomTemperatureAmplifier', ...
            'QuantumOpus1550_CryogenicAmplifier', ...
            })}
    end

    [path, ~] = fileparts(which('components.loadPreset'));
    %file_path = strjoin(path, ); %, "presets", filesep, preset, ".mat"];
    file_name = strjoin([preset, 'mat'], ".");
    file_path = strjoin([path, 'presets', file_name], filesep);
    result = components.DetectorPresetBuilder().loadPreset(file_path);
end
