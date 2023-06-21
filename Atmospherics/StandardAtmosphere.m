classdef StandardAtmosphere
    properties

        layer = [0, 1, 2, 3, 4, 5, 6, 7]
        height = [0, 11, 20, 32, 47, 51, 71, 84.8]
        temperature_gradient = [6.5 * (-1), 0.0, 1.0, 2.8, 0.0, 2.8 * (-1), 2.0 * (-1), 2.0 * (-1)]
        % temperature_gradient
        temperature = [288, 217, 217, 229, 271, 271, 215, 188]
        pressure = [1013, 226, 54.7, 8.68, 1.11, 0.67, 0.04, 0.004]

    end

    properties (Hidden)
        temperature_lerp
        gradient_lerp
        pressure_lerp
    end

    methods

        function StdAtm = StandardAtmosphere()
            StdAtm.temperature_gradient = gradient(StdAtm.temperature, StdAtm.height);
            StdAtm.temperature_lerp = interp1( ...
                StdAtm.height, StdAtm.temperature, 'pchip', 'pp');

            StdAtm.gradient_lerp = interp1( ...
                StdAtm.height, StdAtm.temperature_gradient, ...
                'pchip', 'pp');

            StdAtm.pressure_lerp = interp1( ...
                StdAtm.height, StdAtm.pressure, ...
                'pchip', 'pp');
        end

        function Steps = StepMask(StdAtm, Altitudes)
            Steps = sum(Altitudes >= StdAtm.height');
        end

        function delta = AltitudeDifference(StdAtm, Altitudes)
            % difference ('delta') between target altitude ('Altitudes') and 
            % layer that the model has been discretized over
            layers = StdAtm.StepMask(Altitudes);
            delta = Altitudes - StdAtm.height(layers);
        end

        function T = Temperature(StdAtm, Altitudes)
            arguments
                StdAtm StandardAtmosphere
                Altitudes
            end

            delta = StdAtm.AltitudeDifference(Altitudes);
            T = ppval(StdAtm.temperature_lerp, Altitudes) ...
                + ppval(StdAtm.gradient_lerp, Altitudes) .* delta;
        end

        function temp_grad = TemperatureGradient(StdAtm, Altitudes)
            arguments
                StdAtm StandardAtmosphere
                Altitudes
            end
            temp_grad = ppval(StdAtm.gradient_lerp, Altitudes);
        end

        function P = Pressure(StdAtm, Altitudes)
            arguments
                StdAtm StandardAtmosphere
                Altitudes double
            end

            g = 9.8;
            R = 287.053;

            delta = StdAtm.AltitudeDifference(Altitudes);
            T_interp = ppval(StdAtm.temperature_lerp, Altitudes);
            P_interp = ppval(StdAtm.pressure_lerp, Altitudes);
            P = P_interp .* exp(-(delta) .* g ./ (R .* T_interp));
        end

        function dispersion = DispersionEquation(StdAtm, Wavelength, options)
            arguments
                StdAtm StandardAtmosphere
                Wavelength
                options.WavelengthUnit OrderOfMagnitude = OrderOfMagnitude.micro
            end

            WavelengthUnitDefault = OrderOfMagnitude.micro;
            exponent = OrderOfMagnitude ...
                .Ratio(options.WavelengthUnit, WavelengthUnitDefault);

            Wavelength = Wavelength .* (10 ^ exponent);

            wl = (1 ./ Wavelength).^2;
            dispersion = 8342.54 ...
                + (2406147 ./ (130 - wl)) + (25998 ./ (38.9 - wl));
            dispersion = dispersion ./ (1e8);
        end

        function n = AtmosphericRefractiveIndex(StdAtm, Wavelength, Altitudes, options)
            arguments
                StdAtm StandardAtmosphere
                Wavelength
                Altitudes
                options.WavelengthUnit OrderOfMagnitude = OrderOfMagnitude.micro
            end

            WavelengthUnitDefault = OrderOfMagnitude.micro;
            exponent = OrderOfMagnitude ...
                .Ratio(options.WavelengthUnit, WavelengthUnitDefault);

            Wavelength = Wavelength .* (10 ^ exponent);

            PascalFromMbar = @(mbar) mbar .* 100;
            CelciusFromKelvin = @(kelvin) kelvin - 273.15;

            T_interp = ppval(StdAtm.temperature_lerp, Altitudes);
            T = CelciusFromKelvin(T_interp);

            P_interp = ppval(StdAtm.pressure_lerp, Altitudes);
            P = PascalFromMbar(P_interp);

            n_1s = StdAtm.DispersionEquation(Wavelength);

            n_1 = ((P .* n_1s) ./ 96095.43) ...
                .* ( ...
                    (1 + (1e-8 ./ (0.601 - (0.00972 .* T)) .* P)) ...
                    ./ (1 + (0.0036610 .* T)) ...
                );
            n = 1 + n_1;
        end

        function n = AltitudeDependentRefractiveIndex(StdAtm, Wavelength, ...
            Altitudes, options)

            arguments
                StdAtm StandardAtmosphere
                Wavelength
                Altitudes
                options.WavelengthUnit OrderOfMagnitude = OrderOfMagnitude.micro
            end

            WavelengthUnitDefault = OrderOfMagnitude.micro;
            exponent = OrderOfMagnitude ...
                .Ratio(options.WavelengthUnit, WavelengthUnitDefault);

            Wavelength = Wavelength .* (10 ^ exponent);

            n = StdAtm.AtmosphericRefractiveIndex(Wavelength, Altitudes);
            delta = StdAtm.AltitudeDifference(Altitudes);
            dndh = gradient(n, Altitudes);
            n = n + (dndh .* delta);
        end

    end

end
