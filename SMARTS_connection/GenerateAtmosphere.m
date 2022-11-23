% Class to calculate the atmospheric conditions at a location.
% Supplying the class with a base SMARTS configuration along with a set of
% azimuth (heading) and elevation angles will be used to run SMARTS to 
% calculate the amount of atmospheric transmission present across the region of
% sky visible to a ground station / telescope.

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
            parse(p, varargin{:});

            assert(isa(SMARTS_conf, 'SMARTS_input'), 'Must be a SMARTS_input');

            GenerateAtmosphere.SMARTS_conf = SMARTS_conf;

            spectral_reflectance = SMARTS_conf.ialbdx.spectral_reflectance;
            foreground_local_albedo = SMARTS_conf.ialbdx.local_foreground_albedo;

            arange = @(START, STOP, STEP) linspace( START, ...
                                                    STOP - STEP, ...
                                                    STOP / STEP );

            GenerateAtmosphere.azimuth = arange(0, 360, p.step_size_aziumth);
            GenerateAtmosphere.elevation = arange(0, 90, p.step_size_elevation);

            GenerateAtmosphere = GenerateAtmosphere.SimulateAtmosphere();
            GenerateAtmosphere = GenerateAtmosphere.ConstructAtmosphere();

        end

        function GenerateAtmosphere = SimulateAtmosphere(GenerateAtmosphere)

            azimuth = GenerateAtmosphere.azimuth;
            elevation = GenerateAtmosphere.elevation;

            GenerateAtmosphere.result_files = cell(numel(azimuth), numel(elevation));

            extensions = [".inp.txt", ".ext.txt", ".out.txt"];
            file_exist = @(F) arrayfun(@(F) exist(F, 'file'), F + extensions);

            for a = 1 : numel(azimuth)
                for e = 1 : numel(elevation)

                    file_name = [ 'az_', num2str(azimuth(a)), ...
                                  '_el_', num2str(elevation(e)) ];

                    file_path = [SMARTS_conf.file_path_stub, file_name];

                    fn_str = convertCharsToStrings(file_path);

                    GenerateAtmosphere.result_files{a, e} = file_path;

                    if all(2 == arrayfun(@(F) exist(F, 'file'), fn_str + extensions))
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
        end


        function GenerateAtmosphere = ConstructAtmosphere(GenerateAtmosphere)
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
            atmosphere = GenerateAtmosphere.atmosphere;
            save(result_path, 'atmosphere');
        end

    end

end

