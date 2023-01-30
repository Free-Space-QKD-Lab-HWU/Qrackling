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
% output_path = 'path/to/write/atmosphere.mat';
% genAtmos.ExportAtmosphere(output_path);
% atmosphere = genAtmos.LoadAtmosphere(output_path)

classdef GenerateAtmosphere

    properties

        azimuth;
        elevation;
        wavelengths;
        SMARTS_conf SMARTS_input;
        result_files;
        atmosphere;

    end


    methods

        function GenerateAtmosphere = GenerateAtmosphere(SMARTS_conf, varargin)


            %MATLAB requires that objects provide an empty constructor
            if nargin==0
                return
            end

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
            GenerateAtmosphere.elevation = arange(0, ...
                                                  90 + p.Results.step_size_elevation, ...
                                                  p.Results.step_size_elevation);

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

            spectral_reflectance = SMARTS_conf.ialbdx.spectral_reflectance;
            foreground_local_albedo = SMARTS_conf.ialbdx.local_foreground_albedo;

            progress = waitbar(0, 'Starting');
            N = numel(azimuth) * numel(elevation);
            i = 1;

            for a = 1 : numel(azimuth)
                for e = 1 : numel(elevation)

                    file_name = [ 'az_', num2str(azimuth(a)), ...
                                  '_el_', num2str(elevation(e)) ];

                    file_path = [SMARTS_conf.file_path_stub, file_name];

                    fn_str = convertCharsToStrings(file_path);

                    GenerateAtmosphere.result_files{a, e} = file_path;

                    if ( all(2 == arrayfun(@(F) exist(F, 'file'), fn_str + extensions)) ...
                         & (p.Results.force_run_SMARTS == false) )
                        waitbar(i / N, ...
                                progress, ...
                                sprintf('Completed %d/%d SMARTS Simulation', i, N));
                        i = i + 1;
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
                    waitbar(i / N, progress, sprintf('Completed %d/%d SMARTS Simulation', i, N));
                    pause(0);
                    i = i + 1;
                end
            end
            close(progress);
            GenerateAtmosphere.SMARTS_conf = SMARTS_conf;
        end


        function GenerateAtmosphere = ConstructAtmosphere(GenerateAtmosphere)
            % After simulating the atmosphere the function can be run to read
            % each of the result files generated by SMARTS and extract the
            % transmission and global tilted irradiance. Each of these arrays
            % is then added to a matrix of structs containing the azimuth,
            % and elevation as well for ease of use later.

            progress = waitbar(0, 'Starting');
            N = numel(GenerateAtmosphere.azimuth) ...
                * numel(GenerateAtmosphere.elevation);
            i = 1;

            GenerateAtmosphere.atmosphere = cell(...
                                        numel(GenerateAtmosphere.azimuth), ...
                                        numel(GenerateAtmosphere.elevation));

            for a = 1 : numel(GenerateAtmosphere.azimuth)
                for e = 1 : numel(GenerateAtmosphere.elevation)
                    file_path = [GenerateAtmosphere.result_files{a, e}, '.ext.txt'];
                    data = readtable(file_path, VariableNamingRule = 'preserve');

                    %edit: CJS: SMARTS will only run during sunlight hours. during
                    %nighttime, it returns an empty file, resulting in an empty
                    %table. We will need to detect and replace this with zeros.
                    if isempty(data)
                            %get old SMARTS config and its time
                            Daytime_SMARTS_Config = GenerateAtmosphere.SMARTS_conf;
                            Daytime_Solar_Position_and_Airmass = GenerateAtmosphere.SMARTS_conf.imass;

                            %shift to midday
                            %and implement this in the new config
                            Daytime_Solar_Position_and_Airmass.Hour=12;
                            Daytime_SMARTS_Config.imass = Daytime_Solar_Position_and_Airmass;

                            %run SMARTS for this time
                            ialbdx = far_field_albedo( ...
                                        spectral_reflectance=Daytime_SMARTS_Config.ialbdx.spectral_reflectance, ...
                                        tilt=GenerateAtmosphere.azimuth(a), ...
                                        wazim=GenerateAtmosphere.elevation(e), ...
                                        ialbdg=Daytime_SMARTS_Config.ialbdx.local_foreground_albedo );
                             Daytime_SMARTS_Config = Daytime_SMARTS_Config.update_card(ialbdx);
                             
                             %delete old file
                                delete([GenerateAtmosphere.result_files{a, e}, '.ext.txt'])
                                delete([GenerateAtmosphere.result_files{a, e}, '.inp.txt'])
                                delete([GenerateAtmosphere.result_files{a, e}, '.out.txt'])
                             %write a new name for this daytime file
                             [Filepath, filename]=fileparts(GenerateAtmosphere.result_files{a,e});
                              GenerateAtmosphere.result_files{a,e}=[Filepath,filesep, filename,'_midday'];

                            [Daytime_SMARTS_Config, success, destination] = ...
                            Daytime_SMARTS_Config.run_smarts(...
                                   file_path = [Filepath,filesep], ...
                                   file_name = [filename,'_midday' ]);

                            %check that run was a success
                            assert(success,'time-shifting to daytime to simulate transmission data failed.')

                            %extract new data
                            data = readtable([GenerateAtmosphere.result_files{a,e},'.ext.txt'], VariableNamingRule = 'preserve');
                            NumWavelengths = numel(data.Wvlgth);
                            %set all results which are not transmission data or wavelength markers to
                            %zero to simulate no sunlight
                            TableColumnNames = data.Properties.VariableNames;
                            TableSkyNames=TableColumnNames(~(contains(TableColumnNames,'transmittance')|contains(TableColumnNames,'Wvlgth')));
                            data(:,TableSkyNames) = {0};
                    end

                    temp.azimuth = GenerateAtmosphere.azimuth(a);
                    temp.elevation = GenerateAtmosphere.elevation(e);
                    temp.data = GenerateAtmosphere.extractVariables(data);
                    GenerateAtmosphere.atmosphere{a, e} = temp;
                    %delete the results file (and other files) to allow a new ones to be written
                        delete([GenerateAtmosphere.result_files{a, e}, '.ext.txt'])
                        delete([GenerateAtmosphere.result_files{a, e}, '.inp.txt'])
                        delete([GenerateAtmosphere.result_files{a, e}, '.out.txt'])
                    waitbar(i / N, progress, sprintf('Collecting %d/%d SMARTS Simulation', i, N));
                    pause(0);
                    i = i + 1;
                end
            end

            close(progress);
            GenerateAtmosphere.wavelengths = data.Wvlgth;
        end

        function res_table = extractVariables(GenerateAtmosphere, smarts_data)

            cases = {'irrad', 'transmit'};
            n_opt = linspace(1, numel(cases), numel(cases));

            res_table = struct();
            for i = 2 : numel(smarts_data.Properties.VariableNames)
                vn = smarts_data.Properties.VariableNames{i};
                switch sum(cellfun(@(c) contains(vn, c), cases) .* n_opt)
                    case 0
                        continue
                    otherwise
                        res_table.(vn) = smarts_data.(vn);
                end
            end

            res_table = struct2table(res_table);

        end

        function ExportAtmosphere(GenerateAtmosphere, result_path)
            % Save the calculated atmosphere to disk
            atmosphere.wavelengths = GenerateAtmosphere.wavelengths;
            atmosphere.values = GenerateAtmosphere.atmosphere;
            save(result_path, 'atmosphere');
        end
        
        function atmosphere = LoadAtmosphere(Atmosphere, file_path)
            assert(2 == exist(file_path), 'File does not exist');

            data = load(file_path);

            fields = fieldnames(data);
            assert(convertCharsToStrings(fields{1}) == "atmosphere", ...
                   'Not an atmosphere');

            atmosphere = load(file_path).atmosphere;
        end

    end

end

