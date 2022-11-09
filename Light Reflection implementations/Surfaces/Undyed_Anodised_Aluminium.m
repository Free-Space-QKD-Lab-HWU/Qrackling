classdef Undyed_Anodised_Aluminium < Surface_Imported_from_Paper
    properties(Abstract = false)
        DataFileLocation = 'Undyed Anodised Aluminium surface.mat'
    end

    methods 
        function UAA = Undyed_Anodised_Aluminium(Area)
        %%UNDYED ANODISED ALUMINIUM constructor
        UAA@Surface_Imported_from_Paper(Area);
        end
    end
end
