classdef decoyBB84_Protocol < Protocol
    %BB84 protocol object describing BB84

    properties(Abstract=false,SetAccess=protected)
        Name='decoyBB84';
        Efficiency=0.5;
        DetectorRequirements={'Dark_Count_Rate','Time_Gate_Width','Dead_Time'};
        SourceRequirements={'Mean_Photon_Number','State_Prep_Error','State_Probabilities'};
    end

    methods
        function obj = decoyBB84_Protocol()
            %BB84 Construct an instance of this class
        end

        function [Secret_Key_Rate,QBER] = EvaluateQKDLink(Protocol,Source,Detector,Link_Loss_dB,Background_Count_Rate)
            %if input is empty, return empty output
            if isempty(Link_Loss_dB)&&isempty(Background_Count_Rate)
                Secret_Key_Rate=[];
                QBER=[];
                return
            end
            
            %serialise to deal with singular output of decoyBB84_Model
            if ~(isvector(Link_Loss_dB)&&isvector(Background_Count_Rate))
                error('Link loss and BCR must be at most 1-dimensional arrays (i.e vectors)')
            end
            sz=size(Link_Loss_dB);
            L=max(sz);
            Secret_Key_Rate=zeros(sz);
            QBER=nan(sz);
            
            %prepare input variables
            MPN=Source.Mean_Photon_Number;
            SP=Source.State_Probabilities;
            SPE=Source.State_Prep_Error;
            RR=Source.Repetition_Rate;
            DE=Detector.Detection_Efficiency;
            BCR_Prob=1-exp(-Background_Count_Rate*Detector.Time_Gate_Width);
            Eff=Protocol.Efficiency;
            QBER_Jit=Detector.QBER_Jitter;
            DT=Detector.Dead_Time;
            PE=Detector.Polarisation_Error;

            % serialise task
            for i=1:L
            [Current_SKR,Current_QBER]=decoyBB84_model(MPN, SP, SPE, RR,...
    DE, BCR_Prob(i), Link_Loss_dB(i), Eff, QBER_Jit, DT, PE);
                Secret_Key_Rate(i)=Current_SKR;
                %use the first QBER as this is from the signal states
                QBER(i)=Current_QBER(1);
            end

        end
    end
end