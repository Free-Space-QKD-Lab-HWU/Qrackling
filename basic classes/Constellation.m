%Author: Peter Barrow
%Data: 11/7/22

classdef Constellation
    properties
        scenario = nan;
        Satellites = {Satellite.empty(0)};
        toolbox_satellites = {satellite.empty(0)};
        N = nan;
        startTime;
        stopTime;
        sampleTime;
    end

    methods
        function Constellation = Constellation(varargin)

            p = inputParser;

            addParameter(p, 'source', nan);
            addParameter(p, 'telescope', nan);
            addParameter(p, 'startTime', nan);
            addParameter(p, 'stopTime', nan);
            addParameter(p, 'sampleTime', nan);
            addParameter(p, 'TLE', '');
            addParameter(p, 'name', '');
            addParameter(p, 'KeplerElements', []);
            addParameter(p, 'semiMajorAxis', [])
            addParameter(p, 'eccentricity', []);
            addParameter(p, 'inclination', []);
            addParameter(p, 'rightAscensionOfAscendingNode', []);
            addParameter(p, 'argumentOfPeriapsis', []);
            addParameter(p, 'trueAnomaly', []);

            parse(p, varargin{:});

            %if any(isnan([p.Results.source, p.Results.telescope]))
            %    error('Source and / or telescope not supplies');
            %end

            source = p.Results.source;
            telescope = p.Results.telescope;

            t_start = p.Results.startTime;
            t_stop = p.Results.stopTime;
            t_sample = p.Results.sampleTime;

            Constellation.startTime = p.Results.startTime;
            Constellation.stopTime = p.Results.stopTime;
            Constellation.sampleTime = p.Results.sampleTime;


            sma = p.Results.semiMajorAxis;
            ecc = p.Results.eccentricity;
            inc = p.Results.inclination;
            raan = p.Results.rightAscensionOfAscendingNode;
            aop = p.Results.argumentOfPeriapsis;
            ta = p.Results.trueAnomaly;

            if ~any([isdatetime(t_start), isdatetime(t_stop)])
                error('Not supplied: startTime, stopTime and sampleTime');
            end
            
            Constellation.scenario = satelliteScenario(t_start, ...
                                                       t_stop, ...
                                                       t_sample);
            
            if ~isempty(p.Results.TLE)
                satellites = satellite(Constellation.scenario, ...
                                       p.Results.TLE, ...
                                       'OrbitPropagator', 'sgp4');
                Constellation.N = max(size(Constellation.scenario.Satellites));
                Constellation = initialise_satellite_objects(Constellation, ...
                                                            source, ...
                                                            telescope);
                return
            end

            % If we have got this far we must have some kepler elements as
            % input in some form, we check anyway and exit if we don't
            % small note: 'apply_kepler' is here mostly to make this all a bit
            % easier to read and to avoid some extra levels of indentation
            apply_kepler = false;
            if ~isempty(p.Results.KeplerElements)
                kepler_elements = p.Results.KeplerElements;
                apply_kepler = true;
            end

            assert(6 == size(kepler_elements) * [0, 1]');

            lengths = utils().lengths(sma, ecc, inc, raan, aop, ta);
            %this logic is not quite right, this shouldnt be reached if the above test passes
            %if ~isnan(all(lengths == lengths(1)))
            %    apply_kepler = true;
            %    kepler_elements = [sma', ecc', inc', raan', aop', ta'];
            %end

            if ~apply_kepler
                error(['No data given, please supply one of the following', ...
                       newline, char(9), 'a Two-Line element set', ... 
                       newline, char(9), 'A matrix of kepler elements', ... 
                       newline, char(9), 'An array for each kepler element']) 
                return 
            end

            if (1 == sum(1 == size(kepler_elements)))
                Constellation.N = 1;
            elseif (2 == sum(1 == size(kepler_elements)))
                Constellation.N = 6;
            else
                Constellation.N = size(kepler_elements) * (6 ~= size(kepler_elements))';
            end

            if ~isempty(p.Results.name)
                names = p.Results.name;
            else
                names = createNames(Constellation);
            end

            if Constellation.N >= 1;
                Constellation = addSatelliteFromKepler(Constellation, ... 
                                                       kepler_elements, ...
                                                       names);
            end

            Constellation = initialise_satellite_objects(Constellation, ...
                                                          source, ...
                                                          telescope);
        end

        function Constellation = initialise_satellite_objects(Constellation, ...
                                                              source, ...
                                                              telescope)
            for i= 1:Constellation.N
                tb_sat = Constellation.scenario.Satellites(i);
                Constellation.toolbox_satellites{i} = tb_sat;
                sat = Satellite(source, telescope, ...
                                startTime= Constellation.startTime, ...
                                stopTime= Constellation.stopTime, ...
                                sampleTime= Constellation.sampleTime, ...
                                ToolBoxSatellite = tb_sat, ...
                                name=matlab.lang.internal.uuid());
                Constellation.Satellites{i} = sat;
            end
        end

        function names = createNames(Constellation)
            names = cell(1, Constellation.N);
            for i = 1 : Constellation.N
                names{i} = convertStringsToChars(matlab.lang.internal.uuid());
            end
        end

        function Constellation = addSatelliteFromKepler(Constellation, kepler_mat, names)

            if 1 == Constellation.N
                [sma, ecc, inc, raan, aop, ta] = utils().splat(kepler_mat);

                satellites = satellite(Constellation.scenario, ...
                                       sma, ecc, inc, raan, aop, ta, ...
                                       'Name', names);

            else
                for i = 1 : Constellation.N
                    [sma, ecc, inc, raan, aop, ta] = utils().splat(kepler_mat(i,:));

                    satellites = satellite(Constellation.scenario, ...
                                           sma, ecc, inc, raan, aop, ta, ...
                                           'Name', names{i}, ...
                                           'OrbitPropagator', 'sgp4');
                end
            end
        end

        function [sma, ecc, inc, raan, aop, ta] = elementsFromScenario(self, scenario)
            orbitalElements = scenario.orbitalElements;
            sma = utils().meanmotion2semimajoraxis(orbitalElements.MeanMotion);
            ecc = orbitalElements.Eccentricity;
            inc = orbitalElements.Inclination;
            raan = orbitalElements.RightAscensionOfAscendingNode;
            aop = orbitalElements.ArgumentOfPeriapsis;
            ta = utils().eccentricity2trueAnomaly(ecc, orbitalElements.MeanAnomaly);
        end
    end
end
