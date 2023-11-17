classdef Surfaces < handle
    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
        altitudes libradtran.Parameters.altitude
        surface_albedo libradtran.Parameters.albedo
        surface_albedo_file libradtran.Parameters.albedo_file
        surface_albedo_library libradtran.Parameters.albedo_library
        ambrals libradtran.Parameters.bdrf_ambrals
        ambrals_file libradtran.Parameters.bdrf_ambrals_file
        ambrals_hotspot_correction libradtran.Parameters.bdrf_ambrals_hotspot
        cox_and_munk libradtran.Parameters.bdrf_cam
        cox_and_munk_solar_wind_direction libradtran.Parameters.bdrf_cam_solar_wind
        hapke libradtran.Parameters.bdrf_hapke
        hapke_file libradtran.Parameters.bdrf_hapke_file
        rpv libradtran.Parameters.bdrf_rpv
        rpv_file libradtran.Parameters.bdrf_rpv_file
        rpv_library libradtran.Parameters.bdrf_rpv_library
        bpdf libradtran.Parameters.bpdf_tsang_u10
    end
    methods
        function s = Surfaces(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                s.lrt_config = options.lrtConfiguration;
            end
        end

        function s = Altitude(s, A, options)
            arguments
                s libradtran.Groups.Surfaces
                A {mustBeNumeric}
                options.resolution {mustBeNumeric} = NaN
            end
            if ~isnan(options.resolution)
                s.altitudes = altitude(A, "resolution", options.resolution);
                return
            end
            s.altitudes = libradtran.Parameters.altitude(A);
        end

        function s = SurfaceAlbedo(s, a)
            arguments
                s libradtran.Groups.Surfaces
                a {mustBeNumeric, mustBeNonzero, mustBeLessThanOrEqual(a, 1)}
            end
            s.surface_albedo = libradtran.Parameters.albedo(a);
        end

        function s = AlbedoFile(s, file)
            arguments
                s libradtran.Groups.Surfaces
                file {mustBeFile}
            end
            s.surface_albedo_file = libradtran.Parameters.albedo_file(file);
        end

        function s = AlbedoLibrary(s, lib)
            arguments
                s libradtran.Groups.Surfaces
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
            s.surface_albedo_library = libradtran.Parameters.albedo_library(lib);
        end

        function s = Ambrals(s, var, val)
            arguments
                s libradtran.Groups.Surfaces
                var {mustBeMember(var, {'iso', 'vol', 'geo'})}
                val {mustBeNumeric}
            end
            s.ambrals = libradtran.Parameters.bdrf_ambrals(var, val);
        end

        function s = AmbralsFile(s, file)
            arguments
                s libradtran.Groups.Surfaces
                file {mustBeFile}
            end
            s.ambrals_file = libradtran.Parameters.bdrf_ambrals_file(file);
        end

        function s = AmbralsHostspotCorrection(s, state)
            arguments
                s libradtran.Groups.Surfaces
                state {mustBeNumericOrLogical}
            end
            s.ambrals_hotspot_correction = libradtran.Parameters.bdrf_ambrals_file(state);
        end

        function s = CoxAndMunk(s, var, val)
            arguments
                s libradtran.Groups.Surfaces
                var {mustBeMember(var, {'pcl', 'sal', 'u10', 'uphi'})}
                val {mustBeNumeric}
            end
            s.cox_and_munk = libradtran.Parameters.bdrf_cam(var, val);
        end

        function s = CoxAndMunkSolarWindDirection(s, state)
            arguments
                s libradtran.Groups.Surfaces
                state matlab.lang.OnOffSwitchState
            end
            s.cox_and_munk_solar_wind_direction = libradtran.Parameters.bdrf_cam_solar_wind(state);
        end

        function s = Hapke(s, var, val)
            arguments
                s libradtran.Groups.Surfaces
                var {mustBeMember(var, {'w', 'B0', 'h'})}
                val {mustBeNumeric}
            end
            s.hapke = libradtran.Parameters.bdrf_hapke(var, val);
        end

        function s = HapkeFile(s, file)
            arguments
                s libradtran.Groups.Surfaces
                file {mustBeFile}
            end
            s.hapke_file = libradtran.Parameters.bdrf_hapke_file(file);
        end

        function s = RPV(s, var, val)
            arguments
                s libradtran.Groups.Surfaces
                var {mustBeMember(var, ...
                    {'k', 'rho0', 'theta', 'sigma', 't1', 't2', 'scale'})}
                val {mustBeNumeric}
            end
            s.rpv = libradtran.Parameters.bdrf_rpv(var, val);
        end

        function s = RPVFile(s, file)
            arguments
                s libradtran.Groups.Surfaces
                file {mustBeFile}
            end
            s.rpv_file = libradtran.Parameters.bdrf_rpv_file(file);
        end

        function s = RPVLibrary(s, options)
            arguments
                s libradtran.Groups.Surfaces
                options.Library_Path {mustBeFolder}
                options.Default = false
            end
            args = [fieldnames(options), options];
            index = reshape(1:numel(options), [2, numel(d)/2])';
            args = args(index(1:end));
            s.rpv_library = libradtran.Parameters.bdrf_rpv_library(args{:});
        end

        function s = BPDF(s, value)
            arguments
                s libradtran.Groups.Surfaces
                value
            end
            s.bpdf = libradtran.Parameters.bpdf_tsang_u10(value);
        end

    end
end



