classdef mol_file
    properties (SetAccess = protected)
        Species
        File
    end
    methods
        function mol = mol_file(species, file)
            arguments
                species {mustBeMember(species, { ...
                    'O3',  'O2',  'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                file {mustBeFile}
            end
            assert(numel(species) == numel(file), ...
                'Must supply a file for each species');
            mol.Species = species;
            mol.File = file;
        end
    end
end
