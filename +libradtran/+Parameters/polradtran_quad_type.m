classdef polradtran_quad_type
    properties (SetAccess = protected)
        Label
    end
    methods
        function pol = polradtran_quad_type(label)
            arguments
                label {mustBeMember(label, {'Gaussian', 'Double Gaussian', ...
                    'Lobatto', 'Extra-angle(s)'})}
            end

            l = str2mat(label);
            pol.Label = l(1);
        end
    end
end
