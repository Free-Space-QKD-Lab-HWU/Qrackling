classdef mixing_ratio
    properties (SetAccess = protected)
        Species
        Value
    end
    methods
        function mixing = mixing_ratio(species, value)
            arguments (Repeating)
                species {mustBeMember(species, {'O2', 'H2O', 'CO2', 'NO2', ...
                    'CH4', 'N2O', 'F11', 'F12', 'F22'})}
                value {mustBeNumeric}
            end

            assert(numel(species) == numel(value), ...
                'Must supply equal number of species and values');

            mixing.Species = cellstr(species);
            mixing.Value = cellstr(value);
        end
    end
end

