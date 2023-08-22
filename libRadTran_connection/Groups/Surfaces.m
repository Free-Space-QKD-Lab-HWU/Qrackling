classdef Surfaces
    properties (SetAccess = protected)
        altitudes altitude
        surface_albedo albedo
        surface_albedo_file albedo_file
        surface_albedo_library albedo_library
        ambrals bdrf_ambrals
        ambrals_file bdrf_ambrals_file
        ambrals_hotspot_correction bdrf_ambrals_hotspot
        cox_and_munk bdrf_cam
        cox_and_munk_solar_wind_direction bdrf_cam_solar_wind
        hapke bdrf_hapke
        hapke_file bdrf_hapke_file
        rpv bdrf_rpv
        rpv_file bdrf_rpv_file
        rpv_library bdrf_rpv_library
        bpdf bpdf_tsang_u10
    end
    methods
        function s = Surfaces()
        end

        function s = Altitude(s, A, options)
            arguments
                s Surfaces
                A {mustBeNumeric}
                options.resolution {mustBeNumeric} = NaN
            end
            if ~isnan(options.resolution)
                s.altitudes = altitude(A, "resolution", options.resolution);
                return
            end
            s.altitudes = altitude(A);
        end

        function s = Albedo(s, a)
            arguments
                s Surfaces
                a {mustBeNumeric, mustBeNonzero, mustBeLessThanOrEqual(a, 1)}
            end
            s.surface_albedo = albedo(a);
        end

        function s = AlbedoFile(s, file)
            arguments
                s Surfaces
                file {mustBeFile}
            end
            s.surface_albedo_file = albedo_file(file);
        end

        function s = AlbedoLibrary(s, lib)
            arguments
                s Surfaces
                lib {mustBeMember(lib, {...
                    'evergreen_needle_forest', 'evergreen_broad_forest', ...
                    'deciduous_needle_forest', 'deciduous_broad_forest', ...
                    'mixed_forest', 'closed_shrub', ...
                    'open_shrubs', 'woody_savanna', ...
                    'savanna', 'grassland', ...
                    'wetland', 'cropland', ...
                    'urban', 'crop_mosaic', ...
                    'antarctic_snow', 'desert', ...
                    'ocean_water', 'tundra', ...
                    'fresh_snow'})}
            end
            s.surface_albedo_library = albedo_library(lib);
        end

        function s = Ambrals(s, var, val)
            arguments
                s Surfaces
                var {mustBeMember(var, {'iso', 'vol', 'geo'})}
                val {mustBeNumeric}
            end
            s.ambrals = bdrf_ambrals(var, val);
        end

        function s = AmbralsFile(s, file)
            arguments
                s Surfaces
                file {mustBeFile}
            end
            s.ambrals_file = bdrf_ambrals_file(file);
        end

        function s = AmbralsHostspotCorrection(s, state)
            arguments
                s Surfaces
                state {mustBeNumericOrLogical}
            end
            s.ambrals_hotspot_correction = bdrf_ambrals_file(state);
        end

        function s = CoxAndMunk(s, var, val)
            arguments
                s Surfaces
                var {mustBeMember(var, {'pcl', 'sal', 'u10', 'uphi'})}
                val {mustBeNumeric}
            end
            s.cox_and_munk = bdrf_cam(var, val);
        end

        function s = CoxAndMunkSolarWindDirection(s, state)
            arguments
                s Surfaces
                state matlab.lang.OnOffSwitchState
            end
            s.cox_and_munk_solar_wind_direction = bdrf_cam_solar_wind(state);
        end

        function s = Hapke(s, var, val)
            arguments
                s Surfaces
                var {mustBeMember(var, {'w', 'B0', 'h'}})
                val {mustBeNumeric}
            end
            s.hapke = bdrf_hapke(var, val);
        end

        function s = HapkeFile(s, file)
            arguments
                s Surfaces
                file {mustBeFile}
            end
            s.hapke_file = bdrf_hapke_file(file);
        end

        function s = RPV(s, var, val)
            arguments
                s Surfaces
                var {mustBeMember(var, ...
                    {'k', 'rho0', 'theta', 'sigma', 't1', 't2', 'scale'})}
                val {mustBeNumeric}
            end
            s.rpv = bdrf_rpv(var, val);
        end

        function s = RPVFile(s, file)
            arguments
                s Surfaces
                file {mustBeFile}
            end
            s.rpv_file = bdrf_rpv_file(file);
        end

        function s = RPVLibrary(s, options)
            arguments
                s Surfaces
                options.Library_Path {mustBeFolder}
                options.Default = false
            end
            args = [fieldnames(options), options];
            index = reshape(1:numel(options), [2, numel(d)/2])';
            args = args(index(1:end));
            s.rpv_library = bdrf_rpv_library(args{:});
        end

        function s = BPDF(s, value)
            arguments
                s Surfaces
                value
            end
            s.bpdf = bpdf_tsang_u10(value);
        end

    end
end



