classdef mc_polarisation
    properties (SetAccess = protected)
        Value
    end
    methods
        function mc = mc_polarisation(value)
            arguments
                value {mustBeMember(value, { ...
                    '(0) (1,0,0,0) (default)', ...
                    '(1) (1,1,0,0)', ...
                    '(2) (1,0,1,0)', ...
                    '(3) (1,0,0,1)', ...
                    '(-1) (1,-1,0,0)', ...
                    '(-2) (1,0,-1,0)', ...
                    '(-3) (1,0,0,-1)', ...
                    '( 4) Random'})}
            end
            elems = strsplit(value);
            choice = elems(1);
            mc.Value = str2num(choice);
        end
    end
end
