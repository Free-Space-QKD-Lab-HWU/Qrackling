classdef Atmosphere_Spectral_Filter < SpectralFilter
    %%ATMOSPHERE_SPECTRAL_FILTER implement a spectral filter which models the
    %%atmosphere
    methods
        function ASF = Atmosphere_Spectral_Filter(Elevation, Wavelength, Visibility)
            %%create an atmosphere spectral filter with the given visibility
            
            %% input validation
            assert(isvector(Elevation)&&isnumeric(Elevation),'Elevation must be a numeric vector')
            assert(isvector(Wavelength)&&isnumeric(Wavelength),'Wavelength must be a numeric vector')
            assert(isvector(Visibility)&&iscell(Visibility)||ischar(Visibility),'Visibility must be a cell of text entries or a single char array')
            assert(numel(Visibility)==1||numel(Visibility)==numel(Elevation),'Visibility must either have a single entry or the same number of entries as Elevation')
            %% default visibility is clear
            if nargin<3
                Visibility='clear';
            end
            
            %% create an atmospheric spectral filter for each elevation value
            sz=size(Elevation);
            %create an array of atmospheric spectral filters of the same size as
            %the elevation array
            ASF@SpectralFilter();
            ASF=repmat(ASF,sz);

            %% iterating over the different types of atmosphere simulated
            Visibilities=unique(Visibility);
            for Visibility=Visibilities(:)
                    %get visibility tag out
                    Visibility = Visibility{:}; %#ok<FXSET> 
                    %% load data
                    switch Visibility
                        case 'clear'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance.mat');
                        case '50km'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance50km.mat');
                        case '20km'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance20km.mat');
                        case '10km'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance10km.mat');
                        case '5km'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance5km.mat');
                        case '2km'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance2km.mat');
                        case '1km'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance1km.mat');
                        case '500m'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance500m.mat');
                        case '200m'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance200m.mat');
                        case '100m'
                            Data=load('Elevation_Wavelength_Atmospheric_Transmittance100m.mat');
                        otherwise
                            error(sprintf(['Visibility must be one of the following:\n', ...
                                '50km\n', ...
                                '20km\n', ...
                                '10km\n', ...
                                '5km\n', ...
                                '2km\n', ...
                                '1km\n', ...
                                '500m\n', ...
                                '200m\n', ...
                                '100m\n']));
                    end
        
                    %% interpolate to correct elevation
                    %if no wavelength provided, import value
                    if nargin<2||isempty(Wavelength)
                    Wavelength = Data.Wavelength;
                    end

                    %if elevation is below minimum simulated (nominally 10
                    %degrees) then set to this limit
                    Elevation(Elevation<min(Data.Elevation))=min(Data.Elevation);

                    %interpolate
                    Transmittance = interp2(Data.Elevation,Data.Wavelength,Data.Transmittance,Elevation,Wavelength);
                    %deal with negative elevations- making them have zero transmittance
                    Transmittance(isnan(Transmittance))=0;
                   

                    for i=1:sz(2) %iterating over all elevation values,
                        % but only altering ones with this visibility tag
                        if numel(Visibilities)==1||isequal(Visibility,Visibilities{i})
                        ASF(i).wavelengths=Wavelength;
                        ASF(i).transmission=Transmittance(:,i);
                        end
                    end
            end
        end
    end
end