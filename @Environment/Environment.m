classdef Environment
    % a class which describes the conditions around a receiver, including
    % atmospheric transmission and background light

    properties (SetAccess=protected,GetAccess=public)
        %coordinate system (in degrees)
        headings (1,:) {mustBeNumeric}
        elevations (1,:) {mustBeNumeric}

        %different wavelengths have different environment data
        wavelengths (1,:) {mustBeNumeric,mustBeNonnegative}

        %atmospheric transmission (in absolute terms) for the full atmosphere thickness
        transmission {mustBeNumeric,mustBeNonnegative,mustBeLessThanOrEqual(transmission,1)}
        %atmospheric transmission (in dB) for the full atmosphere thickness
        transmission_dB {mustBeNumeric,mustBeNonnegative}

        %background light, quantified as spectral radiance (W/m^2 str nm)
        spectral_radiance {mustBeNumeric,mustBeNonnegative}
    end

    methods (Static)
        function Env = Load(filename)
            %create an environment from a .mat file in which one is stored
            arguments (Input)
                filename {mustBeFile}
            end
            arguments (Output)
                Env Environment
            end

            %load all standard properties into object
            load(filename,"headings","elevations","wavelengths","transmission","spectral_radiance");
            Env = Environment(headings,elevations,wavelengths,transmission,spectral_radiance);

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
                transmission,...
                spectral_radiance)
            %construct an environment object

            arguments
                headings {mustBeNumeric,mustBeVector,mustBeInRange(headings,0,360)}
                elevations {mustBeNumeric,mustBeVector,mustBeInRange(elevations,-90,90)}
                wavelengths {mustBeNumeric,mustBeNonnegative,mustBeVector}
                transmission {mustBeNumeric,mustBeNonnegative,mustBeLessThanOrEqual(transmission,1)}
                spectral_radiance {mustBeNumeric,mustBeNonnegative}
            end

            %% sort, tidy and bound inputs

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
            Env.transmission = transmission;
            Env.transmission_dB = -10*log10(transmission);
            Env.spectral_radiance = spectral_radiance;

            %check that sizes are compatible
            mustHaveCompatibleData(Env);


        end

        function Save(Env,filename)
            %save the data in the current environment to a .mat file
            arguments
                Env Environment
                filename {mustBeText}
            end

            %validate sizes
            mustHaveCompatibleData(Env);

            %store
            headings = Env.headings; %#ok<*PROPLC>
            elevations = Env.elevations;
            wavelengths = Env.wavelengths;
            transmission = Env.transmission;
            spectral_radiance = Env.spectral_radiance;

            save(filename,'headings','elevations','wavelengths','transmission','spectral_radiance');
        end

        function mustHaveCompatibleData(Env)
            % a validator function which checks that all arrays are the
            % correct dimensions

            %get dimensions of axes
            N_headings = numel(Env.headings);
            N_elevations = numel(Env.elevations);
            N_wavelengths = numel(Env.wavelengths);
            correct_size = [N_headings,N_elevations,N_wavelengths];

            %check dimensions of data
            assert(isequal(size(Env.transmission),correct_size),...
                'transmission array is wrong size');
            assert(isequal(size(Env.transmission_dB),correct_size),...
                'transmission_dB array is wrong size');
            assert(isequal(size(Env.spectral_radiance),correct_size),...
                'spectral_radiance array is wrong size');
        end

        function interp_data = Interp(Env,data,headings,elevations,wavelengths)
            %output a sample of the requested data interpolated in heading,
            %elevation and wavelength

            arguments
                Env Environment
                data {mustBeMember(data,{'transmission','transmission_dB','spectral_radiance'})}
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
                case 'transmission'
                    Array = Env.transmission;
                case 'transmission_dB'
                    Array = Env.transmission_dB;
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

        function Plot(Env,DataType,options)
            %% plot data from a skyscan in a consistent polar format

            arguments
                Env Environment
                DataType {mustBeMember(DataType,{'transmission','transmission dB','spectral radiance'})}
                options.Name {mustBeText} = '';
                options.Colourmap = 'turbo';
                options.CLims(1,2) {mustBeNumeric} = [nan,nan];
                options.Size {mustBeScalarOrEmpty,mustBeNonnegative} = 50;
                options.ColourScale {mustBeMember(options.ColourScale,{'log','linear','auto'})} = 'auto'
            end

            %% prepare data
            %what data are we plotting?
            switch DataType
                case 'transmission'
                    Values = Env.transmission;
                case 'transmission dB'
                    Values = Env.transmission_dB;
                case 'spectral radiance'
                    Values = Env.spectral_radiance;
            end

            %headings and elevations
            [Heading_Grid,Elevation_Grid]=meshgrid(Env.headings,Env.elevations);

            %% enforce some defaults
            if isempty(options.Name)
                %set label for plots
                switch DataType
                    case 'spectral radiance'
                        options.Name = 'Spectral Radiance (W/m^2 str nm)';
                    case 'transmission'
                        options.Name = 'Transmission';
                    case 'transmission dB'
                        options.Name = 'Transmission (dB)';
                end
            end

            if all(isnan(options.CLims))
                %if no colour limits provided, use min and max
                options.CLims = [min(Values(~isinf(Values)),[],"all"),max(Values(~isinf(Values)),[],'all')];
            end

            if isequal(options.ColourScale,'auto')
                switch DataType
                    case 'transmission'
                        options.ColourScale = 'log';
                    case 'transmission dB'
                        options.ColourScale = 'linear';
                    case 'spectral radiance'
                        options.ColourScale = 'log';
                end
            end


            %% plot intensity over sky
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
                %% prepare plot data
                Current_Wavelength = scrollbar.Value;
                Wavelength_Index=round(interp1(Wavelengths,1:numel(Wavelengths),Current_Wavelength));
                Current_Values = Values(:,:,Wavelength_Index)';
                Current_Values(isinf(Current_Values)) = nan;


                %% perform plot
                Plot = polarscatter(Axes,deg2rad(Heading_Grid(:)),Elevation_Grid(:),options.Size,Current_Values(:),'filled');
            
                
                %% prepare axes
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