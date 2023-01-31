classdef parameters < dynamicprops

    properties
    end

    methods
        function obj = parameters()
            obj = aerosol_angstrom(obj);
        end
    end
end

function obj = aerosol_angstrom(obj)
    options = alloptions();
    n_opts = numel(options);
    for i = 1:n_opts
        %disp(fieldnames(options{i}));
        opt = options{i};
        fields = fieldnames(opt);
        obj.addprop(fields{1});
        obj.(fields{1}) = opt.(fields{1});
        %len = numel(opt);
        %name = opt{1};
        %args = opt{2};
        %obj.addprop(name);
        %elem = element(args);
        %if len > 2
        %    elem = elem.addoptions(opt{3});
        %end
        %obj.(name) = elem;
    end
end

function name = fnname2optname()
    % Get the name of the function that calls fnname2optname() and remove the
    % last delimeted section. i.e. aerosol_angstrom_func becomes
    % aerosol_angstrom
    stack = dbstack(1);
    fnname = stack.name;
    splits = strsplit(fnname, '_');
    name = strjoin(splits(1:end-1), '_');
end

function s = variableSlots(slots)
    s = struct;
    for i = 1:numel(slots)
        s.(slots{i}) = {};
    end
end

function s = OptionsResult(options, varargin)
    p = inputParser;
    addRequired(p, 'options');
    addParameter(p, 'enumerate', false);
    addParameter(p, 'labels', {});
    addParameter(p, 'hasValue', false);
    parse(p, options, varargin{:});

    s = struct;
    s.Options = options;
    s.Result = {};
    s.Enumerate = p.Results.enumerate;
    s.Labels = options;
    if ~isempty(p.Results.labels)
        s.Labels = p.Results.labels;
    end
    s.hasValue = p.Results.hasValue;
end

function opt = aerosol_angstrom_func()
    opt.(fnname2optname()) = variableSlots({'alpha', 'beta'});
end

function opt = aerosol_default_func()
    name = fnname2optname();
    opt.(name) = struct;
    opt.(name).bool = false;
end

function opt = aerosol_file_func()
    name = fnname2optname();
    opt.(name) = variableSlots({'type', 'file'});
    opt.(name).Type = OptionsResult({'gg', 'ssa', 'tau', 'moments', 'explicit'});
    opt.(name).file = '';
end

function opt = aerosol_haze_func()
    name = fnname2optname();
    opt.(name) = OptionsResult({ ...
        'Rural type aerosols', 'Maritime type aerosols',     ...
        'Urban type aerosols', 'Tropospheric type aerosols', ...
        });
end

function opt = aerosol_king_byrne_func()
    opt.(fnname2optname()) = variableSlots({'alpha_0', 'alpha_1', 'alpha_2'});
end

function opt = aerosol_profile_modtran_func()
    opt.(fnname2optname()) = OptionsResult({'true', 'false'});
end

function opt = aerosol_season_func()
    opt.(fnname2optname()) = OptionsResult(...
        {'Spring-summer profile', 'Fall-winter profile'}, ...
        enumerate=true);
end

function opt = aerosol_set_tau_at_wvl_func()
    opt.(fnname2optname()) = variableSlots({'lambda', 'tau'});
end

function opt = aerosol_species_file_func()
    opt.(fnname2optname()) = OptionsResult({...
        'continental_clean',    'continental_average', ...
        'continental_polluted', 'urban',               ...
        'maritime_clean',       'maritime_polluted',   ...
        'maritime_tropical',    'desert',              ...
        'antarctic'});
end

function opt = aerosol_species_library_func()
    name = fnname2optname();
    opt.(name) = struct;
    opt.(name).OPAC = OptionsResult({...
        'INSO', 'WASO', 'SOOT', 'SSAM', 'SSCM', ...
        'MINM', 'MIAM', 'MICM', 'MITR', 'SUSO'}, ...
        labels={
        'insoluble',                 'water_soluble',
        'soot',                      'sea_salt_accumulation_mode',
        'sea_salt_coarse_mode',      'mineral_nucleation_mode',
        'mineral_accumulation_mode', 'mineral_coarse_mode',
        'mineral_transported',       'sulfate_droplets'});
