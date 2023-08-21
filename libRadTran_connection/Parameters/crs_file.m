classdef crs_file
    properties (SetAccess = protected)
        Species
        File
    end
    methods
        function cf = crs_file(species, file)
            arguments (Repeating)
                species {mustBeMember(species, { ...
                    'O3',   'O2', 'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                file {mustBeFile}
            end
            cf.Species = species;
            cf.File = file;
        end
    end
end
