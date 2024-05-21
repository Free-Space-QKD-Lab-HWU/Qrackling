classdef Environment
    % a class which describes the conditions around a receiver,  including
    % atmospheric attenuation and background light

    properties (SetAccess=protected, GetAccess=public)
        %different wavelengths have different environment data
        wavelengths (1, :) {mustBeNumeric, mustBeNonnegative}
        %coordinate system (in degrees)
        headings (1, :) {mustBeNumeric}
        elevations (1, :) {mustBeNumeric}


        %%%%%%% these quantities should all have dimensions
        %%%%%%% [numel(wavelengths),numel(headings),numel(elevations)]
        %atmospheric attenuation (in absolute terms) for the full atmosphere thickness
        attenuation {mustBeNumeric, mustBeNonnegative, mustBeLessThanOrEqual(attenuation, 1)}

        attenuation_unit {mustBeMember(attenuation_unit, ["probability", "dB"])} = "probability"

        %background light,  quantified as spectral radiance (W/m^2 str nm)
        spectral_radiance {mustBeNumeric, mustBeNonnegative}
    end

    methods (Static)
        function Env = Load(filename)
            %create an environment from a .mat file in which one is stored
            arguments (Input)
                filename {mustBeFile}
            end

            load(filename, 'headings');
            load(filename, 'elevations');
            load(filename, 'wavelengths');
            load(filename, 'spectral_radiance');
            load(filename, 'attenuation');
            load(filename, 'attenuation_unit');
            Env = environment.Environment(headings,elevations,wavelengths,...
                                          spectral_radiance,attenuation,'attenuation_unit',attenuation_unit);

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

        function Env = empty()
            %conform to MATLAB class standard by providing an empty
            %constructor
            Env = environment.Environment(0,0,0,0,0);
        end

    end

    % Public Methods of Environment
    methods
        %construct an environment object
        function Env = Environment(headings, elevations, wavelengths, ...
                                   spectral_radiance, attenuation, options)

            arguments
                headings {mustBeNumeric, mustBeVector, mustBeInRange(headings, 0, 360)}
                elevations {mustBeNumeric, mustBeVector, mustBeInRange(elevations, -90, 90)}
                wavelengths {mustBeNumeric, mustBeNonnegative, mustBeVector}
                spectral_radiance {mustBeNumeric, mustBeNonnegative}
                attenuation {mustBeNumeric, mustBeNonnegative}% mustBeLessThanOrEqual(attenuation,1)}
                options.attenuation_unit {mustBeMember(options.attenuation_unit, ["probability", "dB"])} = "probability"
            end

            % sort,  tidy and bound inputs
            %heading,  elevation and wavelength must be increasing
            assert(environment.Environment.IsIncreasing(headings), 'headings must be increasing')
            assert(environment.Environment.IsIncreasing(elevations), 'elevations must be increasing')
            assert(environment.Environment.IsIncreasing(wavelengths), 'wavelengths must be increasing')

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
            Env.spectral_radiance = spectral_radiance;
            Env.attenuation = attenuation;
            Env.attenuation_unit = options.attenuation_unit;

            %check that sizes are compatible
            mustHaveCompatibleData(Env);
        end

        function Save(Env, filename)
            %save the data in the current environment to a .mat file
            arguments
                Env environment.Environment
                filename {mustBeText}
            end

            %validate sizes
            mustHaveCompatibleData(Env);

            %store
            headings = Env.headings; %#ok<*PROPLC>
            elevations = Env.elevations;
            wavelengths = Env.wavelengths;
            spectral_radiance = Env.spectral_radiance;
            attenuation = Env.attenuation;
            attenuation_unit = Env.attenuation_unit;

            save(filename, 'headings', 'elevations', 'wavelengths', ...
                    'spectral_radiance', 'attenuation', 'attenuation_unit');
        end

        function Env = mustHaveCompatibleData(Env)
            % a validator function which checks that all arrays are the
            % correct dimensions

            %get dimensions of axes
            N_headings = numel(Env.headings);
            N_elevations = numel(Env.elevations);
            N_wavelengths = numel(Env.wavelengths);

            correct_size = [N_wavelengths, N_headings, N_elevations];
            
            %check dimensions of data
            assert(isequal(size(Env.attenuation,[1,2,3]), correct_size), ...
                'attenuation array is wrong size');
            assert(isequal(size(Env.spectral_radiance,[1,2,3]), correct_size), ...
                'spectral_radiance array is wrong size');
        end

        function interp_data = Interp(Env, data, headings, elevations, wavelengths)
            %output a sample of the requested data interpolated in heading, 
            %elevation and wavelength

            arguments
                Env environment.Environment
                data {mustBeMember(data, {'attenuation', 'spectral_radiance'})}
                headings {mustBeNumeric, mustBeInRange(headings, 0, 360)}
                elevations {mustBeNumeric, mustBeInRange(elevations, -90, 90)}
                wavelengths {mustBeNumeric}
            end

            %input validation
            assert(all(size(headings) == size(elevations)), ...
                'requested heading and elevation arrays must be of same size')
            assert(isscalar(wavelengths) || all(size(wavelengths) == size(elevations)), ...
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
            case 'spectral_radiance'
                Array = Env.spectral_radiance;
            end

            %interpolate
            if 1 == numel(Env.wavelengths)
                interp_data = interpn( ...
                    Env.headings, Env.elevations, ...
                    squeeze(Array),           ...
                    headings,   elevations);
            else
                interp_data = interpn( ...
                    Env.wavelengths, Env.headings, Env.elevations, ...
                    Array,           ...
                    wavelengths,     headings,   elevations);

                % detect if some headings were above the max and interpolate
                headings_above_top_indices = Env.headings(end) < headings & headings <= 360;

                if any(headings_above_top_indices)
                    interp_data(headings_above_top_indices) = interpn( ...
                        Env.wavelengths, ...
                        [Env.headings(end), Env.headings(1) + 360], ...
                        Env.elevations, ...
                        Array(:, [end, 1], :), ...
                        wavelengths(headings_above_top_indices), ...
                        headings(headings_above_top_indices), ...
                        elevations(headings_above_top_indices));
                end

                % detect if some headings were below minimum and interpolate
                headings_below_bottom_indices = Env.headings(1) > headings&headings >= 0;

                if any(headings_below_bottom_indices)
                    interp_data(headings_below_bottom_indices) = interpn( ...
                        Env.wavelengths, ...
                        [Env.headings(end) - 360, Env.headings(1)], ...
                        Env.elevations, ...
                        Array(:, [end, 1], :), ...
                        wavelengths(headings_below_bottom_indices),...
                        headings(headings_below_bottom_indices), ...
                        elevations(headings_below_bottom_indices));
                end

                % detect if some elevations were below the minimum and use
                % the nearest value
                elevations_below_minimum_indices = Env.elevations(1) > elevations;

                if any(elevations_below_minimum_indices)
                    interp_data(elevations_below_minimum_indices) = interpn( ...
                        Env.wavelengths, ...
                        Env.headings, ...
                        Array(:, :, 1), ...
                        wavelengths(elevations_below_minimum_indices), ...
                        headings(elevations_below_minimum_indices));
                    warning('Elevation goes below minimum provided in environment. Using minimum value of %i degrees',Env.elevations(1))
                end

                % detect if some elevations were below the minimum and use
                % the nearest value
                elevations_above_maximum_indices = Env.elevations(end) < elevations;

                if any(elevations_above_maximum_indices)
                    interp_data(elevations_above_maximum_indices) = interpn( ...
                        Env.wavelengths, ...
                        Env.headings, ...
                        Array(:, :, end), ...
                        wavelengths(elevations_above_maximum_indices), ...
                        headings(elevations_above_maximum_indices));
                    warning('Elevation goes below minimum provided in environment. Using nearest value of %i',Env.elevations(1))
                end

            end

            if any(isnan(interp_data))
                warning('Interpolation failed. this was not corrected by Environment interpolator')
            end

            % set format of interp_data, use a "Loss.m" class for attenuation
            switch data
            case 'spectral_radiance'
                return
            otherwise
                temp = units.Loss(Env.attenuation_unit, "attenuation", interp_data);
                interp_data = temp.ConvertTo(Env.attenuation_unit);
            end

        end

        function Plot(Env,DataType,options)
            % plot data from a skyscan in a consistent polar format

            arguments
                Env environment.Environment
                %DataType {mustBeMember(DataType,{'transmission','transmission dB','spectral radiance'})}
                DataType {mustBeMember(DataType,{'attenuation','attenuation dB','spectral radiance'})}
                options.Name {mustBeText} = '';
                options.Colourmap = 'turbo';
                options.CLims(1,2) {mustBeNumeric} = [nan,nan];
                options.Size {mustBeScalarOrEmpty,mustBeNonnegative} = 50;
                options.ColourScale {mustBeMember(options.ColourScale,{'log','linear','auto'})} = 'auto'
            end

            % prepare data
            %what data are we plotting?
            switch DataType
                case 'attenuation'
                    Values = Env.attenuation;
                case 'attenuation dB'
                     Values = -10*log10(Env.attenuation);
                case 'spectral radiance'
                    Values = Env.spectral_radiance;
            end

            %headings and elevations
            [Heading_Grid,Elevation_Grid]=meshgrid(Env.headings,Env.elevations);

            % enforce some defaults
            if isempty(options.Name)
                %set label for plots
                switch DataType
                    case 'spectral radiance'
                        options.Name = 'Spectral Radiance (W/m^2 str nm)';
                    case 'attenuation'
                        options.Name = 'attenuation';
                    case 'attenuation dB'
                         options.Name = 'attenuation (dB)';
                end
            end

            if all(isnan(options.CLims))
                %if no colour limits provided,
                % set colour limits based on data
                switch DataType
                    case 'spectral radiance'
                        options.CLims = [median(Values(~isinf(Values)),"all")/100,max(Values(~isinf(Values)),[],'all')];
                    case 'attenuation'
                        options.CLims = [0,1];
                    case 'attenuation dB'
                         options.CLims = [min(Values(~isinf(Values)),[],"all"),median(Values(~isinf(Values)),'all')+10];
                end

            end

            if isequal(options.ColourScale,'auto')
                switch DataType
                    case 'attenuation'
                        options.ColourScale = 'log';
                    case 'attenuation dB'
                        options.ColourScale = 'linear';
                    case 'spectral radiance'
                        options.ColourScale = 'log';
                end
            end

            % plot intensity over sky
            % create a UI figure
            sky_fig = uifigure('WindowState','maximized');
            Axes = polaraxes(sky_fig);

            %create a scrollbar to allow time data to vary
            Wavelength_Range = [min(Env.wavelengths),max(Env.wavelengths)];
            scrollbar = uislider("Value",max(Wavelength_Range),...
                "Limits",Wavelength_Range,...
                'MajorTicks',Wavelength_Range(1):100:Wavelength_Range(2),...
                'ValueChangedFcn',@(scrollbar,event) UpdatePlot(scrollbar,Axes,...
                Values,Heading_Grid,Elevation_Grid,...
                Env.wavelengths,options),...
                'CreateFcn',@(scrollbar,event) UpdatePlot(scrollbar,Axes,...
                Values,Heading_Grid,Elevation_Grid,...
                Env.wavelengths,options),...
                'Orientation','vertical',...
                'Parent',sky_fig); %#ok<*NASGU>
            label = uilabel("Text",'Wavelength (nm)','Position',[50,65,400,35],'FontSize',24,'Parent',sky_fig,'FontName',get(groot,'defaultAxesFontName'));

            function UpdatePlot(scrollbar,Axes,...
                    Values,Heading_Grid,Elevation_Grid,...
                    Wavelengths,options)
                % prepare plot data
                Current_Wavelength = scrollbar.Value;
                Wavelength_Index=round(interp1(Wavelengths,1:numel(Wavelengths),Current_Wavelength));
                %Current_Values = squeeze(Values(Wavelength_Index,:,:))';
                Current_Values = flipud(squeeze(Values(Wavelength_Index,:,:))');
                Current_Values(isinf(Current_Values)) = nan;


                % perform plot
                Plot = polarscatter(Axes,deg2rad(Heading_Grid(:)),Elevation_Grid(:),options.Size,Current_Values(:),'filled');

                % prepare axes
                %set up axis for this particular plot
                Axes.RDir='reverse';
                Axes.ThetaDir = "clockwise";
                Axes.ThetaZeroLocation='top';
                Axes.RLim=[0,90];
                Axes.RTickLabel = cellfun(@(x) append(num2str(x),sprintf ('%c',char(176))),Axes.RTickLabel,'UniformOutput',false);

                set(Axes,'ColorScale',options.ColourScale)

                colormap(Axes,options.Colourmap);
                clim(Axes,options.CLims)
                C = colorbar(Axes,"eastoutside");
                C.Label.String = options.Name;
                C.Label.FontName = get(groot,"defaultAxesFontName");
                C.Label.FontSize = get(groot,"defaultAxesFontSize");
            end
        end
    end
end
