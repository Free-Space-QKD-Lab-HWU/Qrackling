classdef AFGL_Plus

    enumeration
        StandardAtmosphere_Bufton_Pugh2020 ( ...
            StandardAtmosphere, BuftonWindProfile.Pugh_2020)

        StandardAtmosphere_Bufton_Gruneusen2021 ( ...
            StandardAtmosphere, BuftonWindProfile.Gruneisen_2021)

        StandardAtmosphere_HWM ( ...
            StandardAtmosphere, @atmoshwm)
    end

    properties %(SetAccess=private, Hidden)
        AtmosphericProfile
        WindModel
    end

    methods

        function AFGLP = AFGL_Plus(Atmosphere_Model, Wind_Model)
            AFGLP.AtmosphericProfile = Atmosphere_Model;
            AFGLP.WindModel = Wind_Model;
        end

%        function AFGLP = UsingAtmosphereProfile(AFGLP, AtmosphereProfile)
%            arguments
%                AFGLP AFGL_Plus
%                AtmosphereProfile StandardAtmosphere
%            end
%            AFGLP.AtmosphericProfile = AtmosphereProfile;
%        end
%
%        function AFGLP = UsingWindModel(AFGLP, WindModel)
%            arguments
%                AFGLP AFGL_Plus
%                WindModel BuftonWindProfile
%            end
%            AFGLP.WindModel = WindModel;
%        end

        function result = Calculate(AFGLP, Altitudes)
            arguments
                AFGLP AFGL_Plus
                Altitudes
                %options.WindModel BuftonWindProfile
                %options.AtmosphereProfile StandardAtmosphere
            end

            % wind_model = AFGLP.WindModel;
            % atmospheric_profile = AFGLP.AtmosphericProfile;

            % opts = fieldnames(options);
            % if contains(opts, 'WindModel')
            %     wind_model = options.WindModel;
            % end
            % if contains(opts, 'AtmosphereProfile')
            %     atmospheric_profile = options.AtmosphereProfile;
            % end

            Y = AFGL_Plus.EmpiricalFunction_Y( ...
                Altitudes, ...
                AFGLP.WindModel, ...
                AFGLP.AtmosphericProfile);

            M = abs(AFGL_Plus.MParameter(Altitudes)) ./ (1e3);

            result = 2.8 .* (M .^ 2) .* (0.1 ^ (4/3)) .* (10 .^ Y);
        end

    end

    methods(Static, Hidden)

        function result = MParameter(Altitudes, options)
            arguments
                Altitudes
                options.AtmosphereProfile = StandardAtmosphere
            end

            temperature = options.AtmosphereProfile.Temperature(Altitudes);
            pressure = options.AtmosphereProfile.Pressure(Altitudes);
            lapse_rate = options.AtmosphereProfile.TemperatureGradient(Altitudes);
            % lapse_rate = gradient(temperature, Altitudes);

            g = 9.81; % km/s2
            Gamma = 9.8; % K/km -> dray adiabatic lapse rate
            N_Squared = (g .* (lapse_rate + Gamma)) ./ temperature;
            result = ((-79e-6) .* pressure .* N_Squared) ./ (g .* temperature);
        end

        function result = EmpiricalFunction_Y(Altitudes, WindModel, AtmosphereProfile, options)
            arguments
                Altitudes
                WindModel
                AtmosphereProfile StandardAtmosphere
                options.AltitudeUnit OrderOfMagnitude = OrderOfMagnitude.Kilo
            end

            % temperature = options.AtmosphereProfile.Temperature(Altitudes);
            % lapse_rate = gradient(temperature, Altitudes);
            lapse_rate = AtmosphereProfile.TemperatureGradient(Altitudes);

            if ~contains(strjoin({ver().Name}, newline), 'Aerospace')
                error('Aerospce toolbox is not installed, needed for atmoshwm')
            end

            exponent = OrderOfMagnitude.Ratio(options.AltitudeUnit, "none");
            altitudes_metres = Altitudes .* (10^exponent);

            latitudes = 48 .* ones(fliplr(size(altitudes_metres)));
            longitudes = 11.5 .* ones(fliplr(size(altitudes_metres)));
            day = 236 .* ones(fliplr(size(altitudes_metres)));

            wind_speed = atmoshwm( ...
                latitudes, longitudes, altitudes_metres, day=day);

            meridional_wind_shear = gradient(wind_speed(:, 1), altitudes_metres);
            zonal_wind_shear = gradient(wind_speed(:, 2), altitudes_metres);

            vector_vertical_shear = sqrt( ...
                (meridional_wind_shear .^ 2) + (zonal_wind_shear .^ 2))';

            % need to map Altitudes to LowerTroposphere Troposphere and to
            % Stratosphere and call the correct function for the correct
            % altitude
            % Troposphere: 6 -> 20 km
            % Stratosphere: 20 -> 50 km

            mask_lower_troposphere = Altitudes >= 6;
            mask_troposphere = (Altitudes > 6) & (Altitudes <= 20);
            mask_stratosphere = Altitudes > 20;

            result = zeros(size(Altitudes));

            result(mask_lower_troposphere) = AFGL_Plus.LowerTroposphere( ...
                vector_vertical_shear(mask_lower_troposphere), ...
                lapse_rate(mask_lower_troposphere));

            result(mask_troposphere) = AFGL_Plus.Troposphere( ...
                vector_vertical_shear(mask_troposphere), ...
                lapse_rate(mask_troposphere));

            result(mask_stratosphere) = AFGL_Plus.Stratosphere( ...
                vector_vertical_shear(mask_stratosphere), ...
                lapse_rate(mask_stratosphere));
        end

        function result = LowerTroposphere(WindShear, LapseRate)
            assert(utils.sameSize(WindShear, LapseRate), ...
                utils.sameSizeMessage(inputname(1), inputname(2)));

            result = ...
                2.9767 ...
                + (27.9804 .* WindShear) ...
                + (2.9012 .* LapseRate) ...
                + (1.1843 .* (LapseRate .^ 2)) ...
                + (0.1741 .* (LapseRate .^ 3)) ...
                + (0.0086 .* (LapseRate .^ 4));
        end

        function result = Troposphere(WindShear, LapseRate)
            assert(utils.sameSize(WindShear, LapseRate), ...
                utils.sameSizeMessage(inputname(1), inputname(2)));

            result = ...
                0.7152 ...
                + (30.6024 .* WindShear) ...
                + (0.0003 .* LapseRate) ...
                - (0.0057 .* (LapseRate .^ 2)) ...
                - (0.0016 .* (LapseRate .^ 3)) ...
                + (0.0001 .* (LapseRate .^ 4));
        end

        function result = Stratosphere(WindShear, LapseRate)
            assert(utils.sameSize(WindShear, LapseRate), ...
                utils.sameSizeMessage(inputname(1), inputname(2)));

            result = ...
                0.6763 ...
                + (8.15690 .* WindShear) ...
                - (0.05360 .* LapseRate) ...
                + (0.00840 .* (LapseRate .^ 2)) ...
                - (0.00070 .* (LapseRate .^ 3)) ...
                + (0.00002 .* (LapseRate .^ 4));
        end

    end

end
