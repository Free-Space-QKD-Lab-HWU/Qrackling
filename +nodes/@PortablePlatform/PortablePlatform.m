classdef PortablePlatform < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter
    properties
        N_Steps {mustBeScalarOrEmpty, mustBePositive}
        % Beacon beacon.Beacon
        % Camera beacon.Camera
        LLAT (:, 1) struct = struct('LLA', [], 'Time', duration.empty());
    end

    methods
        function PortablePlatform = PortablePlatform(LLAT, Telescope, options)
            arguments
                LLAT (:, 4) {mustBeNumeric}
                Telescope (1, 1) components.Telescope
                options.Source (1, 1) components.Source
                options.Detector (1, 1) components.Detector
                options.Beacon (1, 1) beacon.Beacon
                options.Camera (1, 1) beacon.Camera
                options.Name {mustBeTextScalar}
                options.SatCommsToolbox (1, 1) satelliteScenario
            end

            llat = struct;
            lat = LLAT(:, 1);
            lon = LLAT(:, 2);
            alt = LLAT(:, 3);
            llat.LLA = [lat, lon, alt];
            llat.Time = LLAT(:, 4);
            PortablePlatform.LLAT = llat;
            PortablePlatform.Telescope = Telescope;

            if ismember('Source', fieldnames(options))
                PortablePlatform.Source = options.Source;
            end

            if ismember('Detector', fieldnames(options))
                PortablePlatform.Detector = options.Detector;
            end

            if ismember('Beacon', fieldnames(options))
                PortablePlatform.Beacon = options.Beacon;
            end

            if ismember('Camera', fieldnames(options))
                PortablePlatform.Camera = options.Camera;
            end

            if ismember('Name', fieldnames(options))
                PortablePlatform.Name = options.Name;
            end

            % need matlab 2024 or greater to use platforms in the satellite 
            % communications toolbox
            [v_str, ~] = version;
            CellTake = @(c_arr, n) c_arr{n};
            v = str2double(CellTake(strsplit(v_str, "."), 1));

            if ismember('SatCommsToolbox', fieldnames(options)) && v >= 24
                trajectory = geoTrajectory(PortablePlatform.LLAT.LLA, PortablePlatform.LLAT.Time');
                sim_platform = platform(options.SatCommsToolbox, trajectory);
                PortablePlatform.ToolboxObj = sim_platform;
                PortablePlatform.HasToolboxObj = true;
            end

        end
    end
end