end

function opt = aerosol_visibility_func()
    opt.(fnname2optname()) = {};
end

function opt = aerosol_vulcan_func()
    opt.(fnname2optname) = OptionsResult({...
        'Background aerosols',    'Moderate volcanic aerosols', ...
        'High volcanic aerosols', 'Extreme volcanic aerosols'}, ...
        enumerate=true);
end

function opt = albedo_func()
    opt.(fnname2optname()) = {};
end

function opt = albedo_file_func()
    opt.(fnname2optname) = {};
end

function opt = albedo_library_func()
    opt.(fnname2optname()) = OptionsResult({...
        'evergreen_needle_forest', 'evergreen_broad_forest', ...
        'deciduous_needle_forest', 'deciduous_broad_forest', ...
        'mixed_forest',            'closed_shrub', ...
        'open_shrubs',             'woody_savanna', ...
        'savanna',                 'grassland', ...
        'wetland',                 'cropland', ...
        'urban',                   'crop_mosaic', ...
        'antarctic_snow',          'desert', ...
        'ocean_water',             'tundra', ...
        'fresh_snow'});
end

function opt = altitude_func()
    opt.(fnname2optname()) = variableSlots({'first', 'second'});
end

function opt = atm_z_grid_func()
    opt.(fnname2optname()) = {};
end

function opt = atmosphere_file_func()
    %1, Altitude above sea level in km,
    %2, Pressure in hPa,
    %3, Temperature in K,
    %4, air density in cm −3,
    %5, Ozone density in cm −3,
    %6, Oxygen density in cm −3,
    %7, Water vapour density in cm −3,
    %8, CO2 density in cm −3,
    %9, NO2 density in cm −3,
    opt.(fnname2optname()) = OptionsResult({...
        'tropics',            'midlatitude_summer',
        'midlatitude_winter', 'subarctic_summer',
        'subarctic_winter',   'US-standard'}, ...
        labels={
        'Tropical',           'Midlatitude Summer',
        'Midlatitude Winter', 'Subarctic Summer',
        'Subarctic Winter',   'U.S. Standard'});
end

function opt = bpdf_tsant_u10_func()
    opt.(fnname2optname()) = {};
end

function opt = bdrf_ambrals_func()
    name = fnname2optname();
    opt.(name) = OptionsResult({'iso', 'vol', 'geo'}, hasValue=true);
end

function opt = bdrf_ambrals_file_func()
    opt.(fnname2optname()) = {};
end

function opt = brdf_ambrals_hotspot_func()
    opt.(fnname2optname()) = {};
end

function opt = brdf_cam_func()
    name = fnname2optname();
    opt.(name) = OptionsResult({'pcl', 'sal', 'u10', 'uphi', }, hasValue=true);
end

function opt = brdf_cam_solar_wind_func()
    opt.(fnname2optname()) = {};
end

function opt = brdf_hapke_func()
    name = fnname2optname();
    opt.(name) = OptionsResult({'w', 'B0', 'h'}, hasValue=true);
end

function opt = brdf_hapke_file_func()
    opt.(fnname2optname()) = {};
end

function opt = brdf_rpv_func()
    name = fnname2optname();
    opt.(name) = struct;
    opt.(name) = OptionsResult({...
        'k', 'rho0', 'theta', 'sigma', 't1', 't2', 'scale'}, hasValue=true);
end

function opt = brdf_rpv_file_func()
    opt.(fnname2optname()) = {};
end

function opt = brdf_rpv_library_func()
    opt.(fnname2optname()) = {};
end

function opt = brdf_rpv_type_func()
    opt.(fnname2optname()) = {};
end

function opt = ck_lowtran_absorption_func()
    opt.(fnname2optname()) = OptionsResult({...
        'O4', 'N2','CO','SO2','NH3','NO','HNO3'});
end

function opt = cloud_fraction_file_func()
    opt.(fnname2optname()) = {};
end

function opt = cloud_overlap_func()
    opt.(fnname2optname()) = OptionsResult({'rand', 'maxrand', 'max', 'off'});
end

