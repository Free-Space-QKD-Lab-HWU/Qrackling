classdef StandardAtmosphere
    properties

        layer = [0, 1, 2, 3, 4, 5, 6, 7]
        height = [0, 11, 20, 32, 47, 51, 71, 84.8]
        temperature_gradient = [−6.5, 0.0, 1.0, 2.8, 0.0, −2.8, −2.0]
        temperature = [288, 217, 217, 229, 271, 271, 215, 188]
        pressure = [1013, 226, 54.7, 8.68, 1.11, 0.67, 0.04, 0.004]

    end

    methods

        function StdAtm = StandardAtmosphere()
        end

        function T = Temperature(StdAtm, altitude, options)
            arguments
                StdAtm StandardAtmosphere
                altitude double
                options.Layer = NaN
            end

            if isnan(options.Layer)
                layer = sum(StdAtm.height < altitude) + 1;
            else
                layer = options.Layer;
            end

            altitude_difference = altitude - StdAtm.height(layer);
            T = StdAtm.temperature(layer) ...
                + (StdAtm.temperature_gradient(layer) * altitude_difference);
        end

        function P = Pressure(StdAtm, altitude, options)
            arguments
                StdAtm StandardAtmosphere
                altitude double
                options.Layer = NaN
                options.Temperature = NaN
            end

            if isnan(options.Layer)
                layer = sum(StdAtm.height < altitude) + 1;
            else
                layer = options.Layer;
            end

            if isnan(options.Temperature)
                T = StdAtm.Temperature(altitude, Layer=layer);
            else
                T = options.Temperature;
            end

            g = 9.8;
            R = 287.053;
            P_layer = StdAtm.pressure(layer);
            altitude_difference = altitude - StdAtm.height(layer);

            P = P_layer * exp(-(altitude_difference * g) / (R * T));
        end

        function n = AltitudeDependentRefractiveIndex(StdAtm, Altitude, Wavelength)
            arguments
                StdAtm StandardAtmosphere
                Altitude double
                Wavelength double
            end

            layer = sum(StdAtm.height < Altitude) + 1;
            H = StdAtm.height(layer)
            n_i = StandardAtmosphere.AtmosphericRefractiveIndex(Wavelength, Altitude);
            n_i = 1 + (n_i ./ 1e8);
            altitude_difference = H - altitude;
            dn_dh = StdAtm.RefractiveIndexGradient(Altitude, Wavelength);

            n = n_i + (dn_dh .* altitude_difference);
        end

        function dn_dh = RefractiveIndexGradient(StdAtm, Altitude, Wavelength)
            layer = sum(StdAtm.height < Altitude) + 1;
            h_0 = StdAtm.height(layer)
            n_0 = StandardAtmosphere.AtmosphericRefractiveIndex(Wavelength, n_0);
            n_0 = 1 + n_0;
            h_1 = Altitude;
            n_1 = StandardAtmosphere.AtmosphericRefractiveIndex(Wavelength, n_1);
            n_1 = 1 + n_1;
            dn_dh = (n_1 - n_0) / (h_1 - h_0);
        end

    end

    methods (Static, Access=private)

        function n_1 = AtmosphericRefractiveIndex(Wavelength, Altitude, options)
            arguments
                Wavelength double
                Altitude double
                options.WavelengthUnit OrderOfMagnitude = OrderOfMagnitude.micro
            end

            % Equations here expect to be in terms of µm
            ratio = OrderOfMagnitude ...
                .Ratio(OrderOfMagnitude.micro, options.WavelengthUnit);
            wavelength = Wavelength * (10 ^ ratio);

            PascalFromMbar = @(mbar) mbar .* 100;
            KelvinFromCelcius = @(celcius) celcius + 273.15;

            layer = sum(StdAtm.height < altitude) + 1;
            T = KelvinFromCelciu( ...
                StandardAtmosphere.Temperature(Altitude, Layer=layer));
            P = PascalFromMbar( ...
                StandardAtmosphere.Pressure(Altitude, Layer=layer, Temperature=T));
            n_1_s = StandardAtmosphere.DispersionEquation(wavelength);

            n_1 = ((P .* n_1_s) ./ 96095.43) ...
                .* ((1 + ((1e-8) .* (0.601 - (0.00972 .* T)))) ...
                    ./ (1 + 0.0036610 .* T));
        end

        function n_1_s = DispersionEquation(Wavelength)
            arguments
                Wavelength double
            end

            ratio = OrderOfMagnitude ...
                .Ratio(OrderOfMagnitude.micro, options.Magnitude);
            wavelength = Wavelength * (10 ^ ratio);

            wl = (1 ./ wavelength) .^ 2;
            n_1_s = 8342 + (2406147 ./ (130 - wl)) + (15998 ./ (38.9 - wl));
            n_1_s = n_1_s ./ (1e8);
        end

        function N = RelativeNumberDensity(altitude, options)
            arguments
                altitude double
                options.ObserverNumberDensity = 2.55e25
                options.H0 = 6600
            end
            N = exp(-altitude / options.H0) ./ options.ObserverNumberDensity;
        end


    end

end
