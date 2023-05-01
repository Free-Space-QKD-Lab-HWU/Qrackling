classdef CV_Protocol < Protocol
    %CV protocol object describing and simulating the CV protocol

    % at this stage we do not simulate CV, this is a placeholder

    properties(Abstract=false,SetAccess=protected)
        Name='CV';
        Efficiency=1;
        DetectorRequirements={};
        SourceRequirements={};
    end

    methods
        function obj = CV_Protocol()
            %BB84 Construct an instance of this class
        end

        function [Secret_Key_Rate, QBER, Photon_Rate_In, Photon_Rate_Det] = ...
                    EvaluateQKDLink(Protocol, Source, Detector, ...
                    Link_Loss_dB, Background_Count_Rate)

           
            OutputSize = size(Background_Count_Rate);


            Secret_Key_Rate = 0*ones(OutputSize);
            QBER = 0*ones(OutputSize);
            Photon_Rate_In = 0*ones(OutputSize);
            Photon_Rate_Det = 0*ones(OutputSize);

        end
    end
end
