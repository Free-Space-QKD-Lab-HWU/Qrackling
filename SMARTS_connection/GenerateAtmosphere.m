% Class to calculate the atmospheric conditions at a location.
% Supplying the class with a base SMARTS configuration along with a set of
% azimuth (heading) and elevation angles will be used to run SMARTS to 
% calculate the amount of atmospheric transmission present across the region of
% sky visible to a ground station / telescope.

classdef GenerateAtmosphere

    properties
        
        SMARTS_conf SMARTS_input;
        result_files;

    end


    methods

        function GenerateAtmosphere = GenerateAtmosphere(SMARTS_conf)

            assert(isa(SMARTS_conf, 'SMARTS_input'), 'Must be a SMARTS_input');

            spectral_reflectance = SMARTS_conf.ialbdx.spectral_reflectance
            foreground_local_albedo = SMARTS_conf.ialbdx.local_foreground_albedo;

            azimuth = linspace(0, 360, 10);
            elevation = linspace(0, 90, 10);
            GenerateAtmosphere.result_files = cell(numel(azimuth), numel(elevation));

            imass = solar_position_and_airmass(dateAndTime=datetime(2022, 8, 15, 12, 0, 0), ...
                                    latitude=56.405, longitude=-3.183);

            SMARTS_conf = SMARTS_conf.update_card(imass);

            for a = 1 : numel(azimuth)
                for e = 1 : numel(elevation)
                    ialbdx = far_field_albedo(...
                                spectral_reflectance=spectral_reflectance, ...
                                tilt=azimuth(a), ...
                                wazim=elevation(e), ...
                                ialbdg=foreground_local_albedo);

                    file_name = ['az_', num2str(azimuth(a)), '_el_', num2str(elevation(e))];
                    GenerateAtmosphere.result_files{a, e} = file_name;

                    SMARTS_conf = SMARTS_conf.update_card(ialbdx);

                    [SMARTS_conf, success, destination] = ...
                            SMARTS_conf.run_smarts(...
                                    file_path=SMARTS_conf.file_path_stub, ...
                                    file_name=file_name);
                end
            end


        end

    end

end

