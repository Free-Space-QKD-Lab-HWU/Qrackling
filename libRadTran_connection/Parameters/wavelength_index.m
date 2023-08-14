classdef wavelength_index
    properties (SetAccess = protected)
        Value
    end
    methods
        function wvl = wavelength_index(value)
            arguments
                value {mustBeNumeric, mustBeInteger, mustBeNonzero}
            end
            wvl.Value = value;
        end
    end
end
