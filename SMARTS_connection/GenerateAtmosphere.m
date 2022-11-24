% Author: Peter Barrow
% Date: 23/11/22
% Class to calculate the atmospheric conditions at a location.
% Supplying the class with a base SMARTS configuration along with a set of
% azimuth (heading) and elevation angles will be used to run SMARTS to 
% calculate the amount of atmospheric transmission present across the region of
% sky visible to a ground station / telescope.
%
% % Example usage
% smarts_path = 'some/path/to/write/smarts/results/to';
% results_path = 'some/path/to/your/copy/of/the/SMARTS/executable';
% % basic smarts configuration for Errol can be found here (remember that the
% %     time is pre-configured in here to be the 15/8/2022 @ 12:00:00)
% config = solar_background_errol(executable_path=smarts_path, stub=results_path);
% 
% genAtmos = GenerateAtmosphere(config);
% genAtmos.ExportAtmosphere('path/to/write/atmosphere.mat');
%
% % Optionally, set the size of the steps in azimuth end elevation
% genAtmos = GenerateAtmosphere(config, ...
%                               step_size_aziumth=10, ...
%                               step_size_elevation=10);
% genAtmos.ExportAtmosphere('path/to/write/atmosphere.mat');

classdef GenerateAtmosphere

    properties
        
        azimuth;
        elevation;
        SMARTS_conf SMARTS_input;
        result_files;
        atmosphere;

    end


    methods

        function GenerateAtmosphere = GenerateAtmosphere(SMARTS_conf, varargin)

            p = inputParser;
            addParameter(p, 'step_size_aziumth', 5);
            addParameter(p, 'step_size_elevation', 5);
            addParameter(p, 'force_run_SMARTS', false);
            parse(p, varargin{:});

            assert(isa(SMARTS_conf, 'SMARTS_input'), 'Must be a SMARTS_input');

            GenerateAtmosphere.SMARTS_conf = SMARTS_conf;

            spectral_reflectance = SMARTS_conf.ialbdx.spectral_reflectance;
            foreground_local_albedo = SMARTS_conf.ialbdx.local_foreground_albedo;

            arange = @(START, STOP, STEP) linspace( START, ...
                                                    STOP - STEP, ...
                                                    STOP / STEP );

            GenerateAtmosphere.azimuth = arange(0, 360, p.Results.step_size_aziumth);
            GenerateAtmosphere.elevation = arange(0, 90, p.Results.step_size_elevation);

            GenerateAtmosphere = GenerateAtmosphere.SimulateAtmosphere(...
                                     force_run_SMARTS=p.Results.force_run_SMARTS);
            GenerateAtmosphere = GenerateAtmosphere.ConstructAtmosphere();

        end

        function GenerateAtmosphere = SimulateAtmosphere(GenerateAtmosphere, varargin)
            % Using the base configuration for SMARTS that has been supplied
            % run SMARTS for each combination of azimuth and elevation writing
            % a file to a result path. If this function detects that a file
            % with the same name already exists it won't run SMARTS and will
            % skip that combination of variables, add 'force_run_SMARTS=true'
            % to the arguments if a new run is needed.

            p = inputParser;
            addParameter(p, 'force_run_SMARTS', false);
            parse(p, varargin{:});

            azimuth = GenerateAtmosphere.azimuth;
            elevation = GenerateAtmosphere.elevation;

            GenerateAtmosphere.result_files = cell(numel(azimuth), numel(elevation));

            extensions = [".inp.txt", ".ext.txt", ".out.txt"];
            file_exist = @(F) arrayfun(@(F) exist(F, 'file'), F + extensions);

            SMARTS_conf = GenerateAtmosphere.SMARTS_conf;

            for a = 1 : numel(azimuth)
                for e = 1 : numel(elevation)

                    file_name = [ 'az_', num2str(azimuth(a)), ...
                                  '_el_', num2str(elevation(e)) ];

                    file_path = [SMARTS_conf.file_path_stub, file_name];

                    fn_str = convertCharsToStrings(file_path);

                    GenerateAtmosphere.result_files{a, e} = file_path;

                    if ( all(2 == arrayfun(@(F) exist(F, 'file'), fn_str + extensions)) ...
                         & (p.Results.force_run_SMARTS == false) )
                        continue
                    end

                    ialbdx = far_field_albedo( ...
                                spectral_reflectance=spectral_reflectance, ...
                                tilt=azimuth(a), ...
                                wazim=elevation(e), ...
                                ialbdg=foreground_local_albedo );


                    SMARTS_conf = SMARTS_conf.update_card(ialbdx);

                    [SMARTS_conf, success, destination] = ...
                            SMARTS_conf.run_smarts(...
                                    file_path=SMARTS_conf.file_path_stub, ...
                                    file_name=file_name);
                end
            end
            GenerateAtmosphere.SMARTS_conf = SMARTS_conf;
        end


        function GenerateAtmosphere = ConstructAtmosphere(GenerateAtmosphere)
            % After simulating the atmosphere the function can be run to read
            % each of the result files generated by SMARTS and extract the
            % transmission and global tilted irradiance. Each of these arrays
            % is then added to a matrix of structs containing the azimuth,
            % and elevation as well for ease of use later.

            GenerateAtmosphere.atmosphere = cell(...
                                        numel(GenerateAtmosphere.azimuth), ...
                                        numel(GenerateAtmosphere.elevation));

            for a = 1 : numel(GenerateAtmosphere.azimuth)
                for e = 1 : numel(GenerateAtmosphere.elevation)
                    file_path = [GenerateAtmosphere.result_files{a, e}, '.ext.txt'];
                    data = readtable(file_path, 'VariableNamingRule', 'preserve');
                    temp.azimuth = a;
                    temp.elevation = e;
                    temp.transmittance = data.Mixed_gas__transmittance;
                    temp.global_tilted_irradiance = data.Global_tilted_irradiance;
                    GenerateAtmosphere.atmosphere{a, e} = temp;
                end
            end
        end

        function ExportAtmosphere(GenerateAtmosphere, result_path)
            % Save the calculated atmosphere to disk
            atmosphere = GenerateAtmosphere.atmosphere;
            save(result_path, 'atmosphere');
        end

    end

end

