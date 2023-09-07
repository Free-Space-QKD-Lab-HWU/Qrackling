function r0 = AtmosphericTurbulenceTest(Link_Direction, ...
    Slant_Range, Zenith_Angle, Wavenumber,  Range_Unit)

    arguments
        Link_Direction LinkDirection
        Slant_Range {mustBeNumeric}
        Zenith_Angle {mustBeNumeric}
        Wavenumber {mustBeNumeric}
        Range_Unit OrderOfMagnitude = OrderOfMagnitude.Kilo
    end

    exponent = OrderOfMagnitude.Ratio(Range_Unit, "Kilo");
    range = Slant_Range .* (10 ^ exponent);

    switch Link_Direction
        case LinkDirection.Downlink
            kernel = @(Xi) ...
                Link_Direction.Height(range, Zenith_Angle, Xi) ...
                .* (Xi.^(5/3));

        case LinkDirection.Uplink
            kernel = @(Xi) ...
                Link_Direction.Height(range, Zenith_Angle, 1-Xi) ...
                .* ((1-Xi).^(5/3));
    end

    r0 = ( ...
          0.423 ...
          .* (Wavenumber ^ 2) ...
          .* secd(Zenith_Angle) ...
          .* integral(kernel, 0, 1) ...
        ) .^ (-3/5);
end