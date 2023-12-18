classdef Aerosol < handle

    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
        angstrom libradtran.Parameters.aerosol_angstrom
        default libradtran.Parameters.aerosol_default
        haze libradtran.Parameters.aerosol_haze
        king_byrne libradtran.Parameters.aerosol_king_byrne
        profile_modtran libradtran.Parameters.aerosol_profile_modtran
        season libradtran.Parameters.aerosol_season
        set_tau_at_wvl libradtran.Parameters.aerosol_set_tau_at_wvl
        species_file libradtran.Parameters.aerosol_species_file
        species_library libradtran.Parameters.aerosol_species_library
        visibility libradtran.Parameters.aerosol_visibility
        vulcan libradtran.Parameters.aerosol_vulcan
    end

    methods
        function aer = Aerosol(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                aer.lrt_config = options.lrtConfiguration;
            end
        end

        function aer = Angstrom(aer, alpha, beta)
            aer.angstrom = libradtran.Parameters.aerosol_angstrom(alpha, beta);
        end

        function aer = Default(aer, state)
            arguments
                aer libradtran.Groups.Aerosol
                state matlab.lang.OnOffSwitchState = matlab.lang.OnOffSwitchState.off
            end

            aer.default = libradtran.Parameters.aerosol_default(state);
        end

        function aer = Haze(aer, model)
            arguments
                aer libradtran.Groups.Aerosol
                model {mustBeMember(model, {'Rural', 'Maritime', 'Urban', 'Tropospheric'})}
            end
            aer.haze = libradtran.Parameters.aerosol_haze(model);
        end

        function aer = King_byrne(aer, alpha_0, alpha_1, alpha_2)
            arguments
                aer libradtran.Groups.Aerosol
                alpha_0 {mustBeNumeric}
                alpha_1 {mustBeNumeric}
                alpha_2 {mustBeNumeric}
            end
            aer.king_byrne = libradtran.Parameters.aerosol_king_byrne(alpha_0, alpha_1, alpha_2);
        end

        function aer = Profile_modtran(aer, state)
            arguments
                aer libradtran.Groups.Aerosol
                state matlab.lang.OnOffSwitchState = "off"
            end
            aer.profile_modtran = libradtran.Parameters.aerosol_profile_modtran(state);
        end

        function aer = Season(aer, season)
            arguments
                aer libradtran.Groups.Aerosol
                season {mustBeMember(season, {'Spring_Summer', 'Fall_Winter'})}
            end
            aer.season = libradtran.Parameters.aerosol_season(season);
        end

        function aer = Set_tau_at_wvl(aer, lambda, tau)
            arguments
                aer libradtran.Groups.Aerosol
                lambda {mustBeNumeric}
                tau {mustBeNumeric}
            end
            aer.set_tau_at_wvl = libradtran.Parameters.aerosol_set_tau_at_wvl(lambda, tau);
        end

        function aer = Species_file(aer, file)
            arguments
                aer libradtran.Groups.Aerosol
                file {mustBeMember(file, { ...
                    'continental_clean',    'continental_average', ...
                    'continental_polluted', 'urban', ...
                    'maritime_clean',       'maritime_polluted', ...
                    'maritime_tropical',    'desert', ...
                    'antarctic'})}
            end
            aer.species_file = libradtran.Parameters.aerosol_species_file(file);
        end

        function aer = Species_library(aer, lib)
            arguments
                aer libradtran.Groups.Aerosol
                lib {mustBeMember(lib, {...
                    'insoluble', 'water_soluble', ...
                    'soot', 'sea_salt_accumulation_mode', ...
                    'sea_salt_coarse_mode', 'mineral_nucleation_mode', ...
                    'mineral_accumulation_mode', 'mineral_coarse_mode', ...
                    'mineral_transported', 'sulfate_droplets'})}
            end
            aer.species_library = libradtran.Parameters.aerosol_species_library(lib);
        end

        function aer = Visibility(aer, vis)
            arguments
                aer libradtran.Groups.Aerosol
                vis {mustBeNumeric}
            end
            aer.visibility = libradtran.Parameters.aerosol_visibility(vis);
        end

        function aer = Vulcan(aer, level)
            arguments
                aer libradtran.Groups.Aerosol
                level {mustBeMember(level, { ...
                    'Background', 'Moderate_volcanic_aerosols', ...
                    'High_volcanic_aerosols', 'Extreme_volcanic_aerosols', ...
                    })}
            end
            aer.vulcan = libradtran.Parameters.aerosol_vulcan(level);
        end

    end
end


