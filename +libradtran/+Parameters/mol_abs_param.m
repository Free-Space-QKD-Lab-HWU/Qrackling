classdef mol_abs_param
    properties
        Label
    end
    methods
        function mol = mol_abs_param(label)
            arguments
                label {mustBeMember(label, { ...
                    'reptran fine',   'reptran medium', 'reptran coarse', ...
                    'crs',            'kato',           'kato2',          ...
                    'kato2andwandji', 'kato2_96',       'fu',             ...
                    'avhrr_kratz',    'lowtran',        'sbdart'})}
            end
            mol.Label = label;
        end
    end
end
