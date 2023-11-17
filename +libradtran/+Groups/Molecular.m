classdef Molecular < handle
    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
    end

    properties (SetAccess = protected)
        surface_pressure libradtran.Parameters.pressure
        pressure_levels libradtran.Parameters.pressure_out
        photovoltaic_refractive_index libradtran.Parameters.refractive_index_pv
        lowtran_absorption libradtran.Parameters.ck_lowtran_absorption
        mixing_ratios libradtran.Parameters.mixing_ratio
        rayleigh_depolarisation libradtran.Parameters.rayleigh_depol
        radiosonde_file libradtran.Parameters.radiosonde
        radiosonde_levels libradtran.Parameters.radiosonde_levels_only
        molecule_files libradtran.Parameters.mol_file
        molecular_absorption libradtran.Parameters.mol_abs_param
        species_modifications libradtran.Parameters.mol_modify
        optical_depth_file libradtran.Parameters.mol_tau_file
        cross_section_model libradtran.Parameters.crs_model
        cross_section_file libradtran.Parameters.crs_file
    end

    methods
        function mol = Molecular(options)
            arguments
                options.lrtConfiguration
            end
            if numel(fieldnames(options)) > 0
                mol.lrt_config = options.lrtConfiguration;
            end
        end

        function mol = Pressure(mol, value)
            mol.surface_pressure = libradtran.Parameters.pressure(value);
        end

        function mol = OutputPressureLevels(mol, levels)
            mol.pressure_levels = libradtran.Parameters.pressure_out(levels);
        end

        function mol = RefractiveIndexPV(mol, n)
            mol.photovoltaic_refractive_index = libradtran.Parameters.refractive_index_pv(n);
        end

        function mol = RayleighDepolarisation(mol, value)
            mol.rayleigh_depolarisation = libradtran.Parameters.rayleigh_depol(value);
        end

        function mol = SwitchOffAbsorptionForSpecies(mol, species, state)
            arguments
                mol libradtran.Groups.Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, ...
                         {'O4', 'N2','CO','SO2','NH3','NO','HNO3'})}
                state matlab.lang.OnOffSwitchState
            end
            for i = 1:numel(species)
                ck_lowtran = libradtran.Parameters.ck_lowtran_absorption(species{i}, state{i});
                mol.lowtran_absorption = [mol.lowtran_absorption, ck_lowtran];
            end
        end

        function mol = MixingRatioForSpecies(mol, species, value)
            arguments
                mol libradtran.Groups.Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, {'O2', 'H2O', 'CO2', 'NO2', ...
                    'CH4', 'N2O', 'F11', 'F12', 'F22'})}
                value {mustBeNumeric}
            end
            for i = 1:numel(species)
                mix = libradtran.Parameters.ck_lowtran_absorption(species{i}, value{i});
                mol.mixing_ratios = [mol.mixing_ratios, mix];
            end
        end

        function mol = Radiosonde_file(mol, file)
            arguments
                mol libradtran.Groups.Molecular
                file {mustBeFile}
            end
            mol.radiosonde_file = libradtran.Parameters.radiosonde(file);
        end

        function mol = Radiosonde_levels(mol, state)
            arguments
                mol libradtran.Groups.Molecular
                state matlab.lang.OnOffSwitchState
            end
            mol.radiosonde_levels = libradtran.Parameters.radiosonde_levels_only(state);
        end

        function mol = Add_molecule_files(mol, species, file)
            arguments
                mol libradtran.Groups.Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, { ...
                    'O3',  'O2',  'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                file {mustBeFile}
            end

            for i = 1:numel(species)
                new_molecule = libradtran.Parameters.mol_file(species{i}, file{i});
                mol.molecule_files = [mol.molecule_files, new_molecule];
            end
        end

        function mol = MolecularAbsorption(mol, label)
            arguments
                mol libradtran.Groups.Molecular
                label {mustBeMember(label, { ...
                    'reptran fine',   'reptran medium', 'reptran coarse', ...
                    'crs',            'kato',           'kato2',          ...
                    'kato2andwandji', 'kato2_96',       'fu',             ...
                    'avhrr_kratz',    'lowtran',        'sbdart'})}
            end
            mol.molecular_absorption = libradtran.Parameters.mol_abs_param(label);
        end

        function mol = ModifySpecies(mol, species, column, unit)
            arguments
                mol libradtran.Groups.Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, {...
                    'O3',  'O2',  'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                column {mustBeNumeric}
                unit {mustBeMember(unit, {'DU', 'CM_2', 'MM'})}
            end
            for i = 1:numel(species)
                new_molecule = libradtran.Parameters.mol_modify(species{i}, column{i}, unit{i});
                mol.species_modifications = [mol.species_modifications, new_molecule];
            end
        end

        function mol = OpticalDepthFile(mol, kind, file)
            arguments
                mol libradtran.Groups.Molecular
                kind {mustBeMember(kind, {'sca', 'abs'})}
                file {mustBeFile}
            end
            mol.optical_depth_file = libradtran.Parameters.mol_tau_file(kind, file);
        end

        function mol = CrossSectionModel(mol, crs)
            arguments
                mol libradtran.Groups.Molecular
                crs {mustBeMember(crs, { ...
                    'rayleigh_Bodhaine', 'rayleigh_Bodhaine29', ...
                    'rayleigh_Nicolet', 'rayleigh_Penndorf', ...
                    'o3_Bass_and_Paur', 'o3_Molina', ...
                    'o3_Daumont', 'o3_Bogumil', ...
                    'o3_Serdyuchenko', 'no2_Burrows', ...
                    'no2_Bogumil', 'no2_Vandaele', ...
                    'o4_Greenblatt', 'o4_Thalman' ...
                    })}
            end
            elems = strsplit(crs, '_');
            mol.cross_section_model = libradtran.Parameters.crs_model(elems{2});
        end

        function mol = SpecifyCrossSection(mol, species, file)
            arguments
                mol libradtran.Groups.Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, { ...
                    'O3',   'O2', 'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                file {mustBeFile}
            end
            args = [species, file];
            index = reshape(1:numel(d), [2, numel(d)/2])';
            args = args(index(1:end));
            mol.cross_section_file = libradtran.Parameters.crs_file(args{:});
        end

    end
end

