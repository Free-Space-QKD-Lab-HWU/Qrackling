classdef LinkDirection
    enumeration
        Downlink
        Uplink
    end

    methods (Static)
        function h = LayerHeight(Link, Slant_Range, Zenith_Angle)
            arguments
                Link LinkDirection
                Slant_Range {mustBeReal, mustBeNumeric, mustBePositive}
                Zenith_Angle {mustBeReal, mustBeNumeric}
            end

            switch Link
                case LinkDirection.Downlink
                    h = LinkDirection.Height(Slant_Range, Zenith_Angle, xi);
                    return
                case LinkDirection.Uplink
                    h = LinkDirection.Height(Slant_Range, Zenith_Angle, 1-xi);
                    return
            end
        end
    end

    methods (Static)
        function h = Height(Slant_Range, Zenith_Angle, Xi)
            arguments
                Slant_Range {mustBeReal, mustBeNumeric, mustBePositive}
                Zenith_Angle {mustBeReal, mustBeNumeric}
                Xi {mustBeReal, mustBePositive, mustBeLessThanOrEqual(Xi, 1)}
            end

            Earth_Radius = 6371; % km

            ratio = (Slant_Range .* Xi) ./ Earth_Radius;

            h = (Earth_Radius ...
                .* sqrt(1 + (2 .* ratio .* cosd(Zenith_Angle)) + (ratio .^ 2))) ...
                - Earth_Radius;
        end
    end
end
