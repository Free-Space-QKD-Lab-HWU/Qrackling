classdef SolverAlgorithm < handle

    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
        pseudospherical_geometry libradtran.Parameters.pseudospherical
        disort_intensity_correction libradtran.Parameters.disort_intcor
        top_of_atmosphere_isotropic_illumination libradtran.Parameters.isotropic_source_toa
        raman_scattering libradtran.Parameters.raman
        solver libradtran.Parameters.rte_solver
        streams libradtran.Parameters.number_of_streams
        polradtran_opts libradtran.Parameters.polradtran
        quad_type libradtran.Parameters.polradtran_quad_type
        max_delta_tau libradtran.Parameters.polradtran_max_delta_tau
        s_disort libradtran.Parameters.sdisort
        % sos has parameter sos_nscat, but its undocumented
        delta_m_scaling libradtran.Parameters.deltam
        single_scattering_lidar_parameters libradtran.Parameters.sslidar
        single_scattering_lidar_range libradtran.Parameters.sslidar_nranges
        single_scattering_lidar_polarisation libradtran.Parameters.sslidar_polarisation
        top_height_of_blackbody_clouds libradtran.Parameters.tzs_cloud_top_height
        cloud_fraction_split_scale libradtran.Parameters.twomaxrnd3c_scale_cf
    end

    methods

        function s = SolverAlgorithm(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                s.lrt_config = options.lrtConfiguration;
            end
        end

        function s = Solver(s, label)
            arguments
                s libradtran.Groups.SolverAlgorithm
                label {mustBeMember(label, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3c_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end
            s.solver = libradtran.Parameters.rte_solver(label);
        end

        function rte = Pseudospherical(rte, state)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("disort", "twostr");
            rte.pseudospherical_geometry = libradtran.Parameters.pseudospherical(state);
        end

        function rte = DisortIntensityCorrection(rte, val)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                val {mustBeMember(val, {'phase', 'moments', 'off'})};
            end
            rte = rte.validFor('disort');
            rte.disort_intensity_correction = libradtran.Parameters.disort_intcor(val);
        end

        function rte = TopOfAtmosphereIsotropicIllumination(rte, state)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("disort", "twostr");
            rte.top_of_atmosphere_isotropic_illumination = libradtran.Parameters.isotropic_source_toa(state);
        end

        function rte = RamanScattering(rte, state, options)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                state matlab.lang.OnOffSwitchState
                options.label {mustBeMember(options.label, {'original'})}
            end
            rte = rte.validFor("disort");
            if numel(fieldnames(options)) > 0
                rte.raman_scattering = libradtran.Parameters.raman(state, "label", options.label);
                return
            end
            rte.raman_scattering = libradtran.Parameters.raman(state);
        end

        function rte = Streams(rte, n)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                n {mustBeInteger}
            end
            rte = rte.validFor(["disort", "libradtran.Parameters.polradtran"]);
            rte.streams = libradtran.Parameters.number_of_streams(n);
        end

        function rte = libradtran.Parameters.polradtran(rte, label, value, options)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                label {mustBeMember(label, {'Gaussian', 'Double Gaussian', ...
                    'Lobatto', 'Extra-angle(s)'})}
                value {mustBeNumeric}
                options.aziorder {mustBeNumeric}
                options.nstokes {mustBeNumeric, mustBeInteger, ...
                    mustBeInRange(options.nstokes, 1, 3)}
                options.src_code {mustBeNumeric, mustBeInteger, ...
                    mustBeInRange(options.src_code, 0, 3)}
            end
            rte = rte.validFor("libradtran.Parameters.polradtran");
            args = libradtran.Groups.SolverAlgorithm.expandArguments(options);
            rte.polradtran_opts = libradtran.Parameters.polradtran(args{:});
            rte.quad_type = libradtran.Parameters.polradtran_quad_type(label);
            rte.max_delta_tau = libradtran.Parameters.polradtran_max_delta_tau(value);
        end

        function rte = SDisort(rte, label)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                label {mustBeMember(label, { ...
                    'single scattering', ...
                    'multiple scattering', ...
                    'no refraction', ...
                    'fast refraction (harsh)', ...
                    'slow refraction (accurate)'})}
            end
            rte = rte.validFor("sdisort");
            rte.s_disort = libradtran.Parameters.sdisort(label);
        end

        function rte = deltamScaling(rte, state)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("disort", "twostr");
            rte.delta_m_scaling = libradtran.Parameters.deltam(state);
        end

        function rte = SingleScatterinLidar(rte, variable, value, range, state)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                variable {mustBeMember(variable, {'area', 'E0', 'eff', ...
                    'position', 'range'})}
                value {mustBeNumeric}
                range {mustBeNumeric}
                state matlab.lang.OnOffSwitchState
            end
            rte = rte.validFor("sslidar");
            rte.single_scattering_lidar_parameters = libradtran.Parameters.sslidar(variable, value);
            rte.single_scattering_lidar_range = libradtran.Parameters.sslidar_nranges(range);
            rte.single_scattering_lidar_polarisation = libradtran.Parameters.sslidar_polarisation(state);
        end

        function rte = HeightOfBlackBodyClouds(rte, value)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                value {mustBeNumeric}
            end
            rte = rte.validFor('tzs');
            rte.top_height_of_blackbody_clouds = libradtran.Parameters.tzs_cloud_top_height(value);
        end

        function rte = ScaleFactorForCloudFractionSplit(rte, value)
            arguments
                rte libradtran.Groups.SolverAlgorithm
                value {mustBeNumeric}
            end
            rte = rte.validFor("twomaxrnd3C");
            rte.cloud_fraction_split_scale = libradtran.Parameters.twomaxrnd3c_scale_cf(value);
        end
    end

    methods (Access = private)
        function s = validFor(s, possible_solvers)
            arguments
                s libradtran.Groups.SolverAlgorithm
            end
            arguments (Repeating)
                possible_solvers {mustBeMember(possible_solvers, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3c_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end

            check = false;
            for opt = possible_solvers
            check = check | contains(opt{1}, s.solver.Label);
            end
            err_string = "This options is only valid for: {"+ strjoin(([possible_solvers{:}]')')+ "}";
            assert(check, err_string);
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
