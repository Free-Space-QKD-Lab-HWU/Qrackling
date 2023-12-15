classdef mc_forward_output
    properties (SetAccess = protected)
        Quantity
        Unit
    end
    methods
        function mc = mc_forward_output(quantity, options)
            arguments
                quantity {mustBeMember(quantity, { ...
                    'absorption', 'actinic', 'emission', 'heating'})}
                options.unit {mustBeMember(options.unit, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            mc.Quantity = quantity;
            if contains(fieldnames(options), 'unit')
                mc.Unit = options.unit;
            end
        end
    end
end
