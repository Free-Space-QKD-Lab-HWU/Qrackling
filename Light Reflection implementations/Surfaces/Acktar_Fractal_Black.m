classdef Acktar_Fractal_Black < Surface_Imported_from_Paper
    properties(Abstract = false)
        DataFileLocation = 'Acktar Fractal Black surface.mat'
    end

    methods 
        function AFB = Acktar_Fractal_Black(Area)
        %%ACKTAR_FRACTAL_BLACK constructor
        AFB@Surface_Imported_from_Paper(Area);
        end
    end
end
