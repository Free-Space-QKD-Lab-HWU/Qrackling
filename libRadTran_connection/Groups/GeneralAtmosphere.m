classdef GeneralAtmosphere
    properties (SetAccess = protected)
        disable_absorption no_absorption
        disable_scattering no_scattering
        interpret_profile_as_levels interpret_as_level
        z_interpolation z_interpolate
        zout_interpolation zout_interpolate
        z_grid atm_z_grid
        atmosphere_reversal reverse_atmosphere
    end

    methods
        function g = GeneralAtmosphere()
        end


        function g = DisableAbsorptionFor(g, label)
            arguments (Repeating)
                g GeneralAtmosphere
                label {mustBeMember(label, {'mol', 'aer', 'wc', 'ic', 'profile'})}
            end
            g.disable_absorption = no_absorption(label);
        end

        function g = DisableScattering(g, label)
            arguments (Repeating)
                g GeneralAtmosphere
                label {mustBeMember(label, {'mol', 'aer', 'wc', 'ic', 'profile'})}
            end
            g.disable_scattering = no_scattering(label);
        end

        function g = InterpretProfileAsLevels(g, label)
            arguments (Repeating)
                g GeneralAtmosphere
                label {mustBeMember(label, {'wc', 'ic'})}
            end
            g.interpret_profile_as_levels = interpret_as_level(label);
        end

        function g = InterpolateZOut(g, state)
            arguments
                g GeneralAtmosphere
                state matlab.lang.OnOffSwitchState
            end
            g.zout_interpolation = zout_interpolate(state);
        end

        function g = InterpolateZ(g, state)
            arguments
                g GeneralAtmosphere
                state matlab.lang.OnOffSwitchState
            end
            g.z_interpolation = z_interpolate(state);
        end

        function g = AtmosphericZGrid(g, altitudes)
            g.z_grid = atm_z_grid(altitudes);
        end

        function g = ReverseAtmosphere(g, state)
            arguments
                g GeneralAtmosphere
                state matlab.lang.OnOffSwitchState
            end
            g.atmosphere_reversal = reverse_atmosphere(state);
        end

    end
end
