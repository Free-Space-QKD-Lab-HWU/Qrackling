classdef libRadtran < handle
    properties
        Aerosol_Settings Aerosol
        Cloud_Settings Clouds
        General_Atmosphere_Settings GeneralAtmosphere
        Geometry_Settings Geometry
        Molecule_Settings Molecular
        Surface_Settings Surfaces
        Mystic_Settings Mystic
        Spectral_Settings Spectral
        Solver_Settings SolverAlgorithm
        Output_Settings Outputs
    end
    methods
        function lrt = libRadtran(options)
            arguments
                options.solver_type {mustBeMember(options.solver_type, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3C_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end
            if numel(fieldnames(options)) > 0
                lrt.Solver_Settings = Solver(solver_type, "lrtConfiguration", lrt);
            end
        end

        function aerosol = GetAerosolSettings(lrt)
            arguments (Output)
                aerosol Aerosol
            end
            if isempty(lrt.Aerosol_Settings)
                lrt.Aerosol_Settings = Aerosol(lrtConfiguration = lrt);
            end
            aerosol = lrt.Aerosol_Settings;
        end

        function clouds = GetCloudsSettings(lrt)
            arguments (Output)
                clouds Clouds
            end
            if isempty(lrt.Cloud_Settings)
                lrt.Cloud_Settings = Clouds(lrtConfiguration = lrt);
            end
            clouds = lrt.Cloud_Settings;
        end

        function general = GetGeneralAtmosphereSettings(lrt)
            arguments (Output)
                general GeneralAtmosphere
            end
            if isempty(lrt.General_Atmosphere_Settings)
                lrt.General_Atmosphere_Settings = GeneralAtmosphere("lrtConfiguration", lrt);
            end
            general = lrt.General_Atmosphere_Settings;
        end

        function geo = GetGeometrySettings(lrt)
            arguments (Output)
                geo Geometry
            end
            if isempty(lrt.Geometry_Settings)
                lrt.Geometry_Settings = Geometry("lrtConfiguration", lrt);
            end
            geo = lrt.Geometry_Settings;
        end

        function mol = GetMoleculeSettings(lrt)
            arguments (Input)
                lrt
            end
            arguments (Output)
                mol
            end
            if isempty(lrt.Molecule_Settings)
                lrt.Molecule_Settings = Molecular("lrtConfiguration", lrt);
            end
            mol = lrt.Molecule_Settings;
        end

        function s = GetSurfaceSettings(lrt)
            arguments (Input)
                lrt libRadtran
            end
            arguments (Output)
                s Surfaces
            end
            if isempty(lrt.Surface_Settings)
                lrt.Surface_Settings = Surfaces("lrtConfiguration", lrt);
            end
            s = lrt.Surface_Settings;
        end

        function mc = GetMysticsSettings(lrt)
            arguments (Input)
                lrt libRadtran
            end
            arguments (Output)
                mc Mystic
            end
            if isempty(lrt.Mystic_Settings)
                lrt.Mystic_Settings = Mystic("lrtConfiguration", lrt);
            end
            mc = lrt.Mystic_Settings;
        end

        function spectral = GetSpectralSettings(lrt)
            arguments (Input)
                lrt
            end
            arguments (Output)
                spectral
            end
            if isempty(lrt.Spectral_Settings)
                lrt.Spectral_Settings = Spectral("lrtConfiguration", lrt);
            end
            spectral = lrt.Spectral_Settings;
        end

        function solver = GetSolverSettings(lrt)
            arguments (Output)
                solver SolverAlgorithm
            end
            if isempty(lrt.Solver_Settings)
                lrt.Solver_Settings = SolverAlgorithm(lrtConfiguration = lrt);
            end
            solver = lrt.Solver_Settings;
        end

        function outputs = GetOutputSettings(lrt)
            arguments (Input)
                lrt libRadtran
            end
            arguments (Output)
                outputs Outputs
            end
            if isempty(lrt.Output_Settings)
                lrt.Output_Settings = Outputs("lrtConfiguration", lrt);
            end
            outputs = lrt.Output_Settings;
        end

        function lrt = ReplaceSettings(lrt, setting, value)
            arguments (Input)
                lrt libRadtran
            end
            arguments (Input, Repeating)
                setting {mustBeMember(setting, { ...
                    'Aerosol_Settings', 'Cloud_Settings',  ...
                    'General_Atmosphere_Settings', 'Molecule_Settings',  ...
                    'Mystic_Settings', 'Spectral_Settings',  ...
                    'Solver_Settings', 'Output_Settings'})}
                value
            end
            arguments (Output)
                lrt libRadtran
            end
            for i = 1:numel(setting)
                target_type = class(lrt.(setting{i}));
                if ~isa(value{i}, target_type)
                    msg = [ ...
                        'Argument at index [', num2str(i), '] must be of class {', ...
                        char(target_type), '}.', newline, char(9), ...
                        'Supplied an object of class {', class(value{i}), ...
                        '} for argument: {', char(target_type), '}.'];
                    error(string(msg));
                end
                lrt.(setting{i}) = value{i};
            end
        end

        function str = ConfigString(lrt)
            arguments
                lrt libRadtran
            end
            linebreak = newline;
            if ispc
                linebreak = [char(13), linebreak];
            end
            str = '';
            for p = properties(lrt)'
                group_name = p{1};
                if isempty(lrt.(group_name))
                    continue
                end
                str = [str, linebreak, linebreak, '# ', group_name];
                details = lrt.GroupString(group_name);
                str = [str, details];
            end
        end
    end

    methods (Access = private)

        function str = GroupString(lrt, group_name)
            arguments
                lrt libRadtran
                group_name {mustBeMember(group_name, { ...
                    'Aerosol_Settings', 'Cloud_Settings',  ...
                    'General_Atmosphere_Settings', 'Geometry_Settings',  ...
                    'Molecule_Settings', 'Surface_Settings', ...
                    'Mystic_Settings', 'Spectral_Settings', ...
                    'Solver_Settings', 'Output_Settings', ...
                    })}
            end
            group = lrt.(group_name);
            str = '';
            for p = properties(group)'
                param_name = p{1};
                if contains(param_name, 'lrt_config')
                    continue
                end
                param = group.(param_name);
                if isempty(param)
                    continue
                end

                for i = 1: numel(param)
                    current_param = param(i);
                    str = [str, lrt.ParameterString(current_param)];
                end
            end
        end

        function str = ParameterString(lrt, param)
            str = '';
            props = properties(param);
            types = cellfun( ...
                @(p) class(param.(p)), ...
                props, ...
                "UniformOutput", false);

            hasTag = contains(types, 'TagEnum');
            hasOnOff = contains(types, 'matlab.lang.OnOffSwitchState');

            if any(hasTag) && any(hasOnOff)
                idx = 1:numel(types);
                switch_prop = props(idx(hasOnOff));
                if param.(switch_prop{1}) == matlab.lang.OnOffSwitchState.on
                    tag_prop = props(idx(hasTag));
                    tag = param.(tag_prop{1});
                    switch tag
                        case TagEnum.IsCondition
                            str = [str, newline, class(param)];
                        case TagEnum.IsValue
                            str = [str, newline, class(param)];
                        otherwise
                            error('Unimplemented')
                    end
                    %str = [str, newline, class(param)];
                end
                return
            end

            str = [str, newline, class(param)];
            for p = properties(param)'
                variable = param.(p{1});
                if isempty(variable)
                    continue
                end

                type = class(variable);
                switch type
                    case 'string'
                        str = [str, ' ', char(variable)];
                    case 'cell'
                        if numel(variable) >= 1
                            % need to test here for repeated variables like mol_modify
                            switch class(variable{1})
                            case 'double'
                                str = [str, ' ', num2str(variable{1})];
                            case 'string'
                                str = [str, ' ', char(variable{1})];
                            otherwise
                                str = [str, ' ', strjoin(variable)];
                            end
                        else
                            str = [str, ' ', variable{1}];
                        end
                    case 'double'
                        str = [str, ' ', num2str(variable)];
                    case 'char'
                        str = [str, ' ', variable];
                    otherwise
                        disp(group_name)
                        disp(param_name)
                        disp(type)
                        disp(param)
                        error('Unimplemented')
                end
            end
        end

    end
end
