classdef Solver < handle
    properties (SetAccess = protected)
        lrt_config libRadtran
    end

    properties (SetAccess = protected)
        pseudospherical_geometry pseudospherical
        disort_intensity_correction disort_intcor
        top_of_atmosphere_isotropic_illumination isotropic_source_toa
        raman_scattering raman
        solver rte_solver
        streams number_of_streams
        polradtran_opts polradtran
        quad_type polradtran_quad_type
        max_delta_tau polradtran_max_delta_tau
        s_disort sdisort
        % sos has parameter sos_nscat, but its undocumented
        delta_m_scaling deltam
        single_scattering_lidar_parameters sslidar
        single_scattering_lidar_range sslidar_nranges
        single_scattering_lidar_polarisation sslidar_polarisation
        top_height_of_blackbody_clouds tzs_cloud_top_height
        cloud_fraction_split_scale twomaxrnd3c_scale_cf
    end

    methods

        function s = Solver(label, options)
            arguments
                label {mustBeMember(label, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3C_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
                options.lrtConfiguration libRadtran
            end
            s.solver = rte_solver(label);
            if numel(fieldnames(options)) > 0
                s.lrt_config = options.lrtConfiguration;
            end
        end

        function rte = Pseudospherical(rte, state)
            arguments
                rte Solver
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("disort", "twostr");
            rte.pseudospherical_geometry = pseudospherical(state);
        end

        function rte = DisortIntensityCorrection(rte, val)
            arguments
                rte Solver
                val {mustBeMember(val, {'phase', 'moments', 'off'})};
            end
            rte = rte.validFor('disort');
            rte.disort_intensity_correction = disort_intcor(val);
        end

        function rte = TopOfAtmosphereIsotropicIllumination(rte, state)
            arguments
                rte Solver
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("disort", "twostr");
            rte.top_of_atmosphere_isotropic_illumination = isotropic_source_toa(state);
        end

        function rte = RamanScattering(rte, state, options)
            arguments
                rte Solver
                state matlab.lang.OnOffSwitchState
                options.label {mustBeMember(options.label, {'original'})}
            end
            rte = rte.validFor("disort");
            if numel(fieldnames(options)) > 0
                rte.raman_scattering = raman(state, "label", options.label);
                return
            end
            rte.raman_scattering = raman(state);
        end

        function rte = Streams(rte, n)
            arguments
                rte Solver
                n {mustBeInteger}
            end
            rte = rte.validFor(["disort", "polradtran"]);
            rte.streams = number_of_streams(n);
        end

        function rte = Polradtran(rte, label, value, options)
            arguments
                rte Solver
                label {mustBeMember(label, {'Gaussian', 'Double Gaussian', ...
                    'Lobatto', 'Extra-angle(s)'})}
                value {mustBeNumeric}
                options.aziorder {mustBeNumeric}
                options.nstokes {mustBeNumeric, mustBeInteger, ...
                    mustBeInRange(options.nstokes, 1, 3)}
                options.src_code {mustBeNumeric, mustBeInteger, ...
                    mustBeInRange(options.src_code, 0, 3)}
            end
            rte = rte.validFor("polradtran");
            args = Solver.expandArguments(options);
            rte.polradtran_opts = polradtran(args{:});
            rte.quad_type = polradtran_quad_type(label);
            rte.max_delta_tau = polradtran_max_delta_tau(value);
        end

        function rte = SDisort(rte, label)
            arguments
                rte Solver
                label {mustBeMember(label, { ...
                    'single scattering', ...
                    'multiple scattering', ...
                    'no refraction', ...
                    'fast refraction (harsh)', ...
                    'slow refraction (accurate)'})}
            end
            rte = rte.validFor("sdisort");
            rte.s_disort = sdisort(label);
        end

        function rte = DeltaMScaling(rte, state)
            arguments
                rte Solver
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("disort", "twostr");
            rte.delta_m_scaling = deltam(state);
        end

        function rte = SingleScatterinLidar(rte, variable, value, range, state)
            arguments
                rte Solver
                variable {mustBeMember(variable, {'area', 'E0', 'eff', ...
                    'position', 'range'})}
                value {mustBeNumeric}
                range {mustBeNumeric}
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("sslidar");
            rte.single_scattering_lidar_parameters = sslidar(variable, value);
            rte.single_scattering_lidar_range = sslidar_nranges(range);
            rte.single_scattering_lidar_polarisation = sslidar_polarisation(state);
        end

        function rte = HeightOfBlackBodyClouds(rte, value)
            arguments
                rte Solver
                value {mustBeNumeric}
            end
            rte = rte.validFor('tzs');
            rte.top_height_of_blackbody_clouds = tzs_cloud_top_height(value);
        end

        function rte = ScaleFactorForCloudFractionSplit(rte, value)
            arguments
                rte Solver
                value {mustBeNumeric}
            end
            rte = rte.validFor("twomaxrnd3C")
            rte.cloud_fraction_split_scale = twomaxrnd3c_scale_cf(value);
        end
    end

    methods (Access = private)
        function s = validFor(s, possible_solvers)
            arguments
                s Solver
            end
            arguments (Repeating)
                possible_solvers {mustBeMember(possible_solvers, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3C_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end
            opts = split(possible_solvers{1}, " ");
            check = contains(opts, s.solver.Label);
            err_string = strjoin(['This options is only valid for: {', opts, '}']);
            assert(any(check), err_string);
        end

    end

    methods (Static, Hidden = true)
        function args = expandArguments(arg_struct)
            arg_names = fieldnames(arg_struct)';
            arg_vals = struct2cell(arg_struct)';
            args = [arg_names, arg_vals];
            index = reshape(1:6, [], 2)';
            args = args(index(1:end));
        end

    end

end
