classdef FriedParameter

    properties
        Link_Direction LinkDirection
        Cn2_Model
    end

    methods

        function FP = FriedParameter(Link_Direction, options)
            arguments
                Link_Direction LinkDirection
                options.Hufnagel_Valley HufnagelValley
                options.AirForceGeophysicsLab AFGL_Plus
            end

            names = fieldnames(options);
            if contains(names, 'Hufnagel_Valley')
                FP.Cn2_Model = options.Hufnagel_Valley;
            elseif contains(names, 'AirForceGeophysicsLab')
                FP.Cn2_Model = options.AirForceGeophysicsLab;
            else
                error("No Refractive Index Structure Constant model supplied");
            end

            FP.Link_Direction = Link_Direction;
        end

        function r0 = AtmosphericTurbulenceCoherenceLength(FP, ...
            Slant_Range, Zenith_Angle, Wavenumber)

            arguments
                FP FriedParameter
                Slant_Range {mustBeNumeric}
                Zenith_Angle {mustBeNumeric}
                Wavenumber {mustBeNumeric}
            end

            switch FP.Link_Direction
                case LinkDirection.Downlink
                    kernel = @(Xi) ...
                        FP.Link_Direction.Height(Slant_Range, Zenith_Angle, Xi) ...
                        .* (Xi.^(5/3));

                case LinkDirection.Uplink
                    kernel = @(Xi) ...
                        FP.Link_Direction.Height(Slant_Range, Zenith_Angle, 1-Xi) ...
                        .* ((1-Xi).^(5/3));
            end

            r0 = ( ...
                  0.423 ...
                  .* (Wavenumber ^ 2) ...
                  .* secd(Zenith_Angle) ...
                  .* integral(kernel, 0, 1) ...
                ) .^ (-3/5);
        end

    end
end
