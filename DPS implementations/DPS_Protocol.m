classdef DPS_Protocol < Protocol
    %object describing and performance analysing the DPS protocol

    properties(Abstract=false,SetAccess=protected)
        Name='DPS';
        Efficiency=1;
    end

    methods
        function obj = DPS_Protocol()
            %Construct an instance of this class
        end

        function [Secret_Key_Rate,QBER] = EvaluateQKDLink(Protocol,DPS_Source,DPS_Detector,Link_Loss_dB,Background_Count_Rate)
            %serialise to deal with singular output of DPS_Model

            %allocate memory
            sz=size(Link_Loss_dB);
            Secret_Key_Rate=zeros(sz);
            QBER=nan(sz);

            % serialise task
            for i=1:sz(1)
                for j=1:sz(2)
            [Current_SKR,~,Current_QBER]=DPS_model(DPS_Source.Mean_Photon_Number, DPS_Source.Extinction_Ratio, DPS_Source.Repetition_Rate,...
    DPS_Detector.Detection_Efficiency, 1-exp(-Background_Count_Rate(i,j)*DPS_Detector.Time_Gate_Width),Background_Count_Rate(i,j), Link_Loss_dB(i,j),...
    DPS_Detector.QBER_Jitter, DPS_Detector.Dead_Time,DPS_Source.Decoy_Probability,DPS_Detector.Visibility);
                Secret_Key_Rate(i,j)=Current_SKR;
                %use the first QBER as this is from the signal states
                QBER(i,j)=Current_QBER(1);
                end
            end
        end
    end
end