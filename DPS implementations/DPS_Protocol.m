classdef DPS_Protocol < Protocol
    %object describing and performance analysing the DPS protocol

    properties(Abstract=false,SetAccess=protected)
        Name='DPS';
        Efficiency=1;
        DetectorRequirements={'Dark_Count_Rate','Time_Gate_Width','QBER_Jitter','Visibility'};
        SourceRequirements={'Mean_Photon_Number','Repetition_Rate','State_Prep_Error'};
    end

    methods
        function obj = DPS_Protocol()
            %Construct an instance of this class
        end

        function [Secret_Key_Rate,QBER] = EvaluateQKDLink(Protocol,DPS_Source,DPS_Detector,Link_Loss_dB,Background_Count_Rate)

            [Secret_Key_Rate,QBER]=DPS_model(Link_Loss_dB, DPS_Source.Mean_Photon_Number, DPS_Source.Repetition_Rate, 1-exp(-Background_Count_Rate.*DPS_Detector.Time_Gate_Width), DPS_Source.State_Prep_Error, DPS_Detector.QBER_Jitter, DPS_Detector.Visibility);
        end
    end
end