classdef gas_atmospheric_absorption < card
    properties
        % Volumetric concentrations in the assumed 1Km deep tropospheric
        % pollution layer (ppmv)

        iload = 1;

        CH2O;
        CH4;
        CO;
        HNO2;
        HNO3;
        NO;
        NO2;
        NO3;
        O3;
        SO2;

    end

    properties(Hidden=true)
        pollutants = {'CH2O', 'CH4', 'CO', 'HNO2', 'HNO3', 'NO', 'NO2', ...
                      'NO3', 'O3', 'SO2'};
        default_keys = {'pristine', 'light_pollution', ...
                        'moderate_pollution', 'severe_pollution'};
        pristine = [-0.003, 0, -0.1, -9.9e-4, 0, 0, 0, -4.9e-4, -0.007, 0];
        light_pollution = [0.001, 0.2, 0, 0.0005, 0.001, 0.075, 0.005, ...
                           1e-5, 0.023, 0.01];
        moderate_pollution = [0.007, 0.3, 0.35, 0.002, 0.005, 0.2, 0.02, ...
                              5e-5, 0.053, 0.05];
        severe_pollution = [0.01, 0.4, 9.9, 0.01, 0.012, 0.5, 0.2, 2e-4, ...
                            0.175, 0.2];
    end

    methods
        
        function gas_atmospheric_absorption = gas_atmospheric_absorption(...
                                                varargin)

            gas_atmospheric_absorption.card_type = 'IGAS';
            gas_atmospheric_absorption.card_num = 6;
            gas_atmospheric_absorption.groups = { ...
                {'iload'}, {}, {'iload','CH2O', 'CH4', 'CO', 'HNO2', 'HNO3', ...
                 'NO', 'NO2', 'NO3', 'O3', 'SO2' }};
            gas_atmospheric_absorption.suffix = {'a', '', 'b'};

            p = inputParser;
            addParameter(p, 'iload', -1);
            addParameter(p, 'ApCH2O', nan);
            addParameter(p, 'ApCH4', nan);
            addParameter(p, 'ApCO', nan);
            addParameter(p, 'ApHNO2', nan);
            addParameter(p, 'ApHNO3', nan);
            addParameter(p, 'ApNO', nan);
            addParameter(p, 'ApNO2', nan);
            addParameter(p, 'ApNO3', nan);
            addParameter(p, 'ApO3', nan);
            addParameter(p, 'ApSO2', nan);

            parse(p, varargin{:});

            if any(isnan([p.Results.ApCH2O, p.Results.ApCH4, ...
                          p.Results.ApCO, p.Results.ApHNO2, ...
                          p.Results.ApHNO3, p.Results.ApNO, ...
                          p.Results.ApNO2, p.Results.ApNO3, ...
                          p.Results.ApO3, p.Results.ApSO2]))

                gas_atmospheric_absorption.flag = 1;

                if 0 < p.Results.iload

                    gas_atmospheric_absorption.flag = 0;
                    gas_atmospheric_absorption = ...
                            gas_atmospheric_absorption.apply_default(...
                                        p.Results.iload);
                    gas_atmospheric_absorption.iload = p.Results.iload;

                end

            else

                gas_atmospheric_absorption.flag = 2;
                gas_atmospheric_absorption.iload = 0;
                gas_atmospheric_absorption.CH2O = p.Results.ApCH2O;
                gas_atmospheric_absorption.CH4 = p.Results.ApCH4;
                gas_atmospheric_absorption.CO = p.Results.ApCO;
                gas_atmospheric_absorption.HNO2 = p.Results.ApHNO2;
                gas_atmospheric_absorption.HNO3 = p.Results.ApHNO3;
                gas_atmospheric_absorption.NO = p.Results.ApNO;
                gas_atmospheric_absorption.NO2 = p.Results.ApNO2;
                gas_atmospheric_absorption.NO3 = p.Results.ApNO3;
                gas_atmospheric_absorption.O3 = p.Results.ApO3;
                gas_atmospheric_absorption.SO2 = p.Results.ApSO2;
            
            end

        end


        function gas_atmospheric_absorption = apply_default(...
                gas_atmospheric_absorption, default)

            default_key = gas_atmospheric_absorption.default_keys{default};
            default_vals = gas_atmospheric_absorption.(default_key);

            for i = 1 : length(default_vals)
                current_key = gas_atmospheric_absorption.pollutants{i};
                gas_atmospheric_absorption.(current_key) = default_vals(i);
            end
        end

    end
end
