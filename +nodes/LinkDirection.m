classdef LinkDirection
% LinkDirection
%
% Enumeration of different link directions modeled in the optical simulation.
%
% Syntax:
% dir = nodes.LinkDirection.Downlink

    enumeration
        Downlink
        Uplink
        Intersatellite
        Terrestrial
        % TODO: Add HAP type (free-space in atmosphere)
        % TODO: Add fibre link support via optional argument to determineLinkDirection
    end


    methods (Static)
        function link_direction = determineLinkDirection(receiver, transmitter)
        % determineLinkDirection
        %
        % Determine the link direction between a transmitter and receiver.
        %
        % Syntax:
        % link_direction = LinkDirection.determineLinkDirection(receiver, transmitter)
        %
        % Inputs:
        % receiver    - subclass of nodes.FreeSpaceOpticalNode
        % transmitter - subclass of nodes.FreeSpaceOpticalNode
        %
        % Output:
        % link_direction - LinkDirection enum value

            arguments
                receiver {utilities.mustBeSubclassOf(receiver, 'nodes.FreeSpaceOpticalNode')}
                transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.FreeSpaceOpticalNode')}
            end

            switch class(transmitter)
                case "nodes.Satellite"
                    switch class(receiver)
                        case "nodes.Satellite"
                            link_direction = nodes.LinkDirection.Intersatellite;
                        case "nodes.GroundStation"
                            link_direction = nodes.LinkDirection.Downlink;
                    end

                case "nodes.GroundStation"
                    switch class(receiver)
                        case "nodes.Satellite"
                            link_direction = nodes.LinkDirection.Uplink;
                        case "nodes.GroundStation"
                            link_direction = nodes.LinkDirection.Terrestrial;
                    end
            end
        end


        function h = layerHeight(link, slant_range, zenith_angle)
        % layerHeight
        %
        % Compute the height of an atmospheric layer intersected by a slanted link.
        %
        % Syntax:
        % h = LinkDirection.layerHeight(link, slant_range, zenith_angle)
        %
        % Inputs:
        % link         - LinkDirection enum value
        % slant_range  - numeric, slant path length (km)
        % zenith_angle - numeric, zenith angle (degrees)
        %
        % Output:
        % h - numeric, height of the layer (km)

            arguments
                link LinkDirection
                slant_range {mustBeReal, mustBeNumeric, mustBePositive}
                zenith_angle {mustBeReal, mustBeNumeric}
            end

            switch link
                case LinkDirection.Downlink
                    h = LinkDirection.height(slant_range, zenith_angle, 0.5);
                case LinkDirection.Uplink
                    h = LinkDirection.height(slant_range, zenith_angle, 0.5);
            end
        end


        function h = height(slant_range, zenith_angle, xi)
        % height
        %
        % Compute the height above Earth's surface for a slanted optical link.
        %
        % Syntax:
        % h = LinkDirection.height(slant_range, zenith_angle, xi)
        %
        % Inputs:
        % slant_range  - numeric, slant path length (km)
        % zenith_angle - numeric, zenith angle (degrees)
        % xi           - numeric, fractional distance along slant path (0 < xi <= 1)
        %
        % Output:
        % h - numeric, height above Earth's surface (km)

            arguments
                slant_range {mustBeReal, mustBeNumeric, mustBePositive}
                zenith_angle {mustBeReal, mustBeNumeric}
                xi {mustBeReal, mustBePositive, mustBeLessThanOrEqual(xi, 1)}
            end

            earth_radius = 6371;  % km

            ratio = (slant_range .* xi) ./ earth_radius;

            h = (earth_radius ...
                .* sqrt(1 + (2 .* ratio .* cosd(zenith_angle)) + (ratio .^ 2))) ...
                - earth_radius;
        end
    end
end