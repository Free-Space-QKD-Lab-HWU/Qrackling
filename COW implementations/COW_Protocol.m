classdef COW_Protocol < Protocol
    %COW_protocol object describing and simulating the COW protocol

    properties(Abstract=false,SetAccess=protected)
        Name='COW';
        Efficiency=1;
        DetectorRequirements={'Time_Gate_Width','Dead_Time','Visibility'};
        SourceRequirements={'Decoy_Probability','Mean_Photon_Number','State_Prep_Error'};
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
            [Current_SKR,Current_QBER]=COW_model(COW_Source.Mean_Photon_Number, COW_Source.State_Prep_Error, COW_Source.Repetition_Rate, 1-exp(-Background_Count_Rate(i,j)*COW_Detector.Time_Gate_Width), Link_Loss_dB(i,j),...
    COW_Detector.QBER_Jitter, COW_Detector.Dead_Time,COW_Source.Decoy_Probability,COW_Detector.Visibility);
                Secret_Key_Rate(i,j)=Current_SKR;
                %use the first QBER as this is from the signal states
                QBER(i,j)=Current_QBER(1);
                end
            end
        end
    end
end