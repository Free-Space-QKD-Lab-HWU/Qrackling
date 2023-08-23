classdef Outputs < handle
    properties (SetAccess = protected)
        lrt_config libRadtran
    end

   properties (SetAccess = protected)
        Columns output_user
        Quantity output_quantity
        Process output_process
        File output_file
        Format output_format
   end

   methods
        function out = Outputs(options)
            arguments
                options.lrtConfiguration libRadtran
            end
            if numel(fieldnames(options)) > 0
                out.lrt_config = options.lrtConfiguration;
            end
        end

        function out = OutputColumns(out, label)
            arguments
                out Outputs
            end
            arguments (Repeating)
                label {mustBeMember(label, {                      ...
                    'lambda',   'wavenumber', 'sza',    'zout',     ...
                    'edir',     'eglo',       'edn',    'eup',      ...
                    'enet',     'esum',       'uu',     'fdir',     ...
                    'fglo',     'fdn',        'fup',    'f',        ...
                    'uavgdir',  'uavgglo',    'uavgdn', 'uavgup',   ...
                    'uavg',     'spher_alb',  'albedo', 'heat',     ...
                    'p',        'T',          'T_d',    'T_sur',    ...
                    'theta',    'theta_e',    'n_AIR',  'rho_AIR',  ...
                    'mmr_AIR',  'vmr_AIR',    'n_O3',   'rho_O3',   ...
                    'mmr_O3',   'vmr_O3',     'n_O2',   'rho_O2',   ...
                    'mmr_O2',   'vmr_O2',     'n_H20',  'rho_H20',  ...
                    'mmr_H20',  'vmr_H20',    'n_CO2',  'rho_CO2',  ...
                    'mmr_CO2',  'vmr_CO2',    'n_NO2',  'rho_NO2',  ...
                    'mmr_NO2',  'vmr_NO2',    'n_BRO',  'rho_BRO',  ...
                    'mmr_BRO',  'vmr_BRO',    'n_OCLO', 'rho_OCLO', ...
                    'mmr_OCLO', 'vmr_OCLO',   'n_HCHO', 'rho_HCHO', ...
                    'mmr_HCHO', 'vmr_HCHO',   'n_O4',   'rho_O4',   ...
                    'mmr_O4',   'vmr_O4'})}

            end
            out.Columns = output_user(label{1:end});
        end

        function out = OutputQuantity(out, label)
            arguments
                out Outputs
                label {mustBeMember(label, {'brightness', 'reflectivity', ...
                    'transmittance'})}
            end
            out.Quantity = output_quantity(label{1:end});
        end


        function out = PostProcessing(out, label)
            arguments
                out Outputs
                label {mustBeMember(label, {'sum', 'integrate', 'per_nm', ...
                    'per_cm-1', 'per_band', 'none'})}
            end
            out.Process = output_process(label{1:end});
        end

        function out = FileAndFormat(out, options)
            arguments
                out Outputs
                options.File {mustBeText}
                options.Format {mustBeMember(options.Format, {'ascii', 'flexstor'})}
            end
            for opt = fieldnames(options)
                switch opt{1}
                    case "File"
                        out.File = output_file(options.File{1:end});
                    case "Format"
                        out.Format = output_format(options.Format{1:end});
                end
            end
        end

        function str = ConfigString(out)
            arguments
                out Outputs
            end
            linebreak = newline;
            if ispc
                linebreak = [char(13), char(10)];
            end
            str = '';
            for p = properties(out)'
                sub = properties(out.(p{1}));
                current = out.(p{1});
                if ~isempty(current)
                    temp = current.(sub{1});
                    switch class(temp)
                        case 'cell'
                            str = append(str, [class(current), ' ', strjoin(temp, ' ')]);
                        case 'char'
                            str = append(str, [class(current), ' ', temp]);
                    end
                    str = append(str, linebreak);
                end
            end
        end
   end
end
