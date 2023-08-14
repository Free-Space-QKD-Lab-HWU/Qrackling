classdef ic_habit_yang2013
    properties
        Type
    end
    methods
        function ic = ic_habit_yang2013(type)
            arguments
                type {mustBeMember(type, {...
                    'column_8elements',      'droxtal', ...
                    'hollow_bullet_rosette', 'hollow_column', ...
                    'plate',                 'plate_10elements',      ...
                    'plate_5elements',       'solid_bullet_rosette', ...
                    'solid_column'})}
            end
            ic.Type = type;
        end
    end
end

