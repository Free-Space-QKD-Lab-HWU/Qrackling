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
            radiance_file = radiance_file.readInputFile();
            radiance_file = radiance_file.readOutputFile();
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

            radiance_file.radiances = zeros(numel(str_radiances), n_radiances);
            for i = 1:numel(str_radiances)
                radiance_file.radiances(i, :) = ...
                    str2num(strjoin(str_radiances{i}));
            end

        end

        function [index, closest] = findClosestWavelength(radiance_file, target)
            [wvl, index] = min(abs(radiance_file.wavelengths - target));
            closest = radiance_file.wavelengths(index);
        end

        function radiance_mat = pickRadianceForWavelength(radiance_file, wavelength)
            [index, closest] = radiance_file.findClosestWavelength(wavelength);
            radiance_mat = reshape( ...
                radiance_file.radiances(index, :), ...
                numel(radiance_file.elevations), ...
                numel(radiance_file.azimuths));
        end

    end

end
