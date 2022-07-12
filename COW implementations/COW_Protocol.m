classdef COW_Protocol < Protocol
    %COW_protocol object describing and simulating the COW protocol

    properties(Abstract=false,SetAccess=protected)
        Name='COW';
        Efficiency=1;
        DetectorRequirements={'Dark_Count_Rate','Time_Gate_Width','Dead_Time','tB','Visibility'};
        SourceRequirements={'Decoy_Probability','Mean_Photon_Number','Extinction_Ratio'};
    end

    methods
        function obj = COW_Protocol()
            %COW Construct an instance of this class
        end

        function [Secret_Key_Rate,QBER] = EvaluateQKDLink(Protocol,COW_Source,COW_Detector,Link_Loss_dB,Background_Count_Rate)
            %serialise to deal with singular output of COW model
            sz=size(Link_Loss_dB);
            Secret_Key_Rate=zeros(sz);
            QBER=nan(sz);

            % serialise task
            for i=1:sz(1)
                for j=1:sz(2)
            [Current_SKR,~,Current_QBER]=COW_model(COW_Source.Mean_Photon_Number, COW_Source.Extinction_Ratio, COW_Source.Repetition_Rate,...
    COW_Detector.Detection_Efficiency, 1-exp(-Background_Count_Rate(i,j)*COW_Detector.Time_Gate_Width),Background_Count_Rate(i,j), Link_Loss_dB(i,j),...
    COW_Detector.QBER_Jitter, COW_Detector.Dead_Time,COW_Source.Decoy_Probability,COW_Detector.tB,COW_Detector.Visibility);
                Secret_Key_Rate(i,j)=Current_SKR;
                %use the first QBER as this is from the signal states
                QBER(i,j)=Current_QBER(1);
                end
            end
        end
    end
end