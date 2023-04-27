classdef radiance_file
    properties
        in_file_path = '';
        out_file_path = '';
        wavelengths = [];
        elevations = [];
        azimuths = [];
        radiances;
    end

    methods
        function radiance_file = radiance_file(in_file_path)
            radiance_file.in_file_path = adduserpath(in_file_path);

            if contains(radiance_file.in_file_path, '.inp')
                radiance_file = radiance_file.readInputFile();
                radiance_file = radiance_file.readOutputFile();
            elseif contains(radiance_file.in_file_path, '.mat')
                radiance_file = radiance_file.readMatFile();
            else
                error('Not a .mat file or libRadtran input file');
            end
        end

        function radiance_file = readMatFile(radiance_file)
            file_contents = load(radiance_file.in_file_path);
            fields = fieldnames(file_contents);
            temp = file_contents.(fields{1});
            assert(numel(fields) == 1, '.mat file should only contain one field');
            radiance_file.wavelengths = temp.wavelengths;
            radiance_file.elevations = temp.elevations;
            radiance_file.azimuths = temp.azimuths;
            radiance_file.radiances = temp.radiances;
        end

        function output_path = writeMatFile(radiance_file, varargin)
            p = inputParser;
            p.addParameter('output_path', '');
            parse(p, varargin{:});

            output_path = p.Results.output_path;
            if isempty(output_path)
                output_path = replace(radiance_file.in_file_path, '.inp', '.mat');
            end

            out_data = struct();
            out_data.wavelengths = radiance_file.wavelengths;
            out_data.elevations  = radiance_file.elevations;
            out_data.azimuths    = radiance_file.azimuths;
            out_data.radiances   = radiance_file.radiances;
            save(output_path, 'out_data');
        end

        function radiance_file = readInputFile(radiance_file)
            found_elevations = false;
            found_azimuths = false;
            found_out_file = false;

            fd = fopen(radiance_file.in_file_path);
            file_line = fgetl(fd);
            while ischar(file_line)
                if ( ...
                    (found_elevations == true) ...
                    & (found_azimuths == true) ...
                    & (found_out_file == true) ...
                    )
                    break
                end

                if contains(file_line, 'umu')
                    elems = strsplit(file_line)';
                    radiance_file.elevations = str2num(strjoin(elems(2:end)));
                    found_elevations = true;
                end

                if contains(file_line, 'phi')
                    elems = strsplit(file_line)';
                    radiance_file.azimuths = str2num(strjoin(elems(2:end)));
                    found_azimuths = true;
                end

                if contains(file_line, 'output_file')
                    elems = strsplit(file_line)';
                    radiance_file.out_file_path = elems{2};
                    found_out_file = true;
                end

                file_line = fgetl(fd);
            end
            fclose(fd);
        end

        function radiance_file = readOutputFile(radiance_file)

            fd = fopen(radiance_file.out_file_path);
            file_line = fgetl(fd);
            wavelengths = {};

            n_radiances = ...
                numel(radiance_file.elevations) ...
                * numel(radiance_file.azimuths);
            str_radiances = {};

            i = 1;
            while ischar(file_line)
                elems = strsplit(file_line);
                wavelengths{i} = elems(2);
                str_radiances{i} = elems(3:n_radiances+2);
                i = i + 1;
                file_line = fgetl(fd);
            end
            radiance_file.wavelengths = str2num(strjoin([wavelengths{1:end}]));
            fclose(fd);

            radiance_file.radiances = zeros( ...
                numel(radiance_file.azimuths), ...
                numel(radiance_file.elevations), ...
                numel(radiance_file.wavelengths) ...
                );

            for i = 1:numel(str_radiances)
                radiance_mat = reshape( ...
                    str2num(strjoin(str_radiances{i})), ...
                    numel(radiance_file.elevations), ...
                    numel(radiance_file.azimuths) ...
                    );
                radiance_file.radiances(:, :, i) = radiance_mat;
            end

        end

        function [index, closest] = findClosestWavelength(radiance_file, target)
            [wvl, index] = min(abs(radiance_file.wavelengths - target));
            closest = radiance_file.wavelengths(index);
        end

        function radiance_mat = pickRadianceForWavelength(radiance_file, wavelength)
            [index, closest] = radiance_file.findClosestWavelength(wavelength);
            radiance_mat = radiance_file.radiances(:, :, index);
        end

        function radiances = radianceFromPass(radiance_file, ...
                wavelength, simulated_elevations, simulated_azimuths, ...
                elevation_limit)
            r_mat = fliplr(radiance_file.pickRadianceForWavelength(wavelength));
            radiances = zeros(size(simulated_elevations));
            for i = 1:numel(simulated_azimuths)
                az = simulated_azimuths(i);
                el = simulated_elevations(i);
                % if we are below the elevation limit then skip to next pair of
                % elevation and azimuth
                if elevation_limit > el
                    continue
                end
                [val, azim_idx] = min(abs(radiance_file.azimuths - az));
                [val, elev_idx] = min(abs(rad2deg(radiance_file.elevations) - el));
                radiances(i) = r_mat(azim_idx, elev_idx);
            end
        end

    end

end
