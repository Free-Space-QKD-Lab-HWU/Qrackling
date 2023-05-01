classdef Protocol
    %PROTOCOL describes the operation of a QKD protocol

   enumeration
    %% Requirements for an enumeration are:
        % source requirements (what properties does the source object
        % need)
        % detector requirements (what properties does the detector object
        % need)
        % efficiency (what portion of successful detections generate key
        % Evaluation_Function (a function which computes SKR and QBER. This
        % must conform to [SKR, QBER, Rate_In, Rate_Det] = EvaluateQKDLink( ...
        % proto, source, detector, Link_Loss_dB, Background_Count_Rate)


        %% the BB84 protocol enumeration
        BB84 (...%Source requirements
              {'g2',...
               'Mean_Photon_Number',...
               'State_Prep_Error'},...
               ...%detector requirements
              {'Dark_Count_Rate',...
               'Time_Gate_Width',...
               'Dead_Time'},...
               ...%efficiency
                0.5,...
                ...%evaluation function to compute SKR,QBER etc
                @BB84_single_photon_model);

        %% the decoy BB84 enumeration
        DecoyBB84(...%Source requirements
                   {'Mean_Photon_Number', ...
                   'State_Prep_Error', ...
                   'State_Probabilities'},...
                   ...%Detector requirements
                   {'Dark_Count_Rate',...
                    'Time_Gate_Width',...
                    'Dead_Time'},...
                    ...%efficiency
                    0.5,...
                ...%evaluation function to compute SKR,QBER etc
                @decoyBB84_model);

        %% the COW enumeration
        E91(...%Source requirements
                   {'Mean_Photon_Number', ...
                   'State_Prep_Error', ...
                   'g2'},...
                   ...%Detector requirements
                   {'Dark_Count_Rate',...
                    'Time_Gate_Width',...
                    'Dark_Count_Rate'},...
                    ...%efficiency
                    1,...
                ...%evaluation function to compute SKR,QBER etc
                @ekart92_model);

        %% the COW enumeration
        COW(...%Source requirements
                   {'Mean_Photon_Number', ...
                   'State_Prep_Error', ...
                   'State_Probabilities'},...
                   ...%Detector requirements
                   {'Dark_Count_Rate',...
                    'Time_Gate_Width',...
                    'Visibility'},...
                    ...%efficiency
                    1,...
                ...%evaluation function to compute SKR,QBER etc
                @COW_model);
       %% the DPS enumeration
        DPS(...%Source requirements
                   {'Mean_Photon_Number', ...
                   'State_Prep_Error', ...
                   'State_Probabilities'},...
                   ...%Detector requirements
                   {'Dark_Count_Rate',...
                    'Time_Gate_Width',...
                    'Dead_Time',...
                    'QBER_Jitter'},...
                    ...%efficiency
                    1,...
                ...%evaluation function to compute SKR,QBER etc
                function_handle.empty);%DPS is missing a function!
    end

   properties(SetAccess = immutable)
        source_requirements = {};
        detector_requirements = {};
        efficiency double {mustBeLessThanOrEqual(efficiency,1),mustBeNonnegative}
        Evaluation_Function function_handle {mustBeScalarOrEmpty}=function_handle.empty;
   end

   methods
        function proto = Protocol( ...
            Source_Requirements, Detector_Requirements, Efficiency, EvaluationFunction)
           %implement these inputs in the class. These are set by the
           %enumeration class constructor ONLY (immutable)
           proto.source_requirements = Source_Requirements;
           proto.detector_requirements = Detector_Requirements;
           proto.efficiency = Efficiency;
           proto.Evaluation_Function = EvaluationFunction;
       end

        function check = compatibleSource(proto, source)
        %%COMPATIBLESOURCE check that the given source has the properties
        %%required for the current protocol
            arguments
                proto Protocol
                source Source
            end

            check = false;
            for i = 1 : numel(proto.source_requirements)
                requirement = proto.source_requirements{i};

                has_prop = isprop(source, requirement);
                has_value = ~isempty(source.(requirement));

                assert(has_prop && has_value, [ ...
                    'Source: \{', ...
                    inputname(2), ...
                    '\} is missing the field: \{', ...
                    requirement, ...
                    '\} -- set to: ', ...
                    num2str(source.(requirement)) ...
                ]);
            end
            check = true;
        end

        function check = compatibleDetector(proto, detector)
        %%COMPATIBLEDETECTOR check that the given detector has the properties
        %%required for the current protocol
            arguments
                proto Protocol
                detector Detector
            end

            check = false;
            for i = 1 : numel(proto.detector_requirements)
                requirement = proto.detector_requirements{i};

                has_prop = isprop(detector, requirement);
                has_value = ~isempty(detector.(requirement));

                assert(has_prop && has_value, [ ...
                    'Detector: \{', ...
                    inputname(2), ...
                    '\} is missing the field: \{', ...
                    requirement, ...
                    '\} -- set to: ', ...
                    num2str(detector.(requirement)) ...
                ]);
            end
            check = true;
        end

        function [SKR, QBER, Rate_In, Rate_Det] = EvaluateQKDLink( ...
            proto, source, detector, Link_Loss_dB, Background_Count_Rate)
        %%EVALUATEQKDLINK enact the link performance simulation for the
        %%particular protocol

            arguments
                proto Protocol
                source Source
                detector Detector
                Link_Loss_dB
                Background_Count_Rate
            end

            %check compatibility
            proto.compatibleSource(source);
            proto.compatibleDetector(detector);

            %get inputs to evaluation function (probability of dark counts in a
            %pulse)
            dark_count_probability = 1 - exp(-Background_Count_Rate * detector.Time_Gate_Width);

            %run protocol's evaluation function
            %all evaluation functions must conform to this format
            [SKR, QBER, Rate_In, Rate_Det] = ...
                proto.Evaluation_Function( ...
                    source, ...
                    dark_count_probability, ...
                    Link_Loss_dB, ...
                    proto.efficiency, ...
                    detector);
        end
   end
end
