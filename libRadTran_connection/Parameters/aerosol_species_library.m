classdef aerosol_species_library
    enumeration
        insoluble                  ('INSO'),
        water_soluble              ('WASO'),
        soot                       ('SOOT'),
        sea_salt_accumulation_mode ('SSAM'),
        sea_salt_coarse_mode       ('SSCM'),
        mineral_nucleation_mode    ('MINM'),
        mineral_accumulation_mode  ('MIAM'),
        mineral_coarse_mode        ('MICM'),
        mineral_transported        ('MITR'),
        sulfate_droplets           ('SUSO')
    end

    properties
        Label
    end

    methods
        function species_library = aerosol_species_library(library)
            species_library.Label = library;
        end
    end
end
