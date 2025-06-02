classdef Fibre_Node < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter

    methods
        function [FN] = Fibre_Node(options)
            % GROUND_STATION instantiate a ground station using either its
            % component classes and requiring a name and location (LLA = lat
            % lon alt)

            % Ground_Station should support an empty constructor to be default
            % instantiated correctly

            arguments
                options.Detector = [];
                options.Source = [];
                options.latitude (1,1) double = 55.911025;
                options.longitude (1,1) double = -3.322510;
                options.altitude (1,1) double = 10;
                options.LLA = nan;
                options.Name = 'Unnamed Fibre Node';
                options.Time datetime = datetime('now');
            end

            %infer correct wavelength from source or detector
            if ~isempty(options.Source)
                %if source is present, use this
                FN.Source = options.Source;
            elseif ~isempty(options.Detector)
                %if detector is present, use this
                FN.Detector = options.Detector;
            else
                error('must provide either a source or detector')
            end

            %parse location (lat, lon, alt)
            if isnan(options.LLA)
                options.LLA = [options.latitude, options.longitude, options.altitude];
            end
            
            % set location using custom method
            FN = SetPosition(FN, ...
                'LLA', options.LLA, ...
                'Name', options.Name);

            % set time
            FN.Time = options.Time;

        end
    end
end