classdef ic_habit
    properties
        Type
    end
    methods
        function ic = ic_habit(type)
            arguments
                type {mustBeMember(type, {...
                    'solid-column', 'hollow-column', 'rough-aggregate', ...
                    'rosette-4',    'rosette-6',     'plate', ...
                    'droxtal',      'dendrite',      'spheroid'})}
            end
            ic.Type = type;
        end
    end
end
