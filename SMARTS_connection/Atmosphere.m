classdef Atmosphere

    properties
        data;

        wavelengths;
        sky_dome;
        fields;

        Azimuth;
        Elevation;

        current_conditions;

    end

    methods

        function Atmosphere = Atmosphere(file_path)
            %MATLAB requires that all objects have empty constructor
            if nargin == 0
                return
            end
            Atmosphere = Atmosphere.LoadAtmosphere(file_path);
            
        end

        function Atmosphere = LoadAtmosphere(Atmosphere, Input)
            %support loading from an already loaded file or a path
            if isstring(Input)||ischar(Input)
            assert(2 == exist(Input), 'File does not exist');
            data = load(Input);

            fields = fieldnames(data);
            assert(convertCharsToStrings(fields{1}) == "atmosphere", ...
                   'Not an atmosphere');
            atmosphere = load(Input).atmosphere;
           elseif isstruct(Input)
                atmosphere = Input;
            end

            Atmosphere.data = atmosphere.values;

            Atmosphere.wavelengths = atmosphere.wavelengths;
            Atmosphere.sky_dome = atmosphere.values;

            [N_a, N_e] = size(atmosphere.values);
            Atmosphere.Azimuth = zeros(size(atmosphere.values));
            Atmosphere.Elevation = zeros(size(atmosphere.values));

            for i = 1 : N_e
                for j = 1 : N_a
                    Atmosphere.Azimuth(j, i) = atmosphere.values{j, i}.azimuth;
                    Atmosphere.Elevation(j, i) = atmosphere.values{j, i}.elevation;
                end
            end

            Atmosphere.fields = fieldnames(Atmosphere.sky_dome{1, 1}.data);

        end


        function [azimuth, elevation, store] = ...
                    extractField(Atmosphere, SatellitePass, Wavelength, Field)

            azimuth = zeros(size(Atmosphere.data));
            elevation = zeros(size(Atmosphere.data));
            store = zeros(size(Atmosphere.data));

            min_idx = find(Atmosphere.wavelengths == Wavelength);
            [nA, nE] = size(Atmosphere.data);

            for i = 1 : nE
                for j = 1 : nA
                    azimuth(j, i) = Atmosphere.data{j, i}.azimuth;
                    elevation(j, i) = Atmosphere.data{j, i}.elevation;
                    store(j, i) = Atmosphere.data{j, i}.data.(Field)(min_idx);
                end
            end

        end


        function conditions = satellitePassConditions(Atmosphere, ...
                                                      SatellitePass, ...
                                                      Wavelengths, ...
                                                      Field)

            conditions = cell(0, 0);
            nWavelengths = numel(Wavelengths);

            azimuth = SatellitePass.Headings(SatellitePass.Elevation_Limit_Flags);
            elevation = SatellitePass.Elevations(SatellitePass.Elevation_Limit_Flags);

            reorderAngles = @(angles) mod((angles - 180), 360);
            azimuth = reorderAngles(azimuth);

            for i = 1 : nWavelengths
                Wavelength = Wavelengths(i);

                [atmos_azimuth, atmos_elevation, store] = Atmosphere.extractField(...
                                    SatellitePass, Wavelength, Field);

                [X, Y] = meshgrid(unique(atmos_azimuth), unique(atmos_elevation));
                [newX, newY] = meshgrid(azimuth, elevation);
                Vq = interp2(X, Y, store', newX, newY, 'cubic', 0);

                condition.pass_elevation = elevation;
                condition.pass_azimuth = azimuth;
                condition.sky_dome_azimuth = atmos_azimuth;
                condition.sky_dome_elevation = atmos_elevation;
                condition.sky_dome = store;
                condition.interpolated_sky_dome = Vq;
                condition.interpolated_azimuth = newX;
                condition.interpolated_elevation = newY;
                condition.field = Field;
                condition.wavelength = Wavelength;
                conditions(i) = {condition};
            end

            if (1 == nWavelengths)
                conditions = conditions{1};
            end

        end

        function fig = plotSurfaceForCondition(Atmosphere, Condition)

            clean_field = replace(Condition.field, '_', ' ');
            fig_title = sprintf('%s around ground station @ %.3g', ...
                                clean_field, Condition.wavelength);

            fig = figure(name = fig_title);
            grid on
            hold on
            N = numel(Condition.pass_elevation);
            line_data = Condition.interpolated_sky_dome(eye(N) == 1);
            plot3(Condition.pass_azimuth, ...
                  Condition.pass_elevation, ...
                  line_data, LineWidth=3, Color='black')
            surf(Condition.interpolated_azimuth, ...
                 Condition.interpolated_elevation, ...
                 Condition.interpolated_sky_dome)
            colormap(summer)
            shading interp
            hold off
            xlim([min(Condition.pass_azimuth), max(Condition.pass_azimuth)])
            ylim([min(Condition.pass_elevation), max(Condition.pass_elevation)])
            zlim([min(min(Condition.interpolated_sky_dome)), ...
                  max(max(Condition.interpolated_sky_dome))])
            xlabel('Aziumth \circ');
            ylabel('Elevation \circ');
            zlabel(sprintf('%s @ %.3gnm', clean_field, Condition.wavelength));
            title(fig_title);

        end

        function fig = plotContourForField(Atmosphere, SatellitePass, Wavelength, Field)

            [atmos_azimuth, atmos_elevation, store] = Atmosphere.extractField(...
                SatellitePass, Wavelength, Field);

            clean_field = replace(Field, '_', ' ');
            fig_title = sprintf('%s around ground station @ %.3g', ...
                                clean_field, Wavelength);
            fig = figure(name = fig_title);
            contourf(atmos_azimuth, atmos_elevation, store);
            xlim([min(min(atmos_azimuth)), ...
                  max(max(atmos_azimuth))])
            ylim([min(min(atmos_elevation)), ...
                  max(max(atmos_elevation))])
            xlabel('Aziumth \circ');
            ylabel('Elevation \circ');
            title(fig_title);

        end

        function fig = plotSurfaceForField(Atmosphere, SatellitePass, Wavelength, Field)
            [atmos_azimuth, atmos_elevation, store] = Atmosphere.extractField(...
                SatellitePass, Wavelength, Field);

            clean_field = replace(Field, '_', ' ');
            fig_title = sprintf('%s around ground station @ %.3g', ...
                                clean_field, Wavelength);
            fig = figure(name = fig_title);
            grid on
            hold on
            surf(atmos_azimuth, atmos_elevation, store);
            xlim([min(min(atmos_azimuth)), ...
                  max(max(atmos_azimuth))])
            ylim([min(min(atmos_elevation)), ...
                  max(max(atmos_elevation))])
            colormap(summer)
            shading interp
            xlabel('Aziumth \circ');
            ylabel('Elevation \circ');
            zlabel(sprintf('%s @ %.3gnm', clean_field, Wavelength));
            title(fig_title);
            hold off

        end


        function fig = plotField(Atmosphere, Field)

            values = Atmosphere.data(:, 1);
            azimuth = zeros(1, numel(values));
            data = zeros(numel(values), numel(values{1}.data.(Field)));

            for i = 1 : numel(values)
                data(i, :) = values{i}.data.(Field);
                azimuth(i) = values{i}.azimuth;
            end

            [X, Y] = meshgrid(Atmosphere.wavelengths, azimuth);

            fig = figure
            axs = {subplot(1, 2, 1), subplot(1, 2, 2)}

            axes(axs{1});
            grid on
            hold on
            surf(X, Y, data, 'FaceAlpha', 0.4)
            colormap(summer)
            shading interp
            xlim([Atmosphere.wavelengths(1), Atmosphere.wavelengths(end)])
            ylim([azimuth(1), azimuth(end)])
            xlabel('Wavelength nm')
            ylabel('Azimth \circ')
            zlabel(replace(Field, '_', ' '))
            hold off

            values = Atmosphere.data(1, :);
            elevation = zeros(1, numel(values));
            data = zeros(numel(values), numel(values{1}.data.(Field)));

            for i = 1 : numel(values)
                data(i, :) = values{i}.data.(Field);
                elevation(i) = values{i}.elevation;
            end

            [X, Y] = meshgrid(Atmosphere.wavelengths, elevation);
            axes(axs{2});
            grid on
            hold on
            surf(X, Y, data, 'FaceAlpha', 0.4)
            colormap(summer)
            shading interp
            xlim([Atmosphere.wavelengths(1), Atmosphere.wavelengths(end)])
            ylim([elevation(1), elevation(end)])
            xlabel('Wavelength nm')
            ylabel('Elevation \circ')
            zlabel(replace(Field, '_', ' '))
            hold off

        end


    end

end