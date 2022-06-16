classdef BB84_Protocol < Protocol
    %BB84 protocol object describing and simulating the BB84 protocol

    properties(Abstract=false,SetAccess=protected)
        Name='BB84';
        Efficiency=0.5;
    end

    methods
        function obj = BB84_Protocol()
            %BB84 Construct an instance of this class
        end

        function [Secret_Key_Rate,QBER] = EvaluateQKDLink(Protocol,Source,Detector,Link_Loss_dB,Background_Count_Rate)
            [Secret_Key_Rate,QBER]=BB84_single_photon_model(Source.Mean_Photon_Number, Source.g2, Source.State_Prep_Error, Source.Repetition_Rate,...
    Detector.Detection_Efficiency, 1-exp(-Background_Count_Rate*Detector.Time_Gate_Width), Link_Loss_dB, Protocol.Efficiency, Detector.QBER_Jitter, Detector.Dead_Time);

        end
    end
end