classdef Solver
    properties (SetAccess = protected)
        solver rte_solver
        streams number_of_streams
        polradtran_opts polradtran
        quad_type polradtran_quad_type
        max_delta_tau polradtran_max_delta_tau
    end

    methods

        function s = Solver(label)
            arguments
                label {mustBeMember(label, { ...
                    'disort',     'twostr',      'fdisort1',             ...
                    'fdisort2',   'sdisort',     'spsdisort',            ...
                    'polradtran', 'ftwostr',     'rodents',              ...
                    'twomaxrnd',  'twomaxrnd3C', 'twomaxrnd3C_scale_cf', ...
                    'sslidar',    'sos',         'montecarlo',           ...
                    'mystic',     'tzs',         'sss'})}
            end
            s.solver = rte_solver(label);
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

    end

    methods (Access = private)
        function s = validFor(s, possible_solvers)
            arguments
                s Solver
                possible_solvers {mustBeText}
            end
            check = contains(possible_solvers, s.solver.Label);
            opts = strjoin(possible_solvers, ', ');
            assert(any(check), ...
                ['This options is only valid for: {', char(opts), '}']);
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
