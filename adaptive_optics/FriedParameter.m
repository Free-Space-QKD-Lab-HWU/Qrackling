classdef FriedParameter

    properties
        Link_Direction nodes.LinkDirection
        Cn2_Model
    end

    methods

        function FP = FriedParameter(Link_Direction, options)
            arguments
                Link_Direction nodes.LinkDirection
                options.Hufnagel_Valley HufnagelValley
                options.AirForceGeophysicsLab AFGL_Plus
            end

            names = fieldnames(options);
            assert(numel(names) <= 1, ...
                'Only one model from the cn2 module must be supplied');

            FP.Cn2_Model = options.(names{1});
            FP.Link_Direction = Link_Direction;
        end

        function r0 = AtmosphericTurbulenceCoherenceLength(FP, ...
            Slant_Range, Zenith_Angle, Wavelength,  options)

            arguments
                FP FriedParameter
                Slant_Range {mustBeNumeric}
                Zenith_Angle {mustBeNumeric}
                Wavelength {mustBeNumeric}
                options.Range_Unit units.Magnitude = "Kilo"
                options.Wavelength_Unit units.Magnitude = "nano"
            end

            range = units.Magnitude.Convert( ...
                options.Range_Unit, "Kilo", Slant_Range);

            switch FP.Link_Direction
                case nodes.LinkDirection.Downlink
                    kernel = @(Xi) ...
                        FP.Cn2_Model.Calculate( ...
                            FP.Link_Direction.Height(range, Zenith_Angle, Xi) ...
                            .* (Xi.^(5/3)) ...
                        );

                case nodes.LinkDirection.Uplink
                    kernel = @(Xi) ...
                        FP.Cn2_Model.Calculate( ...
                            FP.Link_Direction.Height(range, Zenith_Angle, Xi) ...
                            .* ((1-Xi).^(5/3)) ...
                        );
            end

            wavenumber = ...
                units.Magnitude.Convert( ...
                    options.Wavelength_Unit, ...
                    "micro", ...
                    Wavelength) ...
                ./ (2 * pi);

            r0 = ( ...
                  0.423 ...
                  .* (wavenumber ^ 2) ...
                  .* secd(Zenith_Angle) ...
                  .* integral(kernel, 0, 1) ...
                ) .^ (-3/5);
        end

    end
end
