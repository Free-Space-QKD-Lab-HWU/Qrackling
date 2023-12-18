function data = ReadData(lrt)
    arguments
        lrt libradtran.libRadtran
    end

    [keys, values] = libradtran.readInputFile(lrt.File);

    if any(contains(keys, 'mc_basename'))
        [path, name, ~] = fileparts(lrt.MysticsSettings.basename.Name);
        mc_file = strjoin({strjoin({path, name}, filesep), '.rad.spc'}, '');
        [data.stokes, data.wavelength] = libradtran.extractStokesParameters( ...
            mc_file, "extract_wavelength", "on");
    end

    if any(contains(keys, 'output_file'))
        if any(contains(keys, 'output_quantity'))
            [~, i] = max(contains(keys, 'output_quantity'));
            quantity = values{i};
        end

        data.(quantity) = libradtran.outputFromInputFile(lrt.File);
    end
end
