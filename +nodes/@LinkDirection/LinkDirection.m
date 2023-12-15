classdef LinkDirection
    enumeration
        Downlink
        Uplink
        Intersatellite
        Terrestrial
        % TODO: add a HAP type, free space in atmosphere
        % TODO add fibre link -> should only require adding a field to ground ...
        % will need to add an optional argument to DetermineLinkDirection so that
        % we can find fibre links
    end

    methods (Static)
        function link_direction = DetermineLinkDirection(receiver, transmitter)
            arguments
                receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
                transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
            end

            switch class(transmitter)

            case "nodes.Satellite"
                switch class(receiver)

                case "nodes.Satellite"
                    link_direction = nodes.LinkDirection.Intersatellite;

                case "nodes.Ground_Station"
                    link_direction = nodes.LinkDirection.Downlink;
                end

            case "nodes.Ground_Station"
                switch class(receiver)

                case "nodes.Satellite"
                    link_direction = nodes.LinkDirection.Uplink;

                case "nodes.Ground_Station"
                    link_direction = nodes.LinkDirection.Terrestrial;
                end

            end
        end

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
