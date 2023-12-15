classdef albedo_file
    properties (Access = protected)
        File {mustBeFile}
   end

   methods
        function af = albedo_file(F)
            arguments
                F {mustBeFile}
            end
            af.File = F;
        end
   end
end
