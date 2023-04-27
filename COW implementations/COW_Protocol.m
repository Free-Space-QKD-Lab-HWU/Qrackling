classdef COW_Protocol < Protocol
    %COW_protocol object describing and simulating the COW protocol

    properties(Abstract=false,SetAccess=protected)
        Name='COW';
        Efficiency=1;
        DetectorRequirements={'Time_Gate_Width', 'Dead_Time', 'Visibility'};
        SourceRequirements={'State_Probabilities', 'Mean_Photon_Number', ...
                            'State_Prep_Error'};
    end

    methods
        function obj = COW_Protocol()
            %COW Construct an instance of this class
        end

        function [Secret_Key_Rate, QBER, Photon_Rate_In, Photon_Rate_Det] = ...
                    EvaluateQKDLink(~, ...
                                    COW_Source, ...
                                    COW_Detector, ...
                                    Link_Loss_dB, ...
                                    Background_Count_Rate)

            % COW model is vectorised
            [Current_SKR, Current_QBER, R_In, R_Det] = COW_model(...
                    COW_Source.Mean_Photon_Number, ...
                    COW_Source.State_Prep_Error, ...
                    COW_Source.Repetition_Rate, ...
                    1 - exp( -Background_Count_Rate ...
                             *COW_Detector.Time_Gate_Width ), ...
                    Link_Loss_dB,...
                    COW_Detector.QBER_Jitter, ...
                    COW_Detector.Dead_Time,...
                    COW_Source.State_Probabilities(2),...
                    COW_Detector.Visibility, ...
                    COW_Detector); 

            QBER = Current_QBER;
            Photon_Rate_In = R_In;
            Photon_Rate_Det = R_Det;
        end
    end
end