function opt = cloudcover_func()
    opt.(fnname2optname()) = OptionsResult({'ic', 'wc'}, hasValue=true);
end

function opt = crs_file_func()
    opt.(fnname2optname()) = OptionsResult({...
        'O3',   'O2', 'H2O', 'CO2', 'NO2', 'BRO', 'OCLO', ...
        'HCHO', 'O4', 'SO2', 'CH4', 'N2O', 'CO',  'N2'});
end

function opt = crs_model_func()
    name = fnname2optname();
    opt.(name) = variableSlots({'rayleigh', 'o3', 'no2', 'o4'});
    opt.(name).rayleigh = OptionsResult({ ...
        'Bodhaine', 'Bodhaine29', 'Nicolet', 'Penndorf'});
    opt.(name).o3 = OptionsResult({ ...
        'Bass_and_Paur', 'Molina', 'Daumont', 'Bogumil', 'Serdyuchenko'});
    opt.(name).no2 = OptionsResult({'Burrows', 'Bogumil', 'Vandaele'});
    opt.(name).o4 = OptionsResult({'Greenblatt', 'Thalman'});
end

function opt = data_files_path_func()
    opt.(fnname2optname()) = {};
end

function opt = day_of_year_func()
    opt.(fnname2optname()) = {};
end

function opt = deltam_func()
    opt.(fnname2optname()) = {};
end

function opt = disort_intcor_func()
    opt.(fnname2optname()) = OptionsResult({'phase', 'moments', 'off'});
end

function opt = earth_radius_func()
    opt.(fnname2optname()) = {};
end

function opt = filter_function_file_func()
    opt.(fnname2optname()) = variableSlots({'file', 'normalise'});;
end

function opt = flourescence_func()
    opt.(fnname2optname()) = {};
end

function opt = flourescence_file_func()
    opt.(fnname2optname()) = {};
end

function opt = heating_rate_func()
    opt.(fnname2optname()) = OptionsResult({'layer_cd', 'local', 'layer_fd'});
end

function opt = ic_file_func()
    opt.(fnname2optname()) = {};
end

function opt = ic_fu_file()
    name = fnname2optname();
    opt.(name) = variableSlots({'reff_def', 'deltascaling'});
end

function options = alloptions()
    range = @(Start, Stop) linspace(Start, Stop, Stop);
    options = {...
        aerosol_angstrom_func(), ...
        aerosol_default_func(), ...
        aerosol_file_func(), ... % broken...
        aerosol_haze_func(), ...
        aerosol_king_byrne_func(), ...
        aerosol_profile_modtran_func(), ...
        aerosol_season_func(), ...
        aerosol_set_tau_at_wvl_func(), ...
        aerosol_species_file_func(), ...% this should be list [n]aero
        aerosol_species_library_func(), ...
        aerosol_visibility_func(), ...
        aerosol_vulcan_func(), ...
        albedo_func(), ...
        albedo_file_func(), ...
        albedo_library_func(), ...
        altitude_func(), ...
        atm_z_grid_func(), ...
        atmosphere_file_func(), ...
        bpdf_tsant_u10_func(), ...
        bdrf_ambrals_func(), ...
        bdrf_ambrals_file_func(), ...
        brdf_ambrals_hotspot_func(), ...
        brdf_cam_func(), ...
        brdf_cam_solar_wind_func(), ...
        brdf_hapke_func(), ...
        brdf_hapke_file_func(), ...
        brdf_rpv_func(), ...
        brdf_rpv_file_func(), ...
        brdf_rpv_library_func(), ...
        brdf_rpv_type_func(), ...
        ck_lowtran_absorption_func(), ...
        cloud_fraction_file_func(), ...
        cloud_overlap_func(), ...
        cloudcover_func(), ...
        crs_file_func(), ...
        crs_model_func(), ...
        data_files_path_func(), ...
        day_of_year_func(), ...
        deltam_func(), ...
        disort_intcor_func(), ...
        earth_radius_func(), ...
        filter_function_file_func(), ...
        flourescence_func(), ...
        flourescence_file_func(), ...
        heating_rate_func(), ...
        ic_file_func(), ...
    };
end
