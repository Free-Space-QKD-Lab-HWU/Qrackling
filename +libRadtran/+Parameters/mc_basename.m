classdef mc_basename
    properties
        Name
    end
    methods
        function mc = mc_basename(name)
            arguments
                name {mustBeText}
            end
            disp(name)
            mc.Name = adduserpath(name);
        end
    end
end
