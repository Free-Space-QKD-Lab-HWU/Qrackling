classdef mol_modify
    properties (SetAccess = protected)
        Species
        Column
        Unit
    end
    methods
        function mol = mol_modify(species, column, unit)
            arguments (Repeating)
                species {mustBeMember(species, {...
                    'O3',  'O2',  'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                column {mustBeNumeric}
                unit {mustBeMember(unit, {'DU', 'CM_2', 'MM'})}
            end
            assert( ...
                (numel(species) == numel(column)) ...
                == (numel(species) == numel(unit)), ...
                'Must supply same number of Species, Column and Unit')
            mol.Species = species;
            mol.Column = column;
            mol.Unit = unit;
        end
    end
end
