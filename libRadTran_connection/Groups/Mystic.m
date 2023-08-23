classdef Mystic < handle
    properties (SetAccess = protected)
        lrt_config libRadtran
    end
    properties
        azimuth_old mc_azimuth_old
        backward_increment mc_backward_increment
        backward mc_backward
        backward_output mc_backward_output
        backward_writeback mc_backward_writeback
        basename mc_basename
        boxairmass mc_boxairmass
        escape mc_escape
        forward_output mc_forward_output
        max_scatters mc_maxscatters
        min_photons mc_minphotons
        min_scatters mc_minscatters
        nca mc_nca
        photons_file mc_photons_file
        photons mc_photons
        polarisation mc_polarisation
        rad_alpha mc_rad_alpha
        random_seed mc_randomseed
        sensor_direction mc_sensordirection
        spectral_is mc_spectral_is
        spherical mc_spherical
        surface_reflectalways mc_surface_reflectalways
        vroom mc_vroom
    end

    methods
        function m = Mystic(options)
            arguments
                options.lrtConfiguration libRadtran
            end
            if numel(fieldnames(options)) > 0
                m.lrt_config = options.lrtConfiguration;
            end
        end

        function m = AzimuthOld(m, state)
            arguments
                m Mystic
                state matlab.lang.OnOffSwitchState = "off"
            end
            m.azimuth_old = mc_azimuth_old(state);
        end

        function m = BackwardIncrement(m, X, Y)
            arguments
                m Mystic
                X {mustBeNumeric}
                Y {mustBeNumeric}
            end
            m.backward_increment = mc_backward_increment(X, Y);
        end

        function m = Backward(m, options)
            arguments
                m Mystic
                options.start_x
                options.start_y
                options.stop_x
                options.stop_y
            end
            args = {};
            for f = fieldnames(options)
                args = [args, f{1}, options.(f{1})];
            end
            m.backward = mc_backward(args{:});
        end

        function m = BackwardOutput(m, label, options)
            arguments
                m Mystic
            end
            arguments (Repeating)
                label {mustBeMember(label, {'edir', 'edn',  'eup', 'exp', ...
                    'exn', 'eyp', 'eyn', 'act'})}
            end
            arguments
                options.Absorption {mustBeMember(options.Absorption, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
                options.Emission {mustBeMember(options.Emission, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
                options.Heating {mustBeMember(options.Heating, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            optionals = [fieldnames(options), options];
            index = reshape(1:numel(options), [3, numel(d)/2])';
            args = [label, optionals(index(1:end))];
            m.backward_output = mc_backward_output(args{:});
        end

        function m = BackwardWriteback(m, state)
            arguments
                m Mystic
                state {mustBeNumericOrLogical}
            end
            m.backward_writeback = mc_backward_writeback(state);
        end

        function m = Basename(m, name)
            arguments
                m Mystic
                name {mustBeText}
            end
            m.basename = mc_basename(name);
        end

        function m = Boxairmass(m, state)
            arguments
                m Mystic
                state {mustBeNumericOrLogical}
            end
            m.boxairmass = mc_boxairmass(state);
        end

        function m = Escape(m, state)
            arguments
                m Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.escape = mc_escape(state);
        end

        function m = ForwardOutput(m, quantity, options)
            arguments
                m Mystic
                quantity {mustBeMember(quantity, { ...
                    'absorption', 'actinic', 'emission', 'heating'})}
                options.unit {mustBeMember(options.unit, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            if numel(options) > 0
                m.forward_output = mc_forward_output(quantity, "unit", options.unit);
                return
            end
            m.forward_output = mc_forward_output(quantity);
        end

        function m = Maxscatters(m, state)
            arguments
                m Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.max_scatters = mc_maxscatters(state);
        end

        function m = Minphotons(m, value)
            arguments
                m Mystic
                value {mustBeNumeric}
            end
            m.min_photons = mc_minphotons(value);
        end

        function m = Minscatters(m, state)
            arguments
                m Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.min_scatters = mc_minscatters(state);
        end

        function m = Nca(m, state)
            arguments
                m Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.nca = mc_nca(state);
        end

        function m = PhotonsFile(m, file)
            arguments
                m Mystic
                file {mustBeFile}
            end
            m.photons_file = mc_photons_file(file);
        end

        function m = Photons(m, value)
            arguments
                m Mystic
                value {mustBeNumeric}
            end
            m.photons = mc_photons(value);
        end

        function m = Polarisation(m, value)
            arguments
                m Mystic
                value {mustBeMember(value, { ...
                    '(0) (1,0,0,0) (default)', ...
                    '(1) (1,1,0,0)', ...
                    '(2) (1,0,1,0)', ...
                    '(3) (1,0,0,1)', ...
                    '(-1) (1,-1,0,0)', ...
                    '(-2) (1,0,-1,0)', ...
                    '(-3) (1,0,0,-1)', ...
                    '( 4) Random'})}
            end
            m.polarisation = mc_polarisation(value);
        end

        function m = RadAlpha(m, value)
            arguments
                m Mystic
                value {mustBeNumeric}
            end
            m.rad_alpha = mc_rad_alpha(value);
        end

        function m = Randomseed(m, value)
            arguments
                m Mystic
                value {mustBeNumeric}
            end
            m.random_seed = mc_randomseed(value);
        end

        function m = SensorDirection(m, x, y, z)
            arguments
                m Mystic
                x {mustBeNumeric}
                y {mustBeNumeric}
                z {mustBeNumeric}
            end
            m.sensor_direction = mc_sensordirection(x, y, z);
        end

        function m = SpectralIs(m, value)
            arguments
                m Mystic
                value {mustBeNumeric}
            end
            m.spectral_is = mc_spectral_is(value);
        end

        function m = Spherical(m, label)
            arguments
                m Mystic
                label {mustBeMember(label, {'1D'})}
            end
            m.spherical = mc_spherical(label);
        end

        function m = SurfaceReflectalways(m, state)
            arguments
                m Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.surface_reflectalways = mc_surface_reflectalways(state);
        end

        function m = Vroom(m, state)
            arguments
                m Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.vroom = mc_vroom(state);
        end

    end
end
