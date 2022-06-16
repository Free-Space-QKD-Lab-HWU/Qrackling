classdef E91_Protocol < Protocol
    %BB84 protocol object describing BB84

    properties(Abstract=false,SetAccess=protected)
        Name='E91';
        Efficiency=1;
    end

    methods
        function obj = E91_Protocol()
            %BB84 Construct an instance of this class
        end

        function [Secret_Key_Rate,QBER] = EvaluateQKDLink(Protocol,Source,Detector,Link_Loss_dB,Background_Count_Rate)
            [Secret_Key_Rate,QBER]=ekart92_model(Source.Repetition_Rate, Detector.Detection_Efficiency, 1-exp(-Background_Count_Rate*Detector.Time_Gate_Width), Link_Loss_dB, Protocol.Efficiency, Detector.QBER_Jitter, Detector.Dead_Time);

        end
    end
end