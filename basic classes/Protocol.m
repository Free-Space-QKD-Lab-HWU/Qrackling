classdef Protocol
    %PROTOCOL describes the operation of a QKD protocol

   enumeration
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
                0.5);
        
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
                    0.5);
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
                    1);
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
                    1);
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
                    1);
    end

   properties(SetAccess = immutable)
        source_requirements = {};
        detector_requirements = {};
        efficiency double {mustBeLessThanOrEqual(efficiency,1),mustBeNonnegative}
   end

   methods
       function AP = Protocol(Source_Requirements,...
                                        Detector_Requirements,...
                                        Efficiency)
           %implement these inputs in the class. These are set by the
           %enumeration class constructor ONLY (immutable)
           AP.source_requirements=Source_Requirements;
           AP.detector_requirements=Detector_Requirements;
           AP.efficiency=Efficiency;
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

            check = proto.compatibleSource(source);
            check = proto.compatibleDetector(detector);
            prot_eff = proto.efficiency;

            dark_counts = 1 - exp(-Background_Count_Rate * detector.Time_Gate_Width);

            % Use the qkd_protocols enum (protocol.QKD_protocol) to execute the
            % correct qkd function and return the secure key rate, QBER along
            % with the received count rate and detected count rate
            switch proto
                case Protocol.BB84
                    [SKR, QBER, Rate_In, Rate_Det] = BB84_single_photon_model( ...
                         source, dark_counts, Link_Loss_dB, prot_eff, detector);

                case Protocol.DecoyBB84
                    assert(isvector(Link_Loss_dB) ...
                           && isvector(Background_Count_Rate), ...
                           'Link loss and BCR must be at most 1-dimensional arrays');

                    sz = size(Link_Loss_dB);
                    SKR = zeros(sz);
                    QBER = nan(sz);
                    Rate_In = zeros(sz);
                    Rate_Det = zeros(sz);

                    for i = 1 : max(sz)
                        [s, q, ri, rd] = decoyBB84_model( ...
                            source, dark_counts(i), Link_Loss_dB(i), prot_eff, detector);

                        SKR(i) = s;
                        %use the first QBER as this is from the signal states
                        QBER(i) = q(1);
                        Rate_In(i) = ri;
                        Rate_Det(i) = rd;
                    end

                case Protocol.E91
                    [SKR, QBER, Rate_In, Rate_Det] = ekart92_model( ...
                        source, dark_counts, Link_Loss_dB, prot_eff, detector);

                case Protocol.COW
                    [SKR, QBER, Rate_In, Rate_Det] = COW_model( ...
                        source, dark_counts, Link_Loss_dB, detector);

                case Protocol.DPS
                    error('Broken, protocol missing...')
            end
        end
   end

end
