classdef SMARTS_input
    properties

        ispr sitePressure;
        iatmos atmosphere;
        ih20 water_vapour;
        i03 ozone;
        igas gas_atmospheric_absorption; 
        ico2 carbon_dioxide;
        iaeros aerosol;
        iturb turbidity;
        ialbdx far_field_albedo;
        isolar extra_spectral;
        iprt printing;
        icirc circum_solar;
        iscan scanning;
        illum illuminance;
        iuv  broadband_uv;
        imass solar_position_and_airmass;

        comment = '';
        input_string = '';
        smarts_path = '';
        current_ext_file_path = '';
        file_path_stub = '';

    end

    properties(SetAccess=protected, Hidden=true)

        output_opt = { ...
            'Wvlgth', ...
            'Extraterrestrial_spectrm', ...
            'Direct_normal_irradiance', ...
            'Difuse_horizn_irradiance', ...
            'Global_horizn_irradiance', ...
            'Direct_horizn_irradiance', ...
            'Direct_tilted_irradiance', ...
            'Difuse_tilted_irradiance', ...
            'Global_tilted_irradiance', ...
            'Beam_normal__circumsolar', ...
            'Difuse_horiz_circumsolar', ...
            'Circumsolar___irradiance', ...
            'Global_tilt_photon_irrad', ...
            'Beam_normal_photon_irrad', ...
            'Difuse_horiz_photn_irrad', ...
            'RayleighScat_trnsmittnce', ...
            'Ozone_totl_transmittance', ...
            'Trace_gas__transmittance', ...
            'WaterVapor_transmittance', ...
            'Mixed_gas__transmittance', ...
            'Aerosol_tot_transmittnce', ...
            'Direct_rad_transmittance', ...
            'RayleighScat_optic_depth', ...
            'Ozone_totl_optical_depth', ...
            'Trace_gas__optical_depth', ...
            'WaterVapor_optical_depth', ...
            'Mixed_gas__optical_depth', ...
            'Aeros_spctrl_optic_depth', ...
            'Single_scattering_albedo', ...
            'Aerosol_asymmetry_factor', ...
            'Zonal_ground_reflectance', ...
            'Local_ground_reflectance', ...
            'Atmosph_back_reflectance', ...
            'Global_tilt_reflectd_rad', ...
            'Upward_reflctd_radiation', ...
            'Glob_horiz_PAR_phot_flux', ...
            'Dir_norml_PAR_photn_flux', ...
            'Dif_horiz_PAR_photn_flux', ...
            'Glob_tilt_PAR_photn_flux', ...
            'Spectral_photonic_energy', ...
            'Globl_horizn_photon_flux', ...
            'Dirct_normal_photon_flux', ...
            'Dif_horizntl_photon_flux', ...
            'Global_tiltd_photon_flux'}

    end

    methods

        function SMARTS_input = SMARTS_input(varargin)

            assert(nargin >= 1, 'Comment and List/Array of cards must be supplied');

            p = inputParser;
            addParameter(p, 'comment', 'test');
            addParameter(p, 'args', []);
            addParameter(p, 'executable_path', '');
            addParameter(p, 'stub', '');

            parse(p, varargin{:});

            assert(length(p.Results.comment) < 64, ...
                'Comment must not exceed 64 characters');

            assert(~isempty(p.Results.stub), ...
                'Must set a base path to store results at');
            SMARTS_input.file_path_stub = p.Results.stub;

            SMARTS_input.comment = [SMARTS_input.comment, '''', ...
                            strrep(p.Results.comment, ' ', '_'), '''', ...
                            char(9), '!Card 1 Comment'];

            for i = 1 : length(p.Results.args)
                SMARTS_input = update_card(SMARTS_input, p.Results.args{i});
            end

            result = compose(SMARTS_input);
            SMARTS_input.input_string = result;

            if ~isempty(p.Results.executable_path)
                assert(isdir(p.Results.executable_path), ...
                    '"executable_path" is not a valid path');
                SMARTS_input.smarts_path = p.Results.executable_path;
            end

        end


        function SMARTS_input = update_card(SMARTS_input, new_card)
            if isempty(inputname(2))
                input_name = 'anonymous';
            else
                input_name = inputname(2);
            end

            assert(isa(new_card, 'card'), ...
                ['Input: (', input_name, ') is not a card']);

            props = properties(SMARTS_input);
            for i = 1 : length(props)
                if isa(new_card, class(SMARTS_input.(props{i})))
                    SMARTS_input.(props{i}) = new_card;
                end
            end

            result = compose(SMARTS_input);
            SMARTS_input.input_string = result;

        end


        function valid = validate_cards(SMARTS_input)

            props = properties(SMARTS_input);
            n_props = length(props);
            valid = false(1, n_props);

            for i = 1 : n_props
                %if length(SMARTS_input.(props{i})) > 0
                if isa(SMARTS_input.(props{i}), 'card')
                    if length(SMARTS_input.(props{i})) > 0
                        valid(i) = true;
                    end
                end
            end

        end


        function input_string = compose(SMARTS_input)

            valid = validate_cards(SMARTS_input);
            props = properties(SMARTS_input);

            input_string = [SMARTS_input.comment];

            for i = 1 : length(valid)
                if valid(i)
                    card_string = SMARTS_input.(props{i}).cardString();
                    input_string = [input_string, newline, card_string];
                end
            end

            %input_string = SMARTS_input.align_comments(input_string);
            input_string = SMARTS_input.clean_input(input_string);

        end


        function cleaned = clean_input(SMARTS_input, input_string)

            lines = strsplit(input_string, newline);
            N = length(lines);

            cleaned = [];

            for i = 1 : N
                halves = strsplit(lines{i}, char(9));
                params = halves{1};
                comments = halves{2};
                
                values = strsplit(params, ' ');
                new_params = [];
                for j = 1 : length(values) - 1
                    if ~strcmp(values{j}, ' ')
                        new_params = [new_params, strrep(values{j}, ' ', ''), ' '];
                    end
                end

                new_params = [new_params, values{end}];

                cleaned = [cleaned, params, '    ', comments, newline];

            end

        end


        function final_str = align_comments(SMARTS_input, input_string)

            lines = strsplit(input_string, newline);
            sides = cell(2, length(lines));
            lengths = zeros(1, length(lines));

            for i = 1 : length(lines)
                halves = strsplit(lines{i}, char(9));
                sides{1, i} = halves{1};
                sides{2, i} = halves{2};
                lengths(i) = length(halves{1});
            end

            add_space = max(lengths) - lengths;
            final_str = [];

            for i = 1 : length(lines)
                temp = [' '];
                for j = 1 : add_space(i)
                    temp = [temp, ' '];
                end
                final_str = [final_str, sides{1, i}, temp, sides{2, i}, newline];
            end
        end


        function [success, destination] = write_file(SMARTS_input, varargin)

            success = false;

            p = inputParser;
            addParameter(p, 'file_path', '');
            addParameter(p, 'file_name', '');

            parse(p, varargin{:});

            file_path = p.Results.file_path;
            file_name = p.Results.file_name;

            assert(~isempty(SMARTS_input.input_string), ...
                'No configuration has been set');

            if isempty(file_name)
                file_name = 'smarts295.inp.txt';
            end

            if ~contains(file_name, '.inp.txt')
                file_name = [file_name, '.inp.txt'];
            end

            if isempty(file_path)
                dt = datestr(datetime('now'));
                dt = dt(1:end-3);
                file_path = [userpath, '/SMARTS/', strrep(dt, ' ', '_')];
            end

            assert(~isempty(file_path), ...
                ['No path found, not even "userpath", '...
                '... something has gone terribly wrong']);

            if ~isdir(file_path);
                mkdir(file_path);
            end

            destination = [file_path, file_name];
            % disp(destination)
            fileID = fopen(destination, 'w');
            fprintf(fileID, SMARTS_input.input_string);
            result = fclose(fileID);

            if 0 == result
                success = true;
            end

        end

        function [SMARTS_input, success, destination] = run_smarts(SMARTS_input, varargin)

            % assert((~isempty(SMARTS_input.smarts_path)) ...
            %     & isdir(SMARTS_input.smarts_path), 'No valid path for SMARTS');

            success = false;

            p = inputParser;
            addParameter(p, 'file_path', '');
            addParameter(p, 'file_name', '');

            parse(p, varargin{:});
            
            if true == ispc
                SMARTS_input.input_string = replace(SMARTS_input.input_string, newline, [char(13), char(10)]);
            end
            
            [write_success, destination] = SMARTS_input.write_file(...
                                            file_path=p.Results.file_path, ...
                                            file_name=p.Results.file_name);

            assert(write_success, 'Writing SMARTS input failed');
            assert(isfile(destination), 'Input file has been lost');

            parts = strsplit(destination, '/');
            target = [SMARTS_input.smarts_path, 'smarts295.inp.txt'];
            data_path = strrep(destination, parts{end}, '');

            status = copyfile(destination, target);
            assert(isfile(target), 'Input file has been lost during copy');
            exe = [SMARTS_input.smarts_path, 'smarts295bat'];
            cur_dir = pwd;
            cd(SMARTS_input.smarts_path);
            [~, ~] = system('./smarts295bat');

            movefile('./smarts295.ext.txt', strrep(destination, 'inp', 'ext'));
            movefile('./smarts295.out.txt', strrep(destination, 'inp', 'out'));
            SMARTS_input.current_ext_file_path = strrep(destination, 'inp', 'ext');
            % disp(SMARTS_input.current_ext_file_path)

            cd(cur_dir);
            success = true;
        end


        function data = read_file(SMARTS_input)

            assert(~isempty(SMARTS_input.current_ext_file_path), ...
                'No data file to read');

            assert(isfile(SMARTS_input.current_ext_file_path), ...
                'No file at location');

            data = readtable(SMARTS_input.current_ext_file_path);

        end

    end
end
