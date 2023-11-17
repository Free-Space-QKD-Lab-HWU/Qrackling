classdef Clouds < handle
    properties (SetAccess = protected)
        lrt_config libRadtran.libRadtran
    end

    properties (SetAccess = protected)
        water_cloud_file libradtran.Parameters.wc_file
        water_cloud_modifications libradtran.Parameters.wc_modify
        water_cloud_properties libradtran.Parameters.wc_properties
        ice_cloud_file libradtran.Parameters.ic_file
        ice_cloud_radius_definition libradtran.Parameters.ic_fu
        ice_cloud_delta_scaling libradtran.Parameters.ic_fu
        ice_cloud_parameterisation libradtran.Parameters.ic_habit
        ice_cloud_Yang_parametersiation libradtran.Parameters.ic_habit_yang2013
        ice_cloud_modifications libradtran.Parameters.ic_modify
        ice_cloud_properties libradtran.Parameters.ic_properties
        water_cloud_cover libradtran.Parameters.cloudcover
        ice_cloud_cover libradtran.Parameters.cloudcover
        cloud_fraction_profile libradtran.Parameters.cloud_fraction_file
        overlap libradtran.Parameters.cloud_overlap
    end

    methods
        function c = Clouds(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                c.lrt_config = options.lrtConfiguration;
                options.lrtConfiguration.Cloud_Settings = c;
            end
        end

        function c = WaterCloudFile(c, type, file)
            arguments
                c libradtran.Groups.Clouds
                type {mustBeMember(type, {'1D', 'ipa_files', 'moments'})}
                file {mustBeFile}
            end
            c.water_cloud_file = libradtran.Parameters.wc_file(type, file);
        end

        function c = ModifyWaterCloud(c, variable, type, value)
            arguments
                c libradtran.Groups.Clouds
            end
            arguments (Repeating)
                variable {mustBeMember(variable, {'gg', 'ssa', 'tau', 'tau550'})}
                type {mustBeMember(type, {'set', 'scale'})}
                value {mustBeNumeric}
            end
            args = [variable, type, value];
            index = reshape(1:numel(d), [3, numel(d)/3])';
            args = args(index(1:end));
            c.water_cloud_modifications = libradtran.Parameters.wc_modify(args{:});
        end

        function c = WaterCloudOpticalProperties(c, property, options)
            arguments
                c libradtran.Groups.Clouds
            end
            arguments
                property {mustBeMember(property, {'hu', 'echam4', 'mie', 'filename'})}
                options.interpolate matlab.lang.OnOffSwitchState
            end
            if numel(fieldnames(options)) ~= 0
                c.water_cloud_properties = libradtran.Parameters.wc_properties(property, "interpolate", options.interpolate);
                return
            end
            c.water_cloud_properties = libradtran.Parameters.wc_properties(property);
        end

        function c = IceCloudFile(c, type, file)
            arguments
                c libradtran.Groups.Clouds
                type {mustBeMember(type, {'ic', 'wc'})}
                file {mustBeFile}
            end
            c.ice_cloud_file = libradtran.Parameters.ic_file(type, file);
        end

        function c = IceCloudRadiusDefinition(c, state)
            arguments
                c libradtran.Groups.Clouds
                state matlab.lang.OnOffSwitchState
            end
            c.ice_cloud_radius_definition = libradtran.Parameters.ic_fu("reff_deff", state);
        end

        function c = IceCloudDeltaScaling(c, state)
            arguments
                c libradtran.Groups.Clouds
                state matlab.lang.OnOffSwitchState
            end
            c.ice_cloud_radius_definition = libradtran.Parameters.ic_fu("deltascaling", state);
        end

        function c = IceCrystalParameterisation(c, type)
            arguments
                c Cloud
                type {mustBeMember(type, {...
                    'solid-column', 'hollow-column', 'rough-aggregate', ...
                    'rosette-4',    'rosette-6',     'plate', ...
                    'droxtal',      'dendrite',      'spheroid'})}
            end
            c.ice_cloud_parameterisation = libradtran.Parameters.ic_habit(type);
            warning("libradtran.Groups.Clouds.ice_cloud_properties must be set to one of {key, yang, hey}")
        end

        function c = IceCrystalParameterisationYang(c, type)
            arguments
                c libradtran.Groups.Clouds
                type {mustBeMember(type, {...
                    'column_8elements',      'droxtal', ...
                    'hollow_bullet_rosette', 'hollow_column', ...
                    'plate',                 'plate_10elements',      ...
                    'plate_5elements',       'solid_bullet_rosette', ...
                    'solid_column'})}
            end
            warning("libradtran.Groups.Clouds.ice_cloud_properties must be set to {yang_2013}")
            c.ice_cloud_Yang_parametersiation = libradtran.Parameters.ic_habit_yang2013(type);
        end

        function c = ModifyIceCloud(c, variable, type, value)
            arguments
                c libradtran.Groups.Clouds
            end
            arguments (Repeating)
                variable {mustBeMember(variable, {'gg', 'ssa', 'tau', 'tau550'})}
                type {mustBeMember(type, {'set', 'scale'})}
                value {mustBeNumeric}
            end
            args = [variable, type, value];
            index = reshape(1:numel(d), [3, numel(d)/3])';
            args = args(index(1:end));
            c.ice_cloud_modifications = libradtran.Parameters.ic_modify(args{:});
        end

        function c = Waterlibradtran.Parameters.cloudcover(c, value)
            arguments
                c Cloud
                value {mustBeNumeric}
            end
            c.water_cloud_cover = libradtran.Parameters.cloudcover("wc", value);
        end

        function c = Icelibradtran.Parameters.cloudcover(c, value)
            arguments
                c Cloud
                value {mustBeNumeric}
            end
            c.ice_cloud_cover = libradtran.Parameters.cloudcover("ic", value);
        end

        function c = CloudFractionProfile(c, file)
            arguments
                c Cloud
                file {mustBeFile}
            end
            c.cloud_fraction_profile = libradtran.Parameters.cloud_fraction_file(file);
        end

        function c = Overlap(c, type)
            arguments
                c Cloud
                type {mustBeMember(type, {'rand', 'maxrand', 'max', 'off'})}
            end
            c.overlap = libradtran.Parameters.cloud_overlap(type);
        end
    end
end


