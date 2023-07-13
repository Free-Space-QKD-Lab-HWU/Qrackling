classdef aerosol_species_file
    enumeration
        continental_clean ('continental_clean'),
        continental_average ('continental_average'),
        continental_polluted ('continental_polluted'),
        urban ('urban'),
        maritime_clean ('maritime_clean'),
        maritime_polluted ('maritime_polluted'),
        maritime_tropical ('maritime_tropical'),
        desert ('desert'),
        antarctic ('antarctic')
    end

    properties
        Label
    end

    methods
        function species_file = aerosol_species_file(file)
            species_file.Label = file
        end
    end

end
