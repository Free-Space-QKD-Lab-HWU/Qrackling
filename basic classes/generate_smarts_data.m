function result_files = generate_smarts_data(SMARTS_object, azimuth, ...
                                             elevation, times, flags)

    % Simple runner function to make looping over azimuth (heading) and
    % elevation values for generating new results for SMARTS simulations.
    % Times here must be an array of type datetime, this is checked for inside
    % the function body, if it passes the date and time information of the
    % "solar_position_and_airmass" SMARTS card are updated inline with the
    % values for azimuth and elevation. Passing an array of flags determining 
    % whether or not communications can occur will limit the number of 
    % simulations that needs to be run.
    % 

    N = numel(flags);
    result_files = cell(1, N);

    idx_start = sum(cumsum(flags) == 0) + 1;
    idx_stop = idx_start + sum(flags) - 1;

    useTime = false;
    % check if time argument is of type datetime
    if isdatetime(times)
        useTime = true;
    end

    for i = idx_start : idx_stop
        el = elevation(i);
        az = azimuth(i);

        file_name = num2str(i);
        ialbdx = far_field_albedo(...
                spectral_reflectance = ...
                        SMARTS_object.ialbdx.spectral_reflectance, ...
                tilt = el, ...
                wazim = az, ...
                ialbdg = SMARTS_object.ialbdx.local_foreground_albedo);

        SMARTS_object = SMARTS_object.update_card(ialbdx);

        % update date and time of 'imass' (solar_position_and_airmass) card of
        % the SMARTS configuration should "useTime" pass
        if useTime
            imass = solar_position_and_airmass('dateAndTime',times(i), ...
                'latitude',SMARTS_object.imass.latitude,...
                'longitude', SMARTS_object.imass.longitude);
            SMARTS_object = SMARTS_object.update_card(imass);
        end


        [SMARTS_object, success, destination] = SMARTS_object.run_smarts(...
                        file_path=SMARTS_object.file_path_stub, ...
                        file_name=file_name);

        result_files{i} = strrep(destination, 'inp', 'ext');
        assert(success, 'Something failed...');
    end
    
end
