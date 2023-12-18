classdef Spectral < handle

    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
        radiation_source libradtran.Parameters.source
        thermal_bands libradtran.Parameters.thermal_bands_file
        bandwidth libradtran.Parameters.thermal_bandwidth
        wavelength_range libradtran.Parameters.wavelength
        index libradtran.Parameters.wavelength_index
        wavelength_grid libradtran.Parameters.wavelength_grid_file
    end
    methods
        function s = Spectral(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                s.lrt_config = options.lrtConfiguration;
                options.lrtConfiguration.Spectral_Settings = s;
            end
        end

        function s = RadiationSource(s, type, options)
            arguments
                s libradtran.Groups.Spectral
                type {mustBeMember(type, {'solar', 'thermal'})}
                options.File {mustBeFile}
                options.Unit {mustBeMember(options.Unit, {'per_nm', 'per_cm-1'})}
            end
            args = {type};
            for f = fieldnames(options)'
                args = [args, f{1}, options.(f{1})];
            end
            s.radiation_source = libradtran.Parameters.source(args{:});
        end

        function s = ThermalBands(s, file)
            arguments
                s libradtran.Groups.Spectral
                file {mustBeFile}
            end
            s.thermal_bands = libradtran.Parameters.thermal_bands_file(file);
        end

        function s = Bandwidth(s, value)
            arguments
                s libradtran.Groups.Spectral
                value
            end
            s.bandwidth = libradtran.Parameters.thermal_bandwidth(value);
        end

        function s = WavelengthRange(s, start, stop)
            arguments
                s libradtran.Groups.Spectral
                start
                stop
            end
            s.wavelength_range = libradtran.Parameters.wavelength(start, stop);
        end

        function s = Index(s, value)
            arguments
                s libradtran.Groups.Spectral
                value
            end
            s.index = libradtran.Parameters.wavelength_index(value);
        end

        function s = WavelengthGrid(s, file)
            arguments
                s libradtran.Groups.Spectral
                file {mustBeFile}
            end
            s.wavelength_grid = libradtran.Parameters.wavelength_grid_file(file);
        end

    end
end
