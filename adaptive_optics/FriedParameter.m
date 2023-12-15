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
            Slant_Range, Zenith_Angle, Wavelength, options)

            arguments
                FP FriedParameter
                Slant_Range {mustBeNumeric}
                Zenith_Angle {mustBeNumeric}
                Wavelength {mustBeNumeric}
                options.Range_Unit units.Magnitude = "Kilo"
                options.Wavelength_Unit units.Magnitude = "nano"
            end

            % FIX: why does this produce r0 values that are 10 times to big?
            % For now, we wont use this method, see loop below
            switch FP.Link_Direction
            case nodes.LinkDirection.Downlink
                kernel = @(Range, Zenith, Xi) ...
                    FP.Cn2_Model.Calculate( ...
                        FP.Link_Direction.Height(Range, Zenith, Xi) ...
                        .* (Xi.^(5/3)) ...
                    );

            case nodes.LinkDirection.Uplink
                kernel = @(Range, Zenith, Xi) ...
                    FP.Cn2_Model.Calculate( ...
                        FP.Link_Direction.Height(Range, Zenith, Xi) ...
                        .* ((1-Xi).^(5/3)) ...
                    );
            end

            range = units.Magnitude.Convert( ...
                options.Range_Unit, "Kilo", Slant_Range);

            integrals = zeros(size(range));
            fun = @(x, alt) FP.Cn2_Model.Calculate(x) .* (1 - (x ./ alt) .^ (5/3));

            switch FP.Link_Direction
            case nodes.LinkDirection.Downlink
                for i = 1:numel(integrals)
                    % integrals(i) = integral(@(x) kernel(range(i), Zenith_Angle(i), x), 0, 1) / numel(range);
                    integrals(i) = integral(@(x) -fun(x, range(i)), range(i), 0);

                end
            case nodes.LinkDirection.Uplink
                for i = 1:numel(integrals)
                    % integrals(i) = integral(@(x) kernel(range(i), Zenith_Angle(i), x), 0, 1) / numel(range);
                    integrals(i) = integral(@(x) -fun(x, range(i)), 0, range(i));
                end
            end

            wavenumber = 2 * pi ...
                / units.Magnitude.Convert( ...
                    options.Wavelength_Unit, "none", Wavelength);

            r0 = (0.423 ...
                .* (wavenumber ^ 2) ...
                .* secd(Zenith_Angle) ...
                .* integrals') .^ (-3/5);

        end

    end
end
