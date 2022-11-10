classdef BB84_Protocol < Protocol
    %BB84 protocol object describing and simulating the BB84 protocol

    properties(Abstract=false,SetAccess=protected)
        Name='BB84';
        Efficiency=0.5;
        DetectorRequirements={'Dark_Count_Rate','Time_Gate_Width','Dead_Time'};
        SourceRequirements={'g2','Mean_Photon_Number','State_Prep_Error'};
    end

    methods
        function obj = BB84_Protocol()
            %BB84 Construct an instance of this class
        end

        function [Secret_Key_Rate, QBER, Photon_Rate_In, Photon_Rate_Det] = ...
                    EvaluateQKDLink(Protocol, Source, Detector, ...
                    Link_Loss_dB, Background_Count_Rate)

            [Current_SKR, Current_QBER, R_In, R_Det] = ...
                                            BB84_single_photon_model(...
                                    Source.Mean_Photon_Number,...
                                    Source.g2,...
                                    Source.State_Prep_Error,...
                                    Source.Repetition_Rate,...
                                    Detector.Detection_Efficiency,...
                                    1 - exp( -Background_Count_Rate ...
                                             *Detector.Time_Gate_Width ),...
                                    Link_Loss_dB,...
                                    Protocol.Efficiency,...
                                    Detector.QBER_Jitter,...
                                    Detector.Dead_Time,...
                                    Detector.Polarisation_Error, ...
                                    Detector);

            Secret_Key_Rate = Current_SKR;
            QBER = Current_QBER;
            Photon_Rate_In = R_In;
            Photon_Rate_Det = R_Det;

        end
    end
end
