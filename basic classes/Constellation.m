%Author: Peter Barrow
%Data: 11/7/22

classdef Constellation
    properties
        scenario = nan;
        Satellites Satellite
        toolbox_satellites
        N = nan;
        startTime;
        stopTime;
        sampleTime;
    end

    methods
        function Constellation = Constellation(Source,Telescope,varargin)

            p = inputParser;

            addRequired(p, 'source');
            addRequired(p, 'telescope');
            addParameter(p, 'TLE', '');
            addParameter(p, 'name', '');
            addParameter(p, 'KeplerElements', []);
            addParameter(p, 'semiMajorAxis', [])
            addParameter(p, 'eccentricity', []);
            addParameter(p, 'inclination', []);
            addParameter(p, 'rightAscensionOfAscendingNode', []);
            addParameter(p, 'argumentOfPeriapsis', []);
            addParameter(p, 'trueAnomaly', []);
            
            % constellation should default to a trivial simulation just to
            % implement satellites
            %addParameter(p, 'startTime', datetime('now'));
            %addParameter(p, 'stopTime', datetime('now')+seconds(1));
            %addParameter(p, 'sampleTime',seconds(1));
            
            parse(p, Source, Telescope, varargin{:});

            %if any(isnan([p.Results.source, p.Results.telescope]))
            %    error('Source and / or telescope not supplies');
            %end

            source = p.Results.source;
            telescope = p.Results.telescope;
            

            %t_start = p.Results.startTime;
            %t_stop = p.Results.stopTime;
            %t_sample = p.Results.sampleTime;
            %%if sample time is a duration, convert to a double in seconds
            %if isduration(t_sample)
            %    t_sample=seconds(t_sample);
            %end

            %Constellation.startTime = p.Results.startTime;
            %Constellation.stopTime = p.Results.stopTime;
            %Constellation.sampleTime = p.Results.sampleTime;


            sma = p.Results.semiMajorAxis;
            ecc = p.Results.eccentricity;
            inc = p.Results.inclination;
            raan = p.Results.rightAscensionOfAscendingNode;
            aop = p.Results.argumentOfPeriapsis;
            ta = p.Results.trueAnomaly;

            %if ~any([isdatetime(t_start), isdatetime(t_stop)])
            %    error('Not supplied: startTime, stopTime and sampleTime');
            %end

            %Constellation.scenario = satelliteScenario(t_start, ...
            %    t_stop, ...
            %    t_sample);

            %if ~isempty(p.Results.TLE)
            %    satellites = satellite(Constellation.scenario, ...
            %        p.Results.TLE, ...
            %        'OrbitPropagator', 'sgp4');
            %    Constellation.N = max(size(Constellation.scenario.Satellites));
            %    Constellation = initialise_satellite_objects(Constellation, ...
            %        source, ...
            %        telescope);
            %    return
            %end

            % If we have got this far we must have some kepler elements as
            % input in some form, we check anyway and exit if we don't
            % small note: 'apply_kepler' is here mostly to make this all a bit
            % easier to read and to avoid some extra levels of indentation


            %first, check if kepler elements are provided individually
            lengths = utils().lengths(sma, ecc, inc, raan, aop, ta);
            if ~isnan(all(lengths == lengths(1)))
                kepler_elements = [sma', ecc', inc', raan', aop', ta'];
                %otherwise, check for a complete set provided in a vector
            elseif ~isempty(p.Results.KeplerElements)
                kepler_elements = p.Results.KeplerElements;

                %if neither of these pass then we need more information
            else
                error(['No data given, please supply one of the following', ...
                    newline, char(9), 'a Two-Line element set', ...
                    newline, char(9), 'A matrix of kepler elements', ...
                    newline, char(9), 'An array for each kepler element'])
            end
            %check the set of elements is complete
            assert(6 == size(kepler_elements) * [0, 1]');

            if (1 == sum(1 == size(kepler_elements)))
                Constellation.N = 1;
            elseif (2 == sum(1 == size(kepler_elements)))
                Constellation.N = 6;
            else
                Constellation.N = size(kepler_elements) * (6 ~= size(kepler_elements))';
            end
            


            %if Constellation.N >= 1
            %    Constellation = addSatelliteFromKepler(Constellation, ...
            %        kepler_elements, ...
            %        names);
            %end

            %% if no names provided, create unique numbers
            if ~isempty(p.Results.name)
                names = p.Results.name;
            else
                names = createNames(Constellation);
            end

            Constellation = initialise_satellite_objects(Constellation, ...
                source, ...
                telescope,...
                kepler_elements,...
                names);
        end

        function Constellation = initialise_satellite_objects(Constellation, ...
                source, ...
                telescope,...
                kepler_elements,...
                names)


            %{
            %% initialise properties to the correct classes with the first entry
            tb_sat = Constellation.scenario.Satellites(1);
            Constellation.toolbox_satellites = tb_sat;
            sat = Satellite(source, telescope, ...
                startTime= Constellation.startTime, ...
                stopTime= Constellation.stopTime, ...
                sampleTime= Constellation.sampleTime, ...
                ToolBoxSatellite = tb_sat, ...
                KeplerElements = kepler_elements,...
                name=tb_sat.Name);
            Constellation.Satellites = sat;
            %now iterate backwards through rest of array to save
            %resizing array every time
            if Constellation.N>=2
                for i= 2:Constellation.N
                    tb_sat = Constellation.scenario.Satellites(i);
                    Constellation.toolbox_satellites(i) = tb_sat;
                    sat = Satellite(source, telescope, ...
                        startTime= Constellation.startTime, ...
                        stopTime= Constellation.stopTime, ...
                        sampleTime= Constellation.sampleTime, ...
                        ToolBoxSatellite = tb_sat, ...
                        name=tb_sat.Name);
                    Constellation.Satellites(i) = sat;
                end
            end
            %}

            %% create satellite objects with the provided kepler elements
            for i=1:Constellation.N
                %iterating over satellites
                Satellites(i)=Satellite(source,telescope,...
                    'SemimajorAxis',kepler_elements(i,1),...
                    'Eccentricity',kepler_elements(i,2),...
                    'Inclination',kepler_elements(i,3),...
                    'RightAscensionofAscendingNode',kepler_elements(i,4),...
                    'ArgumentofPeriapsis',kepler_elements(i,5),...
                    'TrueAnomaly',kepler_elements(i,6),...
                    'Name',names(i)); %#ok<*PROPLC> 
            end
            Constellation.Satellites=Satellites;
        end


        function NameCellArray = createNames(Constellation)
            %%CREATENAMES create a cell array of character vectors which are
            %%unique satellite IDs
            NameChars=strsplit(num2str(1:Constellation.N),' ');
            NameCellArray=cellstr(NameChars);

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

        
        function SatQKDScenario = AddSatellites(Constellation,SatQKDScenario)
            %%ADDSATELLITES add satellites to the given SatQKDScenario object


            %% iterate through satellites
            for i=1:Constellation.N
                %add each to the toolbox scenario inside SatQKDScenario
                SatQKDScenario.toolbox_scenario=AddSatelliteToToolboxScenario(Constellation.Satellites(i),SatQKDScenario.toolbox_scenario);
            end
        end

        %function show(Constellation)
        %    %%SHOW display constellation in the MATLAB satellite viewer
        %    show(Constellation.toolbox_satellites)
        %end
    end
end
