classdef Molecular
    properties (SetAccess = protected)
        surface_pressure pressure
        pressure_levels pressure_out
        photovoltaic_refractive_index refractive_index_pv
        lowtran_absorption ck_lowtran_absorption
        mixing_ratios mixing_ratio
        rayleigh_depolarisation rayleigh_depol
        radiosonde_file radiosonde
        radiosonde_levels radiosonde_levels_only
        molecule_files mol_file
        molecular_absorption mol_abs_param
        species_modifications mol_modify
        optical_depth_file mol_tau_file
        cross_section_model crs_model
        cross_section_file crs_file
    end

    methods
        function mol = Molecular()
        end

        function mol = Pressure(mol, value)
            mol.surface_pressure = pressure(value);
        end

        function mol = OutputPressureLevels(mol, levels)
            mol.pressure_levels = pressure_out(levels);
        end

        function mol = RefractiveIndexPV(mol, n)
            mol.photovoltaic_refractive_index = refractive_index_pv(n);
        end

        function mol = RayleighDepolarisation(mol, value)
            mol.rayleigh_depolarisation = rayleigh_depol(value);
        end

        function mol = SwitchOffAbsorptionForSpecies(mol, species, state)
            arguments
                mol Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, ...
                         {'O4', 'N2','CO','SO2','NH3','NO','HNO3'})}
                state matlab.lang.OnOffSwitchState
            end
            for i = 1:numel(species)
                ck_lowtran = ck_lowtran_absorption(species{i}, state{i});
                mol.lowtran_absorption = [mol.lowtran_absorption, ck_lowtran];
            end
        end

        function mol = MixingRatioForSpecies(mol, species, value)
            arguments
                mol Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, {'O2', 'H2O', 'CO2', 'NO2', ...
                    'CH4', 'N2O', 'F11', 'F12', 'F22'})}
                value {mustBeNumeric}
            end
            for i = 1:numel(species)
                mix = ck_lowtran_absorption(species{i}, value{i});
                mol.mixing_ratios = [mol.mixing_ratios, mix];
            end
        end

        function mol = Radiosonde_file(mol, file)
            arguments
                mol Molecular
                file {mustBeFile}
            end
            mol.radiosonde_file = radiosonde(file);
        end

        function mol = Radiosonde_levels(mol, state)
            arguments
                mol Molecular
                state matlab.lang.OnOffSwitchState
            end
            mol.radiosonde_levels = radiosonde_levels_only(state);
        end

        function mol = Add_molecule_files(mol, species, file)
            arguments
                mol Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, { ...
                    'O3',  'O2',  'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                file {mustBeFile}
            end

            for i = 1:numel(species)
                new_molecule = mol_file(species{i}, file{i});
                mol.molecule_files = [mol.molecule_files, new_molecule];
            end
        end

        function mol = MolecularAbsorption(mol, label)
            arguments
                mol Molecular
                label {mustBeMember(label, { ...
                    'reptran fine',   'reptran medium', 'reptran coarse', ...
                    'crs',            'kato',           'kato2',          ...
                    'kato2andwandji', 'kato2_96',       'fu',             ...
                    'avhrr_kratz',    'lowtran',        'sbdart'})}
            end
            mol.molecular_absorption = mol_abs_param(label);
        end

        function mol = ModifySpecies(mol, species, column, unit)
            arguments
                mol Molecular
            end
            arguments (Repeating)
                species {mustBeMember(species, {...
                    'O3',  'O2',  'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
                    'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'})}
                column {mustBeNumeric}
                unit {mustBeMember(unit, {'DU', 'CM_2', 'MM'})}
            end
            args = [species, column, unit];
            index = reshape(1:numel(d), [3, numel(d)/3])';
            args = args(index(1:end));
            mol.species_modifications = mol_modify(args{:});
        end

        function mol = OpticalDepthFile(mol, kind, file)
            arguments
                mol Molecular
                kind {mustBeMember(kind, {'sca', 'abs'})}
                file {mustBeFile}
            end
            mol.optical_depth_file = mol_tau_file(kind, file);
        end

        function mol = CrossSectionModel(mol, crs)
            arguments
                mol Molecular
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
            mol.cross_section_model = crs_model(elems{2});
        end

        function mol = SpecifyCrossSection(mol, species, file)
            arguments
                mol Molecular
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
            mol.cross_section_file = crs_file(args{:});
        end

    end
end

