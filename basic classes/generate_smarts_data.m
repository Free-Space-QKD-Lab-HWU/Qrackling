% Simple runner function to make looping over azimuth (heading) and elevation
% values for generating new results for SMARTS simulations. Passing an array of
% flags determining whether or not communications can occur will limit the the
% number of simulations that needs to be run.
function result_files = generate_smarts_data(SMARTS_object, azimuth, elevation, flags)
    N = numel(flags);
    result_files = cell(1, N);

    idx_start = sum(cumsum(flags) == 0) + 1;
    idx_stop = idx_start + sum(flags) - 1;

    for i = idx_start : idx_stop
        el = elevation(i);
        az = azimuth(i);

        file_name = num2str(i);
        ialbdx = far_field_albedo(...
                spectral_reflectance = SMARTS_object.ialbdx.spectral_reflectance, ...
                tilt = el, ...
                wazim = az, ...
                ialbdg = SMARTS_object.ialbdx.local_foreground_albedo);

        SMARTS_object = SMARTS_object.set_card(ialbdx);

        [SMARTS_object, success, destination] = SMARTS_object.run_smarts(...
                        file_path=SMARTS_object.file_path_stub, ...
                        file_name=file_name);

        result_files{i} = strrep(destination, 'inp', 'ext');
        assert(success, 'Something failed...');
    end
    
end
