classdef protocol

    properties(SetAccess = protected)
        QKD_protocol qkd_protocols;
        source_requirements = {};
        detector_requirements = {};
        efficiency;
    end

    methods

        function protocol = protocol(protoEnum)

            arguments
                protoEnum qkd_protocols
            end

            [rs, rd, eff] = protoEnum.requirements;
            assert(~isempty(rs) | ~isempty(rd), ...
                ['Protocol: \{', string(protoEnum), '\} is not supported']);

            protocol.QKD_protocol = protoEnum;
            protocol.source_requirements = rs;
            protocol.detector_requirements = rd;
            protocol.efficiency = eff;
        end

        function check = compatibleSource(proto, source)

            arguments
                proto protocol
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

            arguments
                proto protocol
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

            arguments
                proto protocol
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
            switch proto.QKD_protocol
                case qkd_protocols.BB84
                    [SKR, QBER, Rate_In, Rate_Det] = BB84_single_photon_model( ...
                         source, dark_counts, Link_Loss_dB, prot_eff, detector);

                case qkd_protocols.DecoyBB84
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

                case qkd_protocols.E91
                    [SKR, QBER, Rate_In, Rate_Det] = ekart92_model( ...
                        source, dark_counts, Link_Loss_dB, prot_eff, detector)

                case qkd_protocols.COW
                    [SKR, QBER, Rate_In, Rate_Det] = COW_model( ...
                        source, dark_counts, Link_Loss_dB, detector)

                case qkd_protocols.DPS
                    error('Broken, protocol missing...')
            end
        end

    end

end
