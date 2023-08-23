classdef libRadtran < handle
    properties
        Aerosol_Settings Aerosol
        Cloud_Settings Clouds
        General_Atmosphere_Settings GeneralAtmosphere
        Molecule_Settings Molecular
        Mystic_Settings Mystic
        Spectral_Settings Spectral
        Solver_Settings Solver
        Output_Settings Outputs
    end
    methods
        function lrt = libRadtran(solver_type)
            arguments
                solver_type {mustBeMember(solver_type, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3C_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end
            lrt.Solver_Settings = Solver(solver_type, "lrtConfiguration", lrt);
        end

        function setting = GetSettingsHandle(lrt, label, new, options)
            arguments
                lrt libRadtran
                label {mustBeMember(label, { ...
                    'Aersol_Settings', 'Cloud_Settings',  ...
                    'General_Atmosphere_Settings', 'Molecule_Settings',  ...
                    'Mystic_Settings', 'Spectral_Settings',  ...
                    'Solver_Settings'})}
                new {mustBeNumericOrLogical} = false
                options.NewSolverType {mustBeMember(options.NewSolverType, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3C_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end

            setting = lrt.(label);

            if true == new && false == isempty(setting)
                switch label
                    case 'Aerosol_Settings'
                        setting = Aerosol();
                    case 'Cloud_Settings'
                        setting = Clouds();
                    case 'General_Atmosphere_Settings'
                        setting = GeneralAtmosphere();
                    case 'Molecule_Settings'
                        setting = Molecular();
                    case 'Mystic_Settings'
                        setting = Mystic();
                    case 'Spectral_Settings'
                        setting = Spectral();
                    case 'Solver_Settings'
                        assert(~isempty(fieldnames(options)), 'No solver type supplied');
                        setting = Solver(options.NewSolverType, "lrtConfiguration", lrt);
                    case 'Output_Settings'
                        setting = Outputs();
                end
                lrt.(label) = setting;
            end
        end

    end
end

