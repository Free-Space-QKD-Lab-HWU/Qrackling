classdef bpdf_tsant_u10
    properties (SetAccess = protected)
        Value {mustBeNumeric}
    end
    methods
        function bpdf = bpdf_tsant_u10(value)
            bpdf.Value = value;
        end
    end
end
