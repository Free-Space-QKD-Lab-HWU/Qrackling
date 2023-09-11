classdef albedo_library
    enumeration
        evergreen_needle_forest ('evergreen_needle_forest'),
        evergreen_broad_forest  ('evergreen_broad_forest'),
        deciduous_needle_forest ('deciduous_needle_forest'),
        deciduous_broad_forest  ('deciduous_broad_forest'),
        mixed_forest            ('mixed_forest'),
        closed_shrub            ('closed_shrub'),
        open_shrubs             ('open_shrubs'),
        woody_savanna           ('woody_savanna'),
        savanna                 ('savanna'),
        grassland               ('grassland'),
        wetland                 ('wetland'),
        cropland                ('cropland'),
        urban                   ('urban'),
        crop_mosaic             ('crop_mosaic'),
        antarctic_snow          ('antarctic_snow'),
        desert                  ('desert'),
        ocean_water             ('ocean_water'),
        tundra                  ('tundra' ),
        fresh_snow              ('fresh_snow')
    end

    properties
       Label
    end

    methods
        function library = albedo_library(lib)
            library.Label = lib;
        end
    end
end
