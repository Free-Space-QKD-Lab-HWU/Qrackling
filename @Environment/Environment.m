classdef Environment
    % a class which describes the conditions around a receiver, including
    % atmospheric attenuation and background light

    properties (SetAccess=protected,GetAccess=public)
        %coordinate system (in degrees)
        headings (1,:) {mustBeNumeric}
        elevations (1,:) {mustBeNumeric}

        %different wavelengths have different environment data
        wavelengths (1,:) {mustBeNumeric,mustBeNonnegative}

        %atmospheric attenuation (in absolute terms) for the full atmosphere thickness
        attenuation {mustBeNumeric,mustBeNonnegative,mustBeLessThanOrEqual(attenuation,1)}
        %atmospheric attenuation (in dB) for the full atmosphere thickness
        attenuation_dB {mustBeNumeric,mustBeNonnegative}

        %background light, quantified as spectral radiance (W/m^2 str nm)
        spectral_radiance {mustBeNumeric,mustBeNonnegative}
    end

    methods (Static)
        function Environment = Load(filename)
            %create an environment from a .mat file in which one is stored
            arguments (Input)
                filename mustBeFile
            end
            arguments (Output)
                Environment environment.Environment
            end

            %load all standard properties into object
            Environment.headings = load(filename,'headings');
            Environment.elevations = load(filename,'elevations');
            Environment.attenuation = load(filename,'attenuation');
            Environment.attenuation_dB = load(filename,'attenuation_dB');
            Environment.spectral_radiance = load(filename,'spectral_radiance');

            %check sizes
            mustHaveCompatibleData(Environment);
        end
    
        function bool = IsIncreasing(Vector)
            %function which returns whether a vector is uniformly
            %increasing
            if isscalar(Vector)
                bool = true;
                return
            end

            for i=2:numel(Vector)
                if(Vector(i)<=Vector(i-1))
                    bool = false;
                    return
                end
            end
            bool = true;
        end

    end

    methods
        function Env = Environment(headings,...
                             elevations,...
                             wavelengths,...
                             attenuation,...
                             spectral_radiance)
            %construct an environment object

            arguments
                headings {mustBeNumeric,mustBeVector,mustBeInRange(headings,0,360)}
                elevations {mustBeNumeric,mustBeVector,mustBeInRange(elevations,-90,90)}
                wavelengths {mustBeNumeric,mustBeNonnegative,mustBeVector}
                attenuation {mustBeNumeric,mustBeNonnegative,mustBeLessThanOrEqual(attenuation,1)}
                spectral_radiance {mustBeNumeric,mustBeNonnegative}
            end
            
            %% sort, tidy and bound inputs
            %heading, elevation and wavelength must be increasing
            assert(Environment.IsIncreasing(headings),'headings must be increasing')
            assert(Environment.IsIncreasing(elevations),'elevations must be increasing')
            assert(Environment.IsIncreasing(wavelengths),'wavelengths must be increasing')
            
            %all vectors should be rows
            if iscolumn(headings)
                headings = headings';
            end
            if iscolumn(elevations)
                elevations = elevations';
            end            
            if iscolumn(wavelengths)
                wavelengths = wavelengths';
            end

            %store data to object
            Env.headings = headings;
            Env.elevations = elevations;
            Env.wavelengths = wavelengths;
            Env.attenuation = attenuation;
            Env.attenuation_dB = -10*log10(attenuation);
            Env.spectral_radiance = spectral_radiance;

            %check that sizes are compatible
            mustHaveCompatibleData(Env);


        end
        function Save(Env,filename)
            %save the data in the current environment to a .mat file
            arguments
                Env Environment
                filename mustBeFile
            end

            %validate sizes
            mustHaveCompatibleData(Env);

            %store
            headings = Env.headings; %#ok<*PROPLC>
            elevations = Env.elevations;
            wavelengths = Env.wavelengths;
            attenuation = Env.attenuation;
            attenuation_dB = Env.attenuation_dB;
            spectral_radiance = Env.spectral_radiance;

            save(filename,'headings','elevations','wavelengths','attenuation',...
                    'attenuation_dB','spectral_radiance');
        end

        function mustHaveCompatibleData(Env ...
                )
            % a validator function which checks that all arrays are the
            % correct dimensions

            %get dimensions of axes
            N_headings = numel(Env.headings);
            N_elevations = numel(Env.elevations);
            N_wavelengths = numel(Env.wavelengths);
            correct_size = [N_headings,N_elevations,N_wavelengths];

            %check dimensions of data
            assert(isequal(size(Env.attenuation),correct_size),...
                'attenuation array is wrong size');
            assert(isequal(size(Env.attenuation_dB),correct_size),...
                'attenuation_dB array is wrong size');
            assert(isequal(size(Env.spectral_radiance),correct_size),...
                'spectral_radiance array is wrong size');
        end

        function interp_data = Interp(Env,data,headings,elevations,wavelengths)
            %output a sample of the requested data interpolated in heading,
            %elevation and wavelength

            arguments
                Env Environment
                data {mustBeMember(data,{'attenuation','attenuation_dB','spectral_radiance'})}
                headings {mustBeNumeric,mustBeInRange(headings,0,360)}
                elevations {mustBeNumeric,mustBeInRange(elevations,-90,90)}
                wavelengths {mustBeNumeric}
            end

            %input validation
            assert(all(size(headings)==size(elevations)),...
                'requested heading and elevation arrays must be of same size')
            assert(isscalar(wavelengths)||all(size(wavelengths)==size(elevations)),...
                    'wavelength must be either scalar or the same size as heading and elevation')
            
            if isscalar(wavelengths)
            %make wavelength into an array same size as headings and
            %elevations
                wavelengths = wavelengths*ones(size(headings));
            end

            %get relevant data
            switch data
                case 'attenuation'
                    Array = Env.attenuation;
                case 'attenuation_dB'
                    Array = Env.attenuation_dB;
                case 'spectral_radiance'
                    Array = Env.spectral_radiance;
            end

            %interpolate
            interp_data = interpn(Env.headings,...
                                  Env.elevations,...
                                  Env.wavelengths,...
                                  Array,...
                                  headings,...
                                  elevations,...
                                  wavelengths);

            % detect if some headings were above the max and interpolate
            headings_above_top_indices = Env.headings(end)<headings&headings<=360;
            if any(headings_above_top_indices)
            interp_data(headings_above_top_indices) = interpn([Env.headings(end),Env.headings(1)+360],Env.elevations,Env.wavelengths,Array([end,1],:,:),headings(headings_above_top_indices),elevations(headings_above_top_indices),wavelengths(headings_above_top_indices));
            end
            % detect if some headings were below minimum and interpolate
            headings_below_bottom_indices = Env.headings(1)>headings&headings>=360; 
            if any(headings_below_bottom_indices)
            interp_data(headings_below_bottom_indices) = interpn([Env.headings(end)-360,Env.headings(1)],Env.elevations,Env.wavelengths,Array([end,1],:,:),headings(headings_below_bottom_indices),elevations(headings_above_top_indices),wavelengths(headings_above_top_indices));
            end

            if any(isnan(interp_data))
                warning('some requested data were out of environment data range, these data are returned as nan')
            end
        end
    end
end