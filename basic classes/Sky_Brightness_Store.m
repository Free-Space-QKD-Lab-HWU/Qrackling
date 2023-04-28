classdef Sky_Brightness_Store
    %% a class which provides an interface for background light calculations.
    %% This defines how sky brightness data should be provided
    properties(SetAccess=public, GetAccess=public)
        %wavelength at which atmospheric is stored in nm
        Wavelengths = [];
        %elevation of atmospheric data in degrees above the horizon
        Elevations = [];
        %"compass" heading of atmospheric data in degrees from north
        Headings = [];


        %how much energy comes out of the sky inside a particular wavelength
        %band, solid angle, area and time. This is an array with dimensions
        %which represent
        %[heading,elevation,wavelength]
        Spectral_Pointance = [];

        %how many photons come out of the sky inside a particular wavelength
        %band, solid angle, area and time. This is an array with dimensions
        %which represent
        %[heading,elevation,wavelength]
        Photon_Flux = [];

    end

    properties(Hidden,SetAccess=private,GetAccess=private)
        %need to store wavelength, heading and elevation as ndgrids in order
        %to interpolate data
        Heading_ndgrid
        Elevation_ndgrid
        Wavelength_ndgrid
    end
    properties(Constant)
        h=6.626E-34;
        c=2.998E8;
    end

    methods
        function SBS = Sky_Brightness_Store(...
                Headings,...
                Elevations,...
                Wavelengths,...
                Spectral_Pointance,...
                varargin)
            %create a sky brightness store object using required and optional inputs
            
            %% FIRST, we must support an option with 1 input, this is a path to a SBS stored as a .mat file
            if nargin == 1
                load(Headings,'SBS');
                return
            end

            %% Otherwise, we proceed to create an SBS
            %% parse inputs
            p=inputParser();
            %required inputs
            ValidateHeadings = @(Head) mustBeVectorBetween(Head,[0,360]);
            addRequired(p,'Headings',ValidateHeadings);
            ValidateElevations = @(El) mustBeVectorBetween(El,[0,90]);
            addRequired(p,'Elevations',ValidateElevations);
            ValidateWavelengths = @(Wvl) mustBeVectorBetween(Wvl,[0,inf]);
            addRequired(p,'Wavelengths',ValidateWavelengths);
            ValidateSpectralPointance = @(SP) all(size(SP)==[numel(Headings),numel(Elevations),numel(Wavelengths)]) && all(SP>=0,'all');
            addRequired(p,'Spectral_Pointance',ValidateSpectralPointance);

            %optional inputs
            addParameter(p,'DOP',[]);

            %parse
            parse(p,Headings,Elevations,Wavelengths,Spectral_Pointance,varargin{:});

            %% disseminate inputs
            SBS.Wavelengths = p.Results.Wavelengths;
            SBS.Elevations = p.Results.Elevations;
            Headings = p.Results.Headings;
            %sort headings to that they are increasing and in the range 0-360
            Headings = mod(Headings,360);
            [Headings,Indices]=sort(Headings,'ascend');
            %sort Spectral Pointance to match
            Spectral_Pointance = p.Results.Spectral_Pointance;
            Spectral_Pointance = Spectral_Pointance(Indices,:,:);
            %store both
            SBS.Headings = Headings;
            SBS.Spectral_Pointance = Spectral_Pointance;
            
            
            %calculate photon flux
            SBS.Photon_Flux = pagemrdivide(SBS.Spectral_Pointance,reshape((SBS.h * SBS.c )./(SBS.Wavelengths * 1E-9),1,1,[]));
            %store heading,elevation,wavelength as meshgrids
            [Heading_Meshgrid,Elevation_Meshgrid,Wavelengths_Meshgrid]=ndgrid(SBS.Headings,SBS.Elevations,SBS.Wavelengths);
            SBS.Heading_ndgrid=Heading_Meshgrid;
            SBS.Elevation_ndgrid=Elevation_Meshgrid;
            SBS.Wavelength_ndgrid=Wavelengths_Meshgrid;
        end

        function Count_Rates = GetSkyCountRate(SBS,Headings,Elevations,Wavelength)
            %% return the count rate of photons from the sky at a particular heading, elevation and wavelength
            %% in units of counts per (second * steradian * m^2 * nm)
            
            %% we assume that heading, elevation, wavelength are a list of request values (so are 1D vectors at most)
            mustBeVector(Headings)
            %convert heading to 0-360
            Headings = mod(Headings,360);
            mustBeVectorBetween(Elevations,[0,90]);
            mustBeVectorBetween(Wavelength,[0,inf]);
            %and that the number of elements in each list is the same
            assert(isequal(numel(Headings),numel(Elevations)),...
                'Number of elements in each of Headings and Elevations must be the same');
            assert(numel(Wavelength)==1,...
                'Wavelength must be scalar');

            Num_Requests = numel(Headings);
            
            %% prepare memory
            Count_Rates=zeros(size(Headings));

            %% interpolate into existing data
            for i=1:Num_Requests
            Count_Rates(i) = interpn(SBS.Heading_ndgrid,SBS.Elevation_ndgrid,SBS.Wavelength_ndgrid,SBS.Photon_Flux,Headings(i),Elevations(i),Wavelength);
            end
            %% check for out-of-range values
            Out_of_Range = isnan(Count_Rates);
            if any(Out_of_Range)
                if all(Out_of_Range)
                    warning('All requested values are out of background light lookup range: Set to 0')
                else
                warning('Some requested values are out of background light lookup range\nSet to 0')
                end
                Count_Rates(Out_of_Range)=0;
            end
        end

        function Sky_Power = GetSkyPower(SBS,Headings,Elevations,Wavelengths)
            %% return the power from the sky at a particular heading, elevation and wavelength
            %% in units of energy per (second * steradian * m^2 * nm)
            
            %% we assume that heading, elevation, wavelength are a list of request values (so are 1D vectors at most)
            mustBeVector(Headings);
            Headings = mod(Headings,360);
            mustBeVectorBetween(Elevations,[0,90]);
            mustBeVectorBetween(Wavelengths,[0,inf]);
            %and that the number of elements in each list is the same
            assert(isequal(numel(Headings),numel(Elevations),numel(Wavelengths)),...
                'Number of elements in each of Headings, Elevations and Wavelengths must be the same');
            Num_Requests = numel(Headings);
            
            %% prepare memory
            Sky_Power=zeros(size(Headings));

            %% interpolate into existing data
            for i=1:Num_Requests
            Sky_Power(i) = interpn(SBS.Heading_ndgrid,SBS.Elevation_ndgrid,SBS.Wavelength_ndgrid,SBS.Spectral_Pointance,Headings(i),Elevations(i),Wavelengths(i));
            end

            %% check for out-of-range values
            Out_of_Range = isnan(Sky_Power);
            if any(Out_of_Range)
                if all(Out_of_Range)
                    warning('All requested values are out of background light lookup range\nSet to 0')
                else
                warning('Some requested values are out of background light lookup range\nSet to 0')
                end
                Sky_Power(Out_of_Range)=0;
            end

        end

        function SaveToFile(SBS,FileName)
            %% Save the contents of a SBS to a .mat file so that it can be recovered later in a controlled manner
            

            %% ensure that FileName has .mat on the end
            %ensure that FileName is a text type
            mustBeText(FileName);
            %ensure that FileName is a char type 
            if isstring(FileName)
                FileName = char(FileName);
            end
            %now that it is a char, ensure that it ends with .mat
            if ~(length(FileName)>5&&all(isequal(FileName(end-3:end),'.mat')))
                FileName = [FileName,'.mat'];
            end

            %% now do saving
            save(FileName,"SBS")
        end
    end
end