classdef DetectorPresets

    enumeration
        Hamamatsu, MicroPhotonDevices, Excelitas, PerkinElmer, Custom
    end

    methods

        function chosenPreset = fromPreset(preset)

            preset = struct();


            switch presets
                case Hamamatsu
                    preset.Dark_Count_Rate = 10;
                    preset.Dead_Time = 0;
                    preset.Histogram_Data_Location = 'HamamatsuHistogram.mat';
                    preset.Histogram_Bin_Width = 10^-12;
                    preset.Detection_Efficiency = 0.6;
                    preset.Efficiency_Data_Location = 'Hamamatsu_efficiency.mat';

                case MicroPhotonDevices

                case Excelitas

                case PerkinElmer
                    preset = Dark_Count_Rate = 10;
                    preset = Dead_Time = 0;
                    preset = Histogram_Data_Location = 'Perkin_ElmerHistogram.mat';
                    preset = Histogram_Bin_Width = 10^-12;
                    preset = Detection_Efficiency = 0.6;
                    preset = Efficiency_Data_Location = 'perkin_elmer_efficiency.mat';

                case Custom
                    disp('must have file path');

                otherwise
                    error(['\{ ', string(preset), ' \} not supported']);
            end
        end

    end
