classdef FibreNode < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter
% Fibre_Node
% Represents an end of a fibre connection with one or both of a QKD source
% or detector, plus geographic location and timestamp.

    methods
        function FN = FibreNode(options)
        % FibreNode constructor.
        %
        % Options:
        %   Detector  - optional detector object
        %   Source    - optional source object
        %   latitude  - degrees (default 55.911025)
        %   longitude - degrees (default -3.322510)
        %   altitude  - metres (default 10)
        %   LLA       - [lat lon alt]; overrides individual coords if given
        %   Name      - string name (default 'Unnamed Fibre Node')
        %   Time      - datetime (default now)

            arguments
                options.Detector = []
                options.Source = []
                options.latitude (1,1) double = 55.911025
                options.longitude (1,1) double = -3.322510
                options.altitude (1,1) double = 10
                options.LLA = nan
                options.Name = 'Unnamed Fibre Node'
                options.Time datetime = datetime('now')
            end

            % Choose source or detector
            if ~isempty(options.Source)
                FN.Source = options.Source;
            elseif ~isempty(options.Detector)
                FN.Detector = options.Detector;
            else
                error('Fibre_Node:MissingEndpoint', ...
                      'Must provide either a Source or a Detector.')
            end

            % Derive LLA if not provided
            if isnan(options.LLA)
                options.LLA = [options.latitude, ...
                               options.longitude, ...
                               options.altitude];
            end

            % Set location
            FN = setPosition(FN, ...
                'LLA', options.LLA, ...
                'Name', options.Name);

            % Set timestamp
            FN.Time = options.Time;
        end
    end

    methods (Static)
        function FN = empty()
        % empty  Create a default Fibre_Node with a 785 nm Source
            FN = fibre.Fibre_Node('Source', components.Source(785));
        end
    end
end