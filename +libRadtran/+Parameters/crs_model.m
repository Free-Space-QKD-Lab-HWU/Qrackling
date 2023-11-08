classdef crs_model
    enumeration
        % rayleigh
        Bodhaine ('rayleigh', 'Bodhaine'),
        Bodhaine29 ('rayleigh', 'Bodhaine29'),
        Nicolet ('rayleigh', 'Nicolet'),
        Penndorf ('rayleigh', 'Penndorf'),

        % o3
        Bass_and_Paur ('o3', 'Bass_and_Paur'),
        Molina ('o3', 'Molina'),
        Daumont ('o3', 'Daumont'),
        Bogumil_o3 ('o3', 'Bogumil'),
        Serdyuchenko ('o3', 'Serdyuchenko'),

        % no2
        Burrows ('no2', 'Burrows'),
        Bogumil_no2 ('no2', 'Bogumil'),
        Vandaele ('no2', 'Vandaele'),

        % o4
        Greenblatt ('o4', 'Greenblatt'),
        Thalman ('o4', 'Thalman')
    end

    properties
        Species
        CRS
    end

    methods
        function model = crs_model(species, crs)
            model.Species = species;
            model.CRS = crs;

        end
    end

end
