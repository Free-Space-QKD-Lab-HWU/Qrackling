classdef rte_solver
    properties (SetAccess = protected)
        Label
    end
    methods
        function rte = rte_solver(label)
            arguments
                label {mustBeMember(label, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3C_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end
            rte.Label = label;
        end
    end

end
