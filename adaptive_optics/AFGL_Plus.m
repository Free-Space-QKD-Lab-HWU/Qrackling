classdef AFGL_Plus

    properties(SetAccess=private, Hidden)
        AtmosphericProfile
        WindModel
    end

    methods

        function AFGLP = AFGL_Plus()
        end

        function AFGLP = UsingAtmosphereProfile(AFGLP, AtmosphereProfile)
            arguments
                AFGLP AFGL_Plus
                AtmosphereProfile StandardAtmosphere
            end
            AFGLP.AtmosphericProfile = AtmosphereProfile;
        end

        function AFGLP = UsingWindModel(AFGLP, WindModel)
            arguments
                AFGLP AFGL_Plus
                WindModel BuftonWindProfile
            end
            AFGLP.WindModel = WindModel;
        end

        function result = RefractiveIndexStructureConstant(AFGLP, Altitudes, options)
            arguments
                AFGLP AFGL_Plus
                Altitudes
                options.WindModel BuftonWindProfile
                options.AtmosphereProfile StandardAtmosphere
            end

            wind_model = AFGLP.WindModel;
            atmospheric_profile = AFGLP.AtmosphericProfile;

            opts = fieldnames(options);
            if contains(opts, 'WindModel')
                wind_model = options.WindModel;
            end
            if contains(opts, 'AtmosphereProfile')
                atmospheric_profile = options.AtmosphereProfile;
            end

            Y = AFGL_Plus.EmpiricalFunction_Y( ...
                Altitudes, ...
                wind_model, ...
                AtmosphereProfile=atmospheric_profile);

            disp(AFGL_Plus.MParameter(Altitudes))
            result = ...
                2.8 ...
                .* (AFGL_Plus.MParameter(Altitudes).*2) ...
                .* (0.1 ^ (4/3)) ...
                .* (10 .^ Y);
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

            g = 9.81; % km/s2
            Gamma = 9.8; % K/km -> dray adiabatic lapse rate
            N_Squared = (g .* (lapse_rate + Gamma)) ./ temperature;
            result = ((-79e-6) .* pressure .* N_Squared) ./ (g .* temperature);
        end

        function result = EmpiricalFunction_Y(Altitudes, WindModel, options)
            arguments
                Altitudes
                WindModel BuftonWindProfile
                options.AtmosphereProfile StandardAtmosphere
            end

            lapse_rate = options.AtmosphereProfile.TemperatureGradient(Altitudes);
            wind_speed = WindModel.Calculate(Altitudes);
            wind_shear = gradient(wind_speed);

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
                wind_shear(mask_lower_troposphere), ...
                lapse_rate(mask_lower_troposphere));

            result(mask_troposphere) = AFGL_Plus.Troposphere( ...
                wind_shear(mask_troposphere), ...
                lapse_rate(mask_troposphere));

            result(mask_stratosphere) = AFGL_Plus.Stratosphere( ...
                wind_shear(mask_stratosphere), ...
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
