classdef Surface_Imported_from_Paper < Surface
    properties (Abstract)
        DataFileLocation
    end
    properties (SetAccess = protected)
        Reflectance                                                             %diffuse reflectance of a surface at a given wavelength
        Specular_Reflectance_Proportion                                         %proportion of light which is specularly reflected
        Wavelength                                                              %wavelength in nm at which reflectance is measured
    end
    methods
        function Surface_Imported_from_Paper = Surface_Imported_from_Paper(Area)
            %%SURFACE_IMPORTED_FROM_PAPER create an imported surface object

            %create a surface object
            Surface_Imported_from_Paper@Surface(Area);
            %load the internal data
            Surface_Imported_from_Paper=LoadImportedData(Surface_Imported_from_Paper);
        end

        function Imported = LoadImportedData(Imported)
            %%LOADIMPORTEDDATA load import data

            Data = load(Imported.DataFileLocation);
            Imported.Reflectance = Data.Reflectance;
            Imported.Wavelength = Data.Wavelength;
            Imported.Specular_Reflectance_Proportion = Data.Specular_Reflectance_Proportion;
        end

        function Reflectance = GetReflectedLightProportion(Surface, Wavelength, ~, ~)
            %%GETREFLECTEDLIGHTPROPORTION return the proportion of light
            %%reflected at a given angle
            
            %% input validation
            assert(all(Wavelength <= max(Surface.Wavelength))&& all(Wavelength >= min(Surface.Wavelength)),...
                'at least one wavelength lies outside measured data range');

            %% we assume that all reflection is diffuse, as this is by far the most likely eventuality given the enormous ranges involved
            Reflectance_Proportion = interp1(Surface.Wavelength,Surface.Reflectance,Wavelength); %lookup how reflectance varies with wavelength
            Reflectance = Reflectance_Proportion * (1- Surface.Specular_Reflectance_Proportion); %remove light which is specularly reflected
        end
    end
end
