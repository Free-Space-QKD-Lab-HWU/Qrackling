classdef Aerosol
    properties (SetAccess = protected)
        angstrom aerosol_angstrom
        default aerosol_default
        haze aerosol_haze
        king_byrne aerosol_king_byrne
        profile_modtran aerosol_profile_modtran
        season aerosol_season
        set_tau_at_wvl aerosol_set_tau_at_wvl
        species_file aerosol_species_file
        species_library aerosol_species_library
        visibility aerosol_visibility
        vulcan aerosol_vulcan
    end

    methods
        function aer = Aerosol()
        end

        function aer = Angstrom(aer, alpha, beta)
            aer.angstrom = aerosol_angstrom(alpha, beta);
        end

        function aer = Default(aer, state)
            arguments
                aer Aerosol
                state matlab.lang.OnOffSwitchState = matlab.lang.OnOffSwitchState.off
            end

            aer.default = aerosol_default(state);
        end

        function aer = Haze(aer, model)
            arguments
                aer Aerosol
                model {mustBeMember(model, {'Rural', 'Maritime', 'Urban', 'Tropospheric'})}
            end
            aer.haze = aerosol_haze(model);
        end

        function aer = King_byrne(aer, alpha_0, alpha_1, alpha_2)
            arguments
                aer Aerosol
                alpha_0 {mustBeNumeric}
                alpha_1 {mustBeNumeric}
                alpha_2 {mustBeNumeric}
            end
            aer.king_byrne = aerosol_king_byrne(alpha_0, alpha_1, alpha_2);
        end

        function aer = Profile_modtran(aer, state)
            arguments
                aer Aerosol
                state matlab.lang.OnOffSwitchState = "off"
            end
            aer.profile_modtran = aerosol_profile_modtran(state);
        end

        function aer = Season(aer, season)
            arguments
                aer Aerosol
                season {mustBeMember(season, {'Spring_Summer', 'Fall_Winter'})}
            end
            aer.season = aerosol_season(season);
        end

        function aer = Set_tau_at_wvl(aer, lambda, tau)
            arguments
                aer Aerosol
                lambda {mustBeNumeric}
                tau {mustBeNumeric}
            end
            aer.set_tau_at_wvl = aerosol_set_tau_at_wvl(lambda, tau);
        end

        function aer = Species_file(aer, file)
            arguments
                aer Aerosol
                file {mustBeMember(file, { ...
                    'continental_clean',    'continental_average', ...
                    'continental_polluted', 'urban', ...
                    'maritime_clean',       'maritime_polluted', ...
                    'maritime_tropical',    'desert', ...
                    'antarctic'})}
            end
            aer.species_file = aerosol_species_file(file);
        end

        function aer = Species_library(aer, lib)
            arguments
                aer Aerosol
                lib {mustBeMember(lib, {...
                    'insoluble', 'water_soluble', ...
                    'soot', 'sea_salt_accumulation_mode', ...
                    'sea_salt_coarse_mode', 'mineral_nucleation_mode', ...
                    'mineral_accumulation_mode', 'mineral_coarse_mode', ...
                    'mineral_transported', 'sulfate_droplets'})}
            end
            aer.species_library = aerosol_species_library(lib);
        end

        function aer = Visibility(aer, vis)
            arguments
                aer Aerosol
                vis {mustBeNumeric}
            end
            aer.visibility = aerosol_visibility(vis);
        end

        function aer = Vulcan(aer, level)
            arguments
                aer Aerosol
                level {mustBeMember(level, { ...
                    'Background', 'Moderate_volcanic_aerosols', ...
                    'High_volcanic_aerosols', 'Extreme_volcanic_aerosols', ...
                    })}
            end
            aer.vulcan = aerosol_vulcan(level);
        end

    end
end


