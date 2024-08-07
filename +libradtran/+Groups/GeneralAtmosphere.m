classdef GeneralAtmosphere < handle

    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
        atmosphere libradtran.Parameters.atmosphere_file
        disable_absorption libradtran.Parameters.no_absorption
        disable_scattering libradtran.Parameters.no_scattering
        interpret_profile_as_levels libradtran.Parameters.interpret_as_level
        z_interpolation libradtran.Parameters.z_interpolate
        zout_interpolation libradtran.Parameters.zout_interpolate
        z_grid libradtran.Parameters.atm_z_grid
        atmosphere_reversal libradtran.Parameters.reverse_atmosphere
    end

    methods
        function g = GeneralAtmosphere(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                g.lrt_config = options.lrtConfiguration;
            end
        end

        function g = Atmosphere(g, options)
            arguments
                g libradtran.Groups.GeneralAtmosphere
                options.Default {mustBeMember(options.Default, { ...
                    'tropics', 'midlatitude_summer', 'midlatitude_winter', ...
                    'subarctic_summer', 'subarctic_winter', 'US-standard' ...
                })}
                options.File {mustBeFile}
            end
            fields = fieldnames(options);
            if contains(fields, "Default")
                g.atmosphere = libradtran.Parameters.atmosphere_file("Default", options.Default);
            end
            if contains(fields, "File")
                g.atmosphere = libradtran.Parameters.atmosphere_file("File", options.File);
            end
        end

        function g = DisableAbsorptionFor(g, label)
            arguments (Repeating)
                g libradtran.Groups.GeneralAtmosphere
                label {mustBeMember(label, {'mol', 'aer', 'wc', 'ic', 'profile'})}
            end
            g.disable_absorption = libradtran.Parameters.no_absorption(label);
        end

        function g = DisableScattering(g, label)
            arguments (Repeating)
                g libradtran.Groups.GeneralAtmosphere
                label {mustBeMember(label, {'mol', 'aer', 'wc', 'ic', 'profile'})}
            end
            g.disable_scattering = libradtran.Parameters.no_scattering(label);
        end

        function g = InterpretProfileAsLevels(g, label)
            arguments (Repeating)
                g libradtran.Groups.GeneralAtmosphere
                label {mustBeMember(label, {'wc', 'ic'})}
            end
            g.interpret_profile_as_levels = libradtran.Parameters.interpret_as_level(label);
        end

        function g = InterpolateZOut(g, state)
            arguments
                g libradtran.Groups.GeneralAtmosphere
                state matlab.lang.OnOffSwitchState
            end
            g.zout_interpolation = libradtran.Parameters.zout_interpolate(state);
        end

        function g = InterpolateZ(g, state)
            arguments
                g libradtran.Groups.GeneralAtmosphere
                state matlab.lang.OnOffSwitchState
            end
            g.z_interpolation = libradtran.Parameters.z_interpolate(state);
        end

        function g = AtmosphericZGrid(g, altitudes)
            g.z_grid = libradtran.Parameters.atm_z_grid(altitudes);
        end

        function g = ReverseAtmosphere(g, state)
            arguments
                g libradtran.Groups.GeneralAtmosphere
                state matlab.lang.OnOffSwitchState
            end
            g.atmosphere_reversal = libradtran.Parameters.reverse_atmosphere(state);
        end

    end
end
