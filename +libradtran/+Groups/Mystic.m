classdef Mystic < handle

    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
        azimuth_old libradtran.Parameters.mc_azimuth_old
        backward libradtran.Parameters.mc_backward
        backward_increment libradtran.Parameters.mc_backward_increment
        backward_output libradtran.Parameters.mc_backward_output
        backward_writeback libradtran.Parameters.mc_backward_writeback
        basename libradtran.Parameters.mc_basename
        boxairmass libradtran.Parameters.mc_boxairmass
        escape libradtran.Parameters.mc_escape
        forward_output libradtran.Parameters.mc_forward_output
        max_scatters libradtran.Parameters.mc_maxscatters
        min_photons libradtran.Parameters.mc_minphotons
        min_scatters libradtran.Parameters.mc_minscatters
        nca libradtran.Parameters.mc_nca
        photons_file libradtran.Parameters.mc_photons_file
        photons libradtran.Parameters.mc_photons
        polarisation libradtran.Parameters.mc_polarisation
        rad_alpha libradtran.Parameters.mc_rad_alpha
        random_seed libradtran.Parameters.mc_randomseed
        sensor_direction libradtran.Parameters.mc_sensordirection
        spectral_is libradtran.Parameters.mc_spectral_is
        spherical libradtran.Parameters.mc_spherical
        surface_reflectalways libradtran.Parameters.mc_surface_reflectalways
        vroom libradtran.Parameters.mc_vroom
    end

    methods
        function m = Mystic(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                m.lrt_config = options.lrtConfiguration;
            end
        end

        function m = AzimuthOld(m, state)
            arguments
                m libradtran.Groups.Mystic
                state matlab.lang.OnOffSwitchState = "off"
            end
            m.azimuth_old = libradtran.Parameters.mc_azimuth_old(state);
        end

        function m = BackwardIncrement(m, X, Y)
            arguments
                m libradtran.Groups.Mystic
                X {mustBeNumeric}
                Y {mustBeNumeric}
            end
            m.backward_increment = libradtran.Parameters.mc_backward_increment(X, Y);
        end

        function m = Backward(m, options)
            arguments
                m libradtran.Groups.Mystic
                options.start_x
                options.start_y
                options.stop_x
                options.stop_y
            end
            args = {};
            fields = fieldnames(options);
            if numel(fields) > 0
                for f = fields
                    args = [args, f{1}, options.(f{1})];
                end
            end
            m.backward = libradtran.Parameters.mc_backward(args{:});
        end

        function m = BackwardOutput(m, label, options)
            arguments
                m libradtran.Groups.Mystic
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
            args = {label};
            if numel(fieldnames(options)) > 0
                optionals = [fieldnames(options), options];
                index = reshape(1:numel(options), [3, numel(options)/3])';
                args = [args, optionals(index(1:end))];
            end
            m.backward_output = libradtran.Parameters.mc_backward_output(label{:});
        end

        function m = BackwardWriteback(m, state)
            arguments
                m libradtran.Groups.Mystic
                state {mustBeNumericOrLogical}
            end
            m.backward_writeback = libradtran.Parameters.mc_backward_writeback(state);
        end

        function m = Basename(m, name)
            arguments
                m libradtran.Groups.Mystic
                name {mustBeText}
            end
            m.basename = libradtran.Parameters.mc_basename(name);
        end

        function m = Boxairmass(m, state)
            arguments
                m libradtran.Groups.Mystic
                state {mustBeNumericOrLogical}
            end
            m.boxairmass = libradtran.Parameters.mc_boxairmass(state);
        end

        function m = Escape(m, state)
            arguments
                m libradtran.Groups.Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.escape = libradtran.Parameters.mc_escape(state);
        end

        function m = ForwardOutput(m, quantity, options)
            arguments
                m libradtran.Groups.Mystic
                quantity {mustBeMember(quantity, { ...
                    'absorption', 'actinic', 'emission', 'heating'})}
                options.unit {mustBeMember(options.unit, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            if numel(options) > 0
                m.forward_output = libradtran.Parameters.mc_forward_output(quantity, "unit", options.unit);
                return
            end
            m.forward_output = libradtran.Parameters.mc_forward_output(quantity);
        end

        function m = Maxscatters(m, state)
            arguments
                m libradtran.Groups.Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.max_scatters = libradtran.Parameters.mc_maxscatters(state);
        end

        function m = Minphotons(m, value)
            arguments
                m libradtran.Groups.Mystic
                value {mustBeNumeric}
            end
            m.min_photons = libradtran.Parameters.mc_minphotons(value);
        end

        function m = Minscatters(m, state)
            arguments
                m libradtran.Groups.Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.min_scatters = libradtran.Parameters.mc_minscatters(state);
        end

        function m = Nca(m, state)
            arguments
                m libradtran.Groups.Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.nca = libradtran.Parameters.mc_nca(state);
        end

        function m = PhotonsFile(m, file)
            arguments
                m libradtran.Groups.Mystic
                file {mustBeFile}
            end
            m.photons_file = libradtran.Parameters.mc_photons_file(file);
        end

        function m = Photons(m, value)
            arguments
                m libradtran.Groups.Mystic
                value {mustBeNumeric}
            end
            m.photons = libradtran.Parameters.mc_photons(value);
        end

        function m = Polarisation(m, value)
            arguments
                m libradtran.Groups.Mystic
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
            m.polarisation = libradtran.Parameters.mc_polarisation(value);
        end

        function m = RadAlpha(m, value)
            arguments
                m libradtran.Groups.Mystic
                value {mustBeNumeric}
            end
            m.rad_alpha = libradtran.Parameters.mc_rad_alpha(value);
        end

        function m = Randomseed(m, value)
            arguments
                m libradtran.Groups.Mystic
                value {mustBeNumeric}
            end
            m.random_seed = libradtran.Parameters.mc_randomseed(value);
        end

        function m = SensorDirection(m, x, y, z)
            arguments
                m libradtran.Groups.Mystic
                x {mustBeNumeric}
                y {mustBeNumeric}
                z {mustBeNumeric}
            end
            m.sensor_direction = libradtran.Parameters.mc_sensordirection(x, y, z);
        end

        function m = SpectralIs(m, value)
            arguments
                m libradtran.Groups.Mystic
                value {mustBeNumeric}
            end
            m.spectral_is = libradtran.Parameters.mc_spectral_is(value);
        end

        function m = Spherical(m, label)
            arguments
                m libradtran.Groups.Mystic
                label {mustBeMember(label, {'1D'})}
            end
            m.spherical = libradtran.Parameters.mc_spherical(label);
        end

        function m = SurfaceReflectalways(m, state)
            arguments
                m libradtran.Groups.Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.surface_reflectalways = libradtran.Parameters.mc_surface_reflectalways(state);
        end

        function m = Vroom(m, state)
            arguments
                m libradtran.Groups.Mystic
                state matlab.lang.OnOffSwitchState
            end
            m.vroom = libradtran.Parameters.mc_vroom(state);
        end

    end
end
