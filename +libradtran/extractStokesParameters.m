function [stokes, wvl] = extractStokesParameters(dop_data_file, options)
    arguments
        dop_data_file {mustBeFile}
        options.extract_wavelength matlab.lang.OnOffSwitchState = "off"
    end

    [~, name, ext] = fileparts(dop_data_file);
    [~, ~, sub_ext] = fileparts(name);

    assert(any('.rad.spc' == [sub_ext, ext]),  ...
        'Wrong input file suppled, file should have extension ".rad.spc"');

    data = readtable(dop_data_file, FileType='delimitedtext');

    stokes.I = table2array(data(1:4:end, end));
    stokes.Q = table2array(data(2:4:end, end));
    stokes.U = table2array(data(3:4:end, end));
    stokes.V = table2array(data(4:4:end, end));

    if true == options.extract_wavelength
        wvl = unique(table2array(data(:, 1)));
    end
end
