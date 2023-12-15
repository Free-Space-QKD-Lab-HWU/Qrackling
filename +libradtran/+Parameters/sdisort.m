classdef sdisort
    properties (SetAccess = protected)
        Variable
        Value
    end
    methods
        function sdi = sdisort(label)
            arguments
                label {mustBeMember(label, { ...
                    'single scattering', ...
                    'multiple scattering', ...
                    'no refraction', ...
                    'fast refraction (harsh)', ...
                    'slow refraction (accurate)'})}
            end
            switch label
                case 'single scattering'
                    sdi.Variable = 'nscat';
                    sdi.Value = 1;
                case 'multiple scattering'
                    sdi.Variable = 'nscat';
                    sdi.Value = 2;
                case 'no refraction'
                    sdi.Variable = 'nrefrac';
                    sdi.Value = 0;
                case 'fast refraction (harsh)'
                    sdi.Variable = 'nrefrac';
                    sdi.Value = 1;
                case 'slow refraction (accurate)'
                    sdi.Variable = 'nrefrac';
                    sdi.Value = 2;
            end
        end
    end
end
