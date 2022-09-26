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
            State_Probabilities=Source.State_Probabilities;
            State_Prep_Error=Source.State_Prep_Error;
            Rep_Rate=Source.Repetition_Rate;
            Detection_Efficiency=Detector.Detection_Efficiency;
            Background_Count_Prob=1-exp(-Background_Count_Rate*Detector.Time_Gate_Width);
            Eff=Protocol.Efficiency;
            QBER_Jitter=Detector.QBER_Jitter;
            Dead_Time=Detector.Dead_Time;
            Polarisation_Error=Detector.Polarisation_Error;
            
            %{
            % serialise task
            for i=1:L
            [Current_SKR,Current_QBER]=decoyBB84_model(MPN,...
                State_Probabilities,...
                State_Prep_Error,...
                Rep_Rate,...
                Detection_Efficiency,...
                Background_Count_Prob(i),...
                Link_Loss_dB(i),...
                Eff,...
                QBER_Jitter,...
                Dead_Time,...
                Polarisation_Error);
            
                Secret_Key_Rate(i)=Current_SKR;
                %use the first QBER as this is from the signal states
                QBER(i)=Current_QBER(1);
            end
            %}
                [Secret_Key_Rate,QBER]=decoyBB84_model(MPN,...
                State_Probabilities,...
                State_Prep_Error,...
                Rep_Rate,...
                Detection_Efficiency,...
                Background_Count_Prob,...
                Link_Loss_dB,...
                Eff,...
                QBER_Jitter,...
                Dead_Time,...
                Polarisation_Error);

                %use only the communicating state QBER

        end
    end
end