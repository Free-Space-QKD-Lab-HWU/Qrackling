classdef Black_Anodised_Aluminium < Surface_Imported_from_Paper
    properties(Abstract = false)
        DataFileLocation = 'Black Anodised Aluminium surface.mat'
    end

    methods 
        function BAA = Black_Anodised_Aluminium(Area)
        %%BLACK_ANODISED ALUMINIUM constructor
        BAA@Surface_Imported_from_Paper(Area);
        end
    end
end
