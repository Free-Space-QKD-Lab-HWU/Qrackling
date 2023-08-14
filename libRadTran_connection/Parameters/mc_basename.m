classdef mc_basename
    properties
        Name
    end
    methods
        function mc = mc_basename(name)
            arguments
                name {mustBeText}
            end
            mc.Name = name;
        end
    end
end
